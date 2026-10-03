import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthError {
  emailTaken,
  noAccount,
  wrongPassword,
  invalidCredentials,
  weakPassword,
  network,
  tooManyRequests,
  providerDisabled,
  googleUnavailable,
  cancelled,
  unknown,
}

class AuthException implements Exception {
  const AuthException(this.error);

  final AuthError error;

  @override
  String toString() => 'AuthException($error)';
}

class AuthUser {
  const AuthUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
}

/// Authentication backend. [FirebaseAuthService] is used on Android/iOS;
/// [LocalAuthService] keeps the app usable where Firebase is unavailable
/// (desktop, tests).
abstract class AuthService {
  AuthUser? get currentUser;

  /// Whether this backend talks to Firebase (cloud sync, password reset).
  bool get isCloud;

  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthUser> signIn(String email, String password);

  Future<AuthUser> signInWithGoogle();

  Future<void> sendPasswordReset(String email);

  Future<void> signOut();
}

class FirebaseAuthService implements AuthService {
  FirebaseAuthService({FirebaseAuth? auth, this.iosClientId})
    : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final String? iosClientId;
  Future<void>? _googleInit;

  @override
  bool get isCloud => true;

  @override
  AuthUser? get currentUser => _map(_auth.currentUser);

  AuthUser? _map(User? user) => user == null
      ? null
      : AuthUser(
          uid: user.uid,
          email: (user.email ?? '${user.uid}@careerverse.app').toLowerCase(),
          displayName: user.displayName,
          photoUrl: user.photoURL,
        );

  Future<AuthUser> _guard(Future<User?> Function() action) async {
    try {
      final user = await action();
      if (user == null) throw const AuthException(AuthError.unknown);
      return _map(user)!;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuth error: ${e.code}');
      throw AuthException(mapFirebaseCode(e.code));
    }
  }

  @visibleForTesting
  static AuthError mapFirebaseCode(String code) => switch (code) {
    'email-already-in-use' ||
    'credential-already-in-use' => AuthError.emailTaken,
    'user-not-found' => AuthError.noAccount,
    'wrong-password' => AuthError.wrongPassword,
    'invalid-credential' ||
    'invalid-login-credentials' => AuthError.invalidCredentials,
    'weak-password' => AuthError.weakPassword,
    'network-request-failed' => AuthError.network,
    'too-many-requests' => AuthError.tooManyRequests,
    'operation-not-allowed' => AuthError.providerDisabled,
    _ => AuthError.unknown,
  };

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
  }) => _guard(() async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await credential.user?.updateDisplayName(name.trim());
    return credential.user;
  });

  @override
  Future<AuthUser> signIn(String email, String password) => _guard(() async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return credential.user;
  });

  @override
  Future<AuthUser> signInWithGoogle() async {
    final google = GoogleSignIn.instance;
    _googleInit ??= google.initialize(
      clientId: !kIsWeb && Platform.isIOS ? iosClientId : null,
    );
    try {
      await _googleInit;
    } catch (e) {
      _googleInit = null;
      debugPrint('Google Sign-In init failed: $e');
      throw const AuthException(AuthError.googleUnavailable);
    }
    if (!google.supportsAuthenticate()) {
      throw const AuthException(AuthError.googleUnavailable);
    }
    final GoogleSignInAccount account;
    try {
      account = await google.authenticate();
    } on GoogleSignInException catch (e) {
      debugPrint('Google Sign-In error: ${e.code} ${e.description}');
      throw AuthException(switch (e.code) {
        GoogleSignInExceptionCode.canceled ||
        GoogleSignInExceptionCode.interrupted => AuthError.cancelled,
        GoogleSignInExceptionCode.clientConfigurationError ||
        GoogleSignInExceptionCode.providerConfigurationError =>
          AuthError.googleUnavailable,
        _ => AuthError.unknown,
      });
    }
    final idToken = account.authentication.idToken;
    if (idToken == null) throw const AuthException(AuthError.googleUnavailable);
    return _guard(() async {
      final credential = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: idToken),
      );
      return credential.user;
    });
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(mapFirebaseCode(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    if (_googleInit != null) {
      try {
        await GoogleSignIn.instance.signOut();
      } catch (_) {}
    }
    await _auth.signOut();
  }
}

/// Device-only accounts (salted SHA-256 hashes in SharedPreferences).
class LocalAuthService implements AuthService {
  LocalAuthService(this._prefs);

  static const accountsKey = 'cv_accounts';
  static const sessionKey = 'cv_session';

  final SharedPreferences _prefs;
  final _random = Random.secure();

  @override
  bool get isCloud => false;

  Map<String, dynamic> get _accounts =>
      jsonDecode(_prefs.getString(accountsKey) ?? '{}') as Map<String, dynamic>;

  String _hash(String salt, String password) =>
      sha256.convert(utf8.encode('$salt:$password')).toString();

  AuthUser _user(String email) => AuthUser(uid: email, email: email);

  @override
  AuthUser? get currentUser {
    final session = _prefs.getString(sessionKey);
    return session == null ? null : _user(session);
  }

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final key = email.trim().toLowerCase();
    final accounts = _accounts;
    if (accounts.containsKey(key)) {
      throw const AuthException(AuthError.emailTaken);
    }
    final salt = base64Url.encode(
      List.generate(16, (_) => _random.nextInt(256)),
    );
    accounts[key] = {'salt': salt, 'hash': _hash(salt, password)};
    await _prefs.setString(accountsKey, jsonEncode(accounts));
    await _prefs.setString(sessionKey, key);
    return _user(key);
  }

  @override
  Future<AuthUser> signIn(String email, String password) async {
    final key = email.trim().toLowerCase();
    final account = _accounts[key] as Map<String, dynamic>?;
    if (account == null) throw const AuthException(AuthError.noAccount);
    if (_hash(account['salt'] as String, password) != account['hash']) {
      throw const AuthException(AuthError.wrongPassword);
    }
    await _prefs.setString(sessionKey, key);
    return _user(key);
  }

  @override
  Future<AuthUser> signInWithGoogle() async =>
      throw const AuthException(AuthError.googleUnavailable);

  @override
  Future<void> sendPasswordReset(String email) async =>
      throw const AuthException(AuthError.providerDisabled);

  @override
  Future<void> signOut() => _prefs.remove(sessionKey);
}
