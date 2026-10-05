import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Everything stored in the cloud for one user.
class CloudSnapshot {
  const CloudSnapshot({
    this.profile,
    this.results = const [],
    this.recommendations = const [],
    this.notifications = const [],
    this.transactions = const [],
    this.courses = const [],
    this.deleted = false,
  });

  final Map<String, dynamic>? profile;
  final bool deleted;
  final List<Map<String, dynamic>> results;
  final List<Map<String, dynamic>> recommendations;
  final List<Map<String, dynamic>> notifications;
  final List<Map<String, dynamic>> transactions;

  /// Completed courses: `{labId, completedAt}`.
  final List<Map<String, dynamic>> courses;
}

/// Cloud copy of the user data. Writes are fire-and-forget: Firestore queues
/// them while offline, and the local Hive store stays the source used by
/// the UI.
abstract class CloudStore {
  /// Returns null when the cloud cannot be reached.
  Future<CloudSnapshot?> load(String uid);

  void saveProfile(String uid, Map<String, dynamic> profile);
  void saveResult(String uid, String id, Map<String, dynamic> result);
  void saveRecommendation(String uid, String id, Map<String, dynamic> data);
  void saveNotification(String uid, String id, Map<String, dynamic> data);

  /// Payment record (write-once in the security rules).
  void saveTransaction(String uid, String id, Map<String, dynamic> data);
  void saveCourse(String uid, String labId, Map<String, dynamic> data);
  void deleteNotifications(String uid, Iterable<String> ids);
  void deleteProgress(
    String uid, {
    required Iterable<String> resultIds,
    required Iterable<String> recommendationIds,
    Iterable<String> courseIds = const [],
  });
}

/// Used when Firebase is not available (desktop, tests).
class NoCloudStore implements CloudStore {
  const NoCloudStore();

  @override
  Future<CloudSnapshot?> load(String uid) async => null;
  @override
  void saveProfile(String uid, Map<String, dynamic> profile) {}
  @override
  void saveResult(String uid, String id, Map<String, dynamic> result) {}
  @override
  void saveRecommendation(String uid, String id, Map<String, dynamic> d) {}
  @override
  void saveNotification(String uid, String id, Map<String, dynamic> d) {}
  @override
  void saveTransaction(String uid, String id, Map<String, dynamic> d) {}
  @override
  void saveCourse(String uid, String labId, Map<String, dynamic> d) {}
  @override
  void deleteNotifications(String uid, Iterable<String> ids) {}
  @override
  void deleteProgress(
    String uid, {
    required Iterable<String> resultIds,
    required Iterable<String> recommendationIds,
    Iterable<String> courseIds = const [],
  }) {}
}

/// Firestore layout:
/// `users/{uid}` (profile) with sub-collections `results`,
/// `recommendations`, `notifications`, `transactions` and `courses`.
class FirestoreService implements CloudStore {
  FirestoreService({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  static const results = 'results';
  static const recommendations = 'recommendations';
  static const notifications = 'notifications';
  static const transactions = 'transactions';
  static const courses = 'courses';

  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> _user(String uid) =>
      _db.collection('users').doc(uid);

  void _run(String label, Future<void> Function() action) {
    unawaited(
      action().catchError(
        (Object e) => debugPrint('Firestore $label failed: $e'),
      ),
    );
  }

  @override
  Future<CloudSnapshot?> load(String uid) async {
    try {
      final user = _user(uid);
      final profileDoc = await user.get().timeout(const Duration(seconds: 8));
      if (profileDoc.data()?['deleted'] == true) {
        return const CloudSnapshot(deleted: true);
      }
      final docs = await Future.wait([
        user.collection(results).get(),
        user.collection(recommendations).get(),
        user.collection(notifications).get(),
        user.collection(transactions).get(),
        user.collection(courses).get(),
      ]).timeout(const Duration(seconds: 8));
      List<Map<String, dynamic>> data(Object snapshot) => [
        for (final doc
            in (snapshot as QuerySnapshot<Map<String, dynamic>>).docs)
          doc.data(),
      ];
      final profile = profileDoc.data()?['profile'];
      return CloudSnapshot(
        profile: profile is Map ? Map<String, dynamic>.from(profile) : null,
        results: data(docs[0]),
        recommendations: data(docs[1]),
        notifications: data(docs[2]),
        transactions: data(docs[3]),
        courses: data(docs[4]),
      );
    } catch (e) {
      debugPrint('Firestore load failed: $e');
      return null;
    }
  }

  @override
  void saveProfile(String uid, Map<String, dynamic> profile) => _run(
    'profile',
    () => _user(uid).set({
      'profile': profile,
      'email': profile['email'],
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)),
  );

  @override
  void saveResult(String uid, String id, Map<String, dynamic> result) =>
      _run('result', () => _user(uid).collection(results).doc(id).set(result));

  @override
  void saveRecommendation(String uid, String id, Map<String, dynamic> data) =>
      _run(
        'recommendation',
        () => _user(uid).collection(recommendations).doc(id).set(data),
      );

  @override
  void saveNotification(String uid, String id, Map<String, dynamic> data) =>
      _run(
        'notification',
        () => _user(uid).collection(notifications).doc(id).set(data),
      );

  /// Also copies the premium end date to `users/{uid}` so the status is
  /// visible in the console.
  @override
  void saveTransaction(String uid, String id, Map<String, dynamic> data) =>
      _run('transaction', () async {
        await _user(uid)
            .collection(transactions)
            .doc(id)
            .set({...data, 'serverTime': FieldValue.serverTimestamp()});
        await _user(
          uid,
        ).set({'premiumUntil': data['premiumUntil']}, SetOptions(merge: true));
      });

  @override
  void saveCourse(String uid, String labId, Map<String, dynamic> data) =>
      _run('course', () => _user(uid).collection(courses).doc(labId).set(data));

  @override
  void deleteNotifications(String uid, Iterable<String> ids) =>
      _run('delete notifications', () {
        final batch = _db.batch();
        for (final id in ids) {
          batch.delete(_user(uid).collection(notifications).doc(id));
        }
        return batch.commit();
      });

  @override
  void deleteProgress(
    String uid, {
    required Iterable<String> resultIds,
    required Iterable<String> recommendationIds,
    Iterable<String> courseIds = const [],
  }) => _run('reset progress', () {
    final batch = _db.batch();
    for (final id in resultIds) {
      batch.delete(_user(uid).collection(results).doc(id));
    }
    for (final id in recommendationIds) {
      batch.delete(_user(uid).collection(recommendations).doc(id));
    }
    for (final id in courseIds) {
      batch.delete(_user(uid).collection(courses).doc(id));
    }
    return batch.commit();
  });
}
