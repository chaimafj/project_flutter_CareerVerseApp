import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/catalog.dart';
import '../data/managed_catalog.dart';
import '../models/managed_career.dart';
import '../models/user_profile.dart';

class AdminStudent {
  const AdminStudent({required this.uid, required this.profile});

  final String uid;
  final UserProfile profile;
}

class AdminStatistics {
  const AdminStatistics({
    required this.students,
    required this.attempts,
    required this.average,
  });

  final int students;
  final int attempts;
  final double? average;

  factory AdminStatistics.fromRecords(
    Iterable<Map<String, dynamic>> records, {
    required int students,
  }) {
    final scores = <double>[];
    for (final record in records) {
      final score = record['score'];
      if (score is! num || !score.isFinite || score < 0 || score > 100) {
        throw const FormatException('Invalid stored simulation score');
      }
      scores.add(score.toDouble());
    }
    return AdminStatistics(
      students: students,
      attempts: scores.length,
      average: scores.isEmpty
          ? null
          : scores.reduce((a, b) => a + b) / scores.length,
    );
  }
}

/// Authorization comes exclusively from /admins/{Firebase UID}, a document
/// writable only through trusted Firebase tooling, never from the mobile app.
class AdminProvider extends ChangeNotifier {
  AdminProvider(this._prefs, {bool enabled = false, this._onCatalogChanged}) {
    _restoreCatalogue();
    if (enabled) {
      _db = FirebaseFirestore.instance;
      _authSubscription = FirebaseAuth.instance.authStateChanges().listen(
        _sessionChanged,
      );
    }
  }

  static const _cacheKey = 'managed_career_catalog_v1';
  final SharedPreferences _prefs;
  final VoidCallback? _onCatalogChanged;
  FirebaseFirestore? _db;
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _roleSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _catalogSubscription;
  String? _uid;
  bool _isAdmin = false;
  String? _error;
  bool get isAdmin => _isAdmin;
  String? get error => _error;

  void _restoreCatalogue() {
    final cached = _prefs.getString(_cacheKey);
    if (cached == null) return;
    try {
      _applyCatalog(jsonDecode(cached) as List);
    } on FormatException catch (error) {
      _report(error);
    } on TypeError catch (error) {
      _report(error);
    }
  }

  void _report(Object error) {
    debugPrint('Admin/catalog operation failed: $error');
    _error = error.toString();
    notifyListeners();
  }

  void _sessionChanged(User? user) {
    _roleSubscription?.cancel();
    _catalogSubscription?.cancel();
    _uid = user?.uid;
    _isAdmin = false;
    _error = null;
    notifyListeners();
    if (user == null) return;
    final db = _db!;
    _roleSubscription = db
        .collection('admins')
        .doc(user.uid)
        .snapshots()
        .listen(
          (document) {
            if (_uid != user.uid) return;
            _isAdmin = document.exists && document.data()?['active'] == true;
            notifyListeners();
          },
          onError: (Object error) {
            if (_uid != user.uid) return;
            _isAdmin = false;
            _report(error);
          },
        );
    _catalogSubscription = db.collection('catalog').snapshots().listen((
      snapshot,
    ) async {
      if (_uid != user.uid) return;
      final records = snapshot.docs.map((doc) => doc.data()).toList();
      try {
        _applyCatalog(records);
        await _prefs.setString(_cacheKey, jsonEncode(records));
      } on FormatException catch (error) {
        _report(error);
      } on TypeError catch (error) {
        _report(error);
      }
    }, onError: _report);
  }

  void _applyCatalog(List<dynamic> records) {
    final validated = [
      for (final record in records)
        ManagedCareer.fromJson(ManagedCareer.object(record)),
    ];
    final ids = <String>{};
    for (final career in validated) {
      if (!ids.add(career.id)) {
        throw const FormatException('Duplicate career IDs');
      }
    }
    managedCareers
      ..clear()
      ..addEntries(validated.map((career) => MapEntry(career.id, career)));
    _error = null;
    _onCatalogChanged?.call();
    notifyListeners();
  }

  FirebaseFirestore _authorizedDb() {
    if (!_isAdmin || _uid == null || _db == null) {
      throw StateError('Administrator access required');
    }
    return _db!;
  }

  Future<void> saveCareer(ManagedCareer career) async {
    final db = _authorizedDb();
    ManagedCareer.fromJson(career.toJson());
    final existing = careerById(career.id);
    if (existing != null) {
      final next = career.career('en');
      final oldIds = existing.labs.map((lab) => lab.id).toList();
      final nextIds = next.labs
          .map((lab) => lab.id)
          .take(oldIds.length)
          .toList();
      if (!listEquals(oldIds, nextIds)) {
        throw const FormatException(
          'Existing lab IDs and order cannot change; archive the career instead.',
        );
      }
    }
    await db.collection('catalog').doc(career.id).set(career.toJson());
  }

  Future<List<AdminStudent>> students() async {
    final snapshot = await _authorizedDb().collection('users').get();
    return [
      for (final doc in snapshot.docs)
        if (doc.data()['profile'] is Map)
          AdminStudent(
            uid: doc.id,
            profile: UserProfile.fromJson(
              ManagedCareer.object(doc.data()['profile']),
            ),
          ),
    ];
  }

  Future<void> saveStudent(AdminStudent student) async {
    await _authorizedDb().collection('users').doc(student.uid).update({
      'profile': student.profile.copyWith(updatedAt: DateTime.now()).toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<AdminStatistics> statistics() async {
    final db = _authorizedDb();
    final users = await db.collection('users').get();
    final results = await db.collectionGroup('results').get();
    return AdminStatistics.fromRecords(
      results.docs.map((doc) => doc.data()),
      students: users.docs.where((doc) => doc.data()['profile'] is Map).length,
    );
  }

  Future<AdminStatistics> studentStatistics(String uid) async {
    final results = await _authorizedDb()
        .collection('users')
        .doc(uid)
        .collection('results')
        .get();
    return AdminStatistics.fromRecords(
      results.docs.map((doc) => doc.data()),
      students: 1,
    );
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _roleSubscription?.cancel();
    _catalogSubscription?.cancel();
    super.dispose();
  }
}
