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
    final deleted = <String>{};
    final deletedLabs = <String>{};
    final validated = [
      for (final record in records)
        if (ManagedCareer.object(record)['deleted'] != true)
          ManagedCareer.fromJson(ManagedCareer.object(record)),
    ];
    for (final record in records) {
      final data = ManagedCareer.object(record);
      if (data['deleted'] == true) {
        deleted.add(ManagedCareer.text(data['id']));
        deletedLabs.addAll(ManagedCareer.strings(data['labIds']));
      }
    }
    final ids = <String>{};
    for (final career in validated) {
      if (!ids.add(career.id)) {
        throw const FormatException('Duplicate career IDs');
      }
    }
    managedCareers
      ..clear()
      ..addEntries(validated.map((career) => MapEntry(career.id, career)));
    deletedCareerIds
      ..clear()
      ..addAll(deleted);
    deletedLabIds
      ..clear()
      ..addAll(deletedLabs);
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
    if (deletedCareerIds.contains(career.id)) {
      throw StateError('This career ID has been permanently deleted');
    }
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

  Future<void> _deleteDocuments(
    Iterable<DocumentReference<Map<String, dynamic>>> references,
  ) async {
    final docs = references.toList();
    for (var start = 0; start < docs.length; start += 400) {
      final batch = _authorizedDb().batch();
      for (final ref in docs.skip(start).take(400)) {
        batch.delete(ref);
      }
      await batch.commit();
    }
  }

  Future<void> deleteStudent(String uid) async {
    final db = _authorizedDb();
    final role = await db.collection('admins').doc(uid).get();
    if (uid == _uid || role.data()?['active'] == true) {
      throw StateError('Administrator profiles cannot be deleted');
    }
    final user = db.collection('users').doc(uid);
    // The marker blocks offline clients from uploading the deleted data again.
    await user.set({'deleted': true, 'cleanupPending': true});
    for (final name in [
      'results',
      'recommendations',
      'notifications',
      'transactions',
      'courses',
    ]) {
      final snapshot = await user.collection(name).get();
      await _deleteDocuments(snapshot.docs.map((doc) => doc.reference));
    }
    await user.set({'deleted': true, 'cleanupPending': false});
  }

  Future<void> deleteCareer(String id) async {
    final db = _authorizedDb();
    final document = db.collection('catalog').doc(id);
    final stored = await document.get();
    final career = careerById(id);
    final labs = stored.data()?['deleted'] == true
        ? ManagedCareer.strings(stored.data()!['labIds'])
        : career?.labs.map((lab) => lab.id).toList();
    if (labs == null) throw StateError('Career not found');
    final batch = db.batch();
    batch.set(document, {
      'id': id,
      'deleted': true,
      'labIds': labs,
      'cleanupPending': true,
    });
    for (final labId in labs) {
      batch.set(db.collection('deletedLabs').doc(labId), {'deleted': true});
    }
    await batch.commit();
    final users = await db.collection('users').get();
    for (final user in users.docs) {
      final resultIds = <String>{};
      final refs = <DocumentReference<Map<String, dynamic>>>[];
      for (final name in [
        'results',
        'recommendations',
        'courses',
        'notifications',
      ]) {
        final records = await user.reference.collection(name).get();
        for (final record in records.docs) {
          final data = record.data();
          if (referencesCareer(data, id, labs.toSet(), resultIds)) {
            refs.add(record.reference);
            if (name == 'results') resultIds.add(record.id);
          }
        }
      }
      await _deleteDocuments(refs);
    }
    await document.set({
      'id': id,
      'deleted': true,
      'labIds': labs,
      'cleanupPending': false,
    });
  }

  Future<void> retryDeletions() async {
    final db = _authorizedDb();
    final users = await db.collection('users').get();
    for (final user in users.docs) {
      if (user.data()['deleted'] == true &&
          user.data()['cleanupPending'] == true) {
        await deleteStudent(user.id);
      }
    }
    final catalog = await db.collection('catalog').get();
    for (final career in catalog.docs) {
      if (career.data()['deleted'] == true &&
          career.data()['cleanupPending'] == true) {
        await deleteCareer(career.id);
      }
    }
  }

  static bool referencesCareer(
    Map<String, dynamic> data,
    String careerId,
    Set<String> labIds,
    Set<String> resultIds,
  ) {
    final notificationData = data['data'] is Map
        ? ManagedCareer.object(data['data'])
        : const <String, dynamic>{};
    return data['careerId'] == careerId ||
        labIds.contains(data['labId']) ||
        labIds.contains(notificationData['labId']) ||
        notificationData['topCareerId'] == careerId ||
        resultIds.contains(data['resultId']);
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
