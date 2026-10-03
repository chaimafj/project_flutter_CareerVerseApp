import 'package:careerverseapp/app.dart';
import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/services/auth_service.dart';
import 'package:careerverseapp/services/firestore_service.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:careerverseapp/services/notification_service.dart';
import 'package:careerverseapp/screens/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget_test.dart' show buildApp;

/// Firebase-like auth: one uid per email, shared by every "device".
class FakeCloudAuth implements AuthService {
  FakeCloudAuth(this.accounts);

  final Map<String, String> accounts;
  AuthUser? _current;

  @override
  bool get isCloud => true;

  @override
  AuthUser? get currentUser => _current;

  AuthUser _user(String email) => AuthUser(uid: 'uid-$email', email: email);

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (accounts.containsKey(email)) {
      throw const AuthException(AuthError.emailTaken);
    }
    accounts[email] = password;
    return _current = _user(email);
  }

  @override
  Future<AuthUser> signIn(String email, String password) async {
    if (accounts[email] != password) {
      throw const AuthException(AuthError.invalidCredentials);
    }
    return _current = _user(email);
  }

  @override
  Future<AuthUser> signInWithGoogle() async => _current = AuthUser(
    uid: 'uid-google',
    email: 'g@gmail.com',
    displayName: 'Google User',
    photoUrl: 'https://example.com/me.png',
  );

  @override
  Future<void> sendPasswordReset(String email) async {}

  @override
  Future<void> signOut() async => _current = null;
}

/// In-memory Firestore stand-in.
class MemoryCloudStore implements CloudStore {
  final users = <String, Map<String, dynamic>>{};
  final docs = <String, Map<String, Map<String, dynamic>>>{};
  bool offline = false;

  Map<String, Map<String, dynamic>> _col(String uid, String name) =>
      docs.putIfAbsent('$uid/$name', () => {});

  @override
  Future<CloudSnapshot?> load(String uid) async {
    if (offline) return null;
    return CloudSnapshot(
      profile: users[uid],
      results: _col(uid, 'results').values.toList(),
      recommendations: _col(uid, 'recommendations').values.toList(),
      notifications: _col(uid, 'notifications').values.toList(),
      transactions: _col(uid, 'transactions').values.toList(),
      courses: _col(uid, 'courses').values.toList(),
    );
  }

  @override
  void saveProfile(String uid, Map<String, dynamic> profile) {
    if (!offline) users[uid] = profile;
  }

  @override
  void saveResult(String uid, String id, Map<String, dynamic> result) {
    if (!offline) _col(uid, 'results')[id] = result;
  }

  @override
  void saveRecommendation(String uid, String id, Map<String, dynamic> d) {
    if (!offline) _col(uid, 'recommendations')[id] = d;
  }

  @override
  void saveNotification(String uid, String id, Map<String, dynamic> d) {
    if (!offline) _col(uid, 'notifications')[id] = d;
  }

  @override
  void saveTransaction(String uid, String id, Map<String, dynamic> d) {
    if (!offline) _col(uid, 'transactions')[id] = d;
  }

  @override
  void saveCourse(String uid, String labId, Map<String, dynamic> d) {
    if (!offline) _col(uid, 'courses')[labId] = d;
  }

  @override
  void deleteNotifications(String uid, Iterable<String> ids) =>
      ids.forEach(_col(uid, 'notifications').remove);
  @override
  void deleteProgress(
    String uid, {
    required Iterable<String> resultIds,
    required Iterable<String> recommendationIds,
    Iterable<String> courseIds = const [],
  }) {
    resultIds.forEach(_col(uid, 'results').remove);
    recommendationIds.forEach(_col(uid, 'recommendations').remove);
    courseIds.forEach(_col(uid, 'courses').remove);
  }
}

List<Set<int>> perfectAnswers(String labId) =>
    findLab(labId)!.$2.questions.map((q) => q.correct).toList();

Future<void> finishLab(AppState state, String labId) async {
  final (career, lab) = findLab(labId)!;
  await state.recordResult(
    career: career,
    lab: lab,
    answers: perfectAnswers(labId),
    durationSeconds: 60,
  );
}

void main() {
  late SharedPreferences prefs;
  late Map<String, String> accounts;
  late MemoryCloudStore cloud;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    accounts = {};
    cloud = MemoryCloudStore();
  });

  AppState device(LocalStore store) =>
      AppState(prefs, store, auth: FakeCloudAuth(accounts), cloud: cloud);

  test('register and lab results are written to the cloud', () async {
    final state = device(MemoryLocalStore());
    expect(
      await state.register(name: 'Sara', email: 'sara@x.com', password: 'p'),
      isNull,
    );
    await finishLab(state, 'cloud-1');

    const uid = 'uid-sara@x.com';
    expect(cloud.users[uid]!['name'], 'Sara');
    final results = cloud.docs['$uid/results']!.values.toList();
    expect(results, hasLength(1));
    expect(results.single['score'], state.results.single.overall);
    expect(results.single['durationSeconds'], 60);
    expect(cloud.docs['$uid/recommendations'], hasLength(1));
    // Welcome + "Your recommendations are ready!"
    expect(cloud.docs['$uid/notifications'], hasLength(2));
  });

  test('a second device restores the cloud data on login', () async {
    final phone = device(MemoryLocalStore());
    await phone.register(name: 'Sara', email: 'sara@x.com', password: 'p');
    await finishLab(phone, 'cloud-1');
    await phone.updateProfile(phone.profile.copyWith(university: 'ESPRIT'));
    await phone.markAllRead();

    final tablet = device(MemoryLocalStore());
    expect(await tablet.login('sara@x.com', 'p'), isNull);
    expect(tablet.profile.name, 'Sara');
    expect(tablet.profile.university, 'ESPRIT');
    expect(tablet.results.map((r) => r.id), [phone.results.single.id]);
    expect(tablet.recommendationHistory, hasLength(1));
    // No duplicated welcome notification, read state is kept.
    expect(tablet.notifications, hasLength(2));
    expect(tablet.unreadCount, 0);
    expect(tablet.isCompleted('cloud-1'), isTrue);
  });

  test('labs finished while offline are uploaded at next sync', () async {
    final store = MemoryLocalStore();
    final state = device(store);
    await state.register(name: 'Sara', email: 'sara@x.com', password: 'p');
    cloud.docs.clear(); // simulate writes that never reached the server
    cloud.offline = true;
    await state.logout();
    expect(await state.login('sara@x.com', 'p'), isNull);
    await finishLab(state, 'cloud-1');

    cloud.offline = false;
    final reopened = device(store);
    await reopened.login('sara@x.com', 'p');
    expect(cloud.docs['uid-sara@x.com/results'], hasLength(1));
    expect(reopened.results, hasLength(1));
  });

  test('wrong credentials and reset progress', () async {
    final state = device(MemoryLocalStore());
    await state.register(name: 'Sara', email: 'sara@x.com', password: 'p');
    await finishLab(state, 'cloud-1');
    await state.logout();
    expect(
      await state.login('sara@x.com', 'bad'),
      AuthError.invalidCredentials,
    );
    await state.login('sara@x.com', 'p');
    await state.resetProgress();
    expect(cloud.docs['uid-sara@x.com/results'], isEmpty);
    expect(cloud.docs['uid-sara@x.com/recommendations'], isEmpty);
  });

  test('Google sign-in creates a profile with the account photo', () async {
    final state = device(MemoryLocalStore());
    expect(await state.signInWithGoogle(), isNull);
    expect(state.profile.name, 'Google User');
    expect(state.profile.photoUrl, 'https://example.com/me.png');
    expect(state.notifications, hasLength(1));
    expect(cloud.users['uid-google']!['email'], 'g@gmail.com');
  });

  test('Firebase error codes map to user messages', () {
    expect(
      FirebaseAuthService.mapFirebaseCode('email-already-in-use'),
      AuthError.emailTaken,
    );
    expect(
      FirebaseAuthService.mapFirebaseCode('invalid-credential'),
      AuthError.invalidCredentials,
    );
    expect(
      FirebaseAuthService.mapFirebaseCode('network-request-failed'),
      AuthError.network,
    );
    expect(FirebaseAuthService.mapFirebaseCode('???'), AuthError.unknown);
  });

  testWidgets('tapping a result notification opens the results', (
    tester,
  ) async {
    final state = AppState(prefs, MemoryLocalStore());
    await state.register(name: 'Sara', email: 'sara@x.com', password: 'p');
    await finishLab(state, 'cloud-1');
    final notification = state.notifications.first;
    expect(notification.read, isFalse);

    await tester.pumpWidget(buildApp(prefs, state));
    await tester.pumpAndSettle();
    final context = appNavigatorKey.currentContext!;
    context.read<NotificationService>().openData({
      'resultId': state.results.single.id,
      'notificationId': notification.id,
    });
    await tester.pumpAndSettle();

    expect(find.byType(ResultsScreen), findsOneWidget);
    expect(find.byKey(const Key('lottie-success')), findsOneWidget);
    expect(state.notifications.first.read, isTrue);
  });
}
