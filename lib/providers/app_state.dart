import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/catalog.dart';
import '../data/managed_catalog.dart';
import '../models/app_notification.dart';
import '../models/career.dart';
import '../models/lab_result.dart';
import '../models/payment_transaction.dart';
import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/local_store.dart';
import '../services/payment_service.dart';

export '../services/auth_service.dart' show AuthError;

class CareerMatch {
  const CareerMatch({
    required this.career,
    required this.score,
    required this.tested,
    required this.labsDone,
    required this.sharedInterests,
    this.performance,
    this.strongestSkill,
  });

  final Career career;
  final int score;
  final bool tested;

  /// Data used by the UI to explain the match in the current language.
  final int? performance;
  final int labsDone;
  final String? strongestSkill;
  final List<String> sharedInterests;
}

class RecommendationSnapshot {
  const RecommendationSnapshot({
    required this.careerId,
    required this.score,
    required this.createdAt,
  });

  final String careerId;
  final int score;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'careerId': careerId,
    'score': score,
    'createdAt': createdAt.toIso8601String(),
  };

  factory RecommendationSnapshot.fromJson(Map<String, dynamic> json) =>
      RecommendationSnapshot(
        careerId: json['careerId'] as String,
        score: json['score'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}

/// Local-first application state. The UI always reads the offline
/// [LocalStore] (Hive). With a Firebase account, every change is also written
/// to Firestore through [CloudStore], and cloud data is merged at sign-in so
/// progress follows the user across devices.
class AppState extends ChangeNotifier {
  AppState(
    this._prefs,
    this._store, {
    AuthService? auth,
    this._cloud = const NoCloudStore(),
  }) : _auth = auth ?? LocalAuthService(_prefs) {
    final user = _auth.currentUser;
    if (user != null) {
      _openLocal(user);
      unawaited(_syncWithCloud());
    }
  }

  final SharedPreferences _prefs;
  final LocalStore _store;
  final AuthService _auth;
  final CloudStore _cloud;
  final _random = Random.secure();

  AuthUser? _user;
  UserProfile? _profile;
  List<LabResult> _results = [];
  List<AppNotification> _notifications = [];
  List<RecommendationSnapshot> _history = [];
  List<PaymentTransaction> _transactions = [];

  /// Completed courses: lab id ? completion date.
  Map<String, DateTime> _courses = {};

  /// Welcome notification created for a profile that did not exist locally;
  /// dropped if the cloud already has this user's data.
  String? _localWelcomeId;

  bool get isLoggedIn => _profile != null;
  void catalogChanged() {
    _pruneDeletedContent();
    if (_profile != null) unawaited(_saveAll());
    notifyListeners();
  }

  void _pruneDeletedContent() {
    final removedResults = _results.where((r) => deletedCareerIds.contains(r.careerId)
      || deletedLabIds.contains(r.labId)).map((r) => r.id).toSet();
    _results.removeWhere((r) => removedResults.contains(r.id));
    _history.removeWhere((h) => deletedCareerIds.contains(h.careerId));
    _courses.removeWhere((id, _) => deletedLabIds.contains(id));
    _notifications.removeWhere((n) =>
      removedResults.contains(n.resultId) ||
      deletedLabIds.contains(n.data['labId']) ||
      deletedCareerIds.contains(n.data['topCareerId']));
  }
  UserProfile get profile => _profile!;
  List<LabResult> get results => List.unmodifiable(_results);
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  List<RecommendationSnapshot> get recommendationHistory =>
      List.unmodifiable(_history);
  int get unreadCount => _notifications.where((n) => !n.read).length;
  List<PaymentTransaction> get transactions => List.unmodifiable(_transactions);

  /// True when the account is a Firebase account synced with Firestore.
  bool get isCloudAccount => _auth.isCloud;

  // ---------------------------------------------------------------- Auth

  String _newId() =>
      '${DateTime.now().microsecondsSinceEpoch}${_random.nextInt(9999)}';

  AppNotification _welcome() => AppNotification(
    id: _newId(),
    kind: NotificationKind.welcome,
    createdAt: DateTime.now(),
  );

  /// Returns an error, or null on success.
  Future<AuthError?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final AuthUser user;
    try {
      user = await _auth.register(name: name, email: email, password: password);
    } on AuthException catch (e) {
      return e.error;
    }
    final now = DateTime.now();
    _user = user;
    _localWelcomeId = null;
    _profile = UserProfile(
      name: name.trim(),
      email: user.email,
      createdAt: now,
      updatedAt: now,
    );
    _results = [];
    _history = [];
    _transactions = [];
    _courses = {};
    _notifications = [_welcome()];
    await _saveAll();
    _pushToCloud(null);
    notifyListeners();
    return null;
  }

  Future<AuthError?> login(String email, String password) =>
      _signIn(() => _auth.signIn(email, password));

  /// Returns [AuthError.cancelled] when the user closes the Google dialog.
  Future<AuthError?> signInWithGoogle() => _signIn(_auth.signInWithGoogle);

  Future<AuthError?> _signIn(Future<AuthUser> Function() action) async {
    final AuthUser user;
    try {
      user = await action();
    } on AuthException catch (e) {
      return e.error;
    }
    _openLocal(user);
    await _syncWithCloud(notify: false);
    notifyListeners();
    return _profile == null ? AuthError.noAccount : null;
  }

  Future<AuthError?> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordReset(email);
      return null;
    } on AuthException catch (e) {
      return e.error;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _profile = null;
    _results = [];
    _notifications = [];
    _history = [];
    _transactions = [];
    _courses = {};
    notifyListeners();
  }

  /// Loads this device's copy of the user's data. A missing profile is
  /// created from the account (name and Google photo).
  void _openLocal(AuthUser user) {
    _user = user;
    _localWelcomeId = null;
    final email = user.email;
    _migrateLegacyData(email);
    _results = _readList(LocalStore.labResults, email, LabResult.fromJson);
    _notifications = _readList(
      LocalStore.notifications,
      email,
      AppNotification.fromJson,
    );
    _history = _readList(
      LocalStore.recommendations,
      email,
      RecommendationSnapshot.fromJson,
    );
    _transactions = _readList(
      LocalStore.transactions,
      email,
      PaymentTransaction.fromJson,
    );
    _courses = {
      for (final json in _readList(LocalStore.courses, email, (j) => j))
        if (_courseEntry(json) case final entry?) entry.key: entry.value,
    };
    final stored = _store.read(LocalStore.profiles, email);
    if (stored is Map<String, dynamic>) {
      final profile = UserProfile.fromJson(stored);
      _profile = profile.photoUrl == null && user.photoUrl != null
          ? profile.copyWith(photoUrl: user.photoUrl)
          : profile;
      _pruneDeletedContent();
      return;
    }
    final name = user.displayName?.trim();
    _profile = UserProfile(
      name: name == null || name.isEmpty ? email.split('@').first : name,
      email: email,
      photoUrl: user.photoUrl,
      createdAt: DateTime.now(),
    );
    final welcome = _welcome();
    _localWelcomeId = welcome.id;
    _notifications.insert(0, welcome);
    unawaited(_saveAll());
  }

  /// Merges the Firestore copy into the local data, then uploads what the
  /// cloud is missing (e.g. labs done offline or before using Firebase).
  Future<void> _syncWithCloud({bool notify = true}) async {
    final user = _user;
    if (user == null || !_auth.isCloud) return;
    final cloud = await _cloud.load(user.uid);
    if (cloud == null || _user?.uid != user.uid) return;
    if (cloud.deleted) {
      debugPrint('Student Firestore data was deleted by an administrator');
      for (final collection in LocalStore.collections) {
        await _store.delete(collection, user.email);
      }
      await logout();
      return;
    }
    _merge(cloud);
    _pruneDeletedContent();
    await _saveAll();
    _pushToCloud(cloud);
    if (notify) notifyListeners();
  }

  void _merge(CloudSnapshot cloud) {
    final remoteJson = cloud.profile;
    if (remoteJson != null) {
      final remote = UserProfile.fromJson(remoteJson);
      final local = _profile;
      final localTime = local?.updatedAt;
      final remoteTime = remote.updatedAt;
      if (local == null ||
          localTime == null ||
          (remoteTime != null && remoteTime.isAfter(localTime))) {
        _profile = remote.photoUrl == null && local?.photoUrl != null
            ? remote.copyWith(photoUrl: local!.photoUrl)
            : remote;
      }
      final welcomeId = _localWelcomeId;
      if (welcomeId != null) {
        _notifications.removeWhere((n) => n.id == welcomeId);
        _localWelcomeId = null;
      }
    }

    final resultIds = {for (final r in _results) r.id};
    for (final json in cloud.results) {
      final result = LabResult.fromJson(json);
      if (resultIds.add(result.id)) _results.add(result);
    }
    _results.sort((a, b) => b.completedAt.compareTo(a.completedAt));

    final historyIds = {for (final h in _history) _historyId(h)};
    for (final json in cloud.recommendations) {
      final snapshot = RecommendationSnapshot.fromJson(json);
      if (historyIds.add(_historyId(snapshot))) _history.add(snapshot);
    }
    _history.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final byId = {for (final n in _notifications) n.id: n};
    for (final json in cloud.notifications) {
      final remote = AppNotification.fromJson(json);
      final local = byId[remote.id];
      if (local == null) {
        byId[remote.id] = remote;
      } else if (remote.read && !local.read) {
        byId[remote.id] = local.markRead();
      }
    }
    _notifications = byId.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final transactionIds = {for (final t in _transactions) t.id};
    for (final json in cloud.transactions) {
      final transaction = PaymentTransaction.fromJson(json);
      if (transactionIds.add(transaction.id)) _transactions.add(transaction);
    }
    _transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    for (final json in cloud.courses) {
      final entry = _courseEntry(json);
      if (entry != null) _courses.putIfAbsent(entry.key, () => entry.value);
    }
  }

  /// Uploads local data that [cloud] does not contain (everything when
  /// [cloud] is null).
  void _pushToCloud(CloudSnapshot? cloud) {
    _pruneDeletedContent();
    final uid = _cloudUid;
    final profile = _profile;
    if (uid == null || profile == null) return;
    final remoteProfile = cloud?.profile;
    if (remoteProfile == null ||
        !_sameProfile(UserProfile.fromJson(remoteProfile), profile)) {
      _cloud.saveProfile(uid, profile.toJson());
    }
    final remoteResults = {
      for (final r in cloud?.results ?? const <Map<String, dynamic>>[]) r['id'],
    };
    for (final result in _results) {
      if (!remoteResults.contains(result.id)) {
        _cloud.saveResult(uid, result.id, _resultCloudJson(result));
      }
    }
    final remoteHistory = {
      for (final h in cloud?.recommendations ?? const <Map<String, dynamic>>[])
        _historyId(RecommendationSnapshot.fromJson(h)),
    };
    for (final snapshot in _history) {
      final id = _historyId(snapshot);
      if (!remoteHistory.contains(id)) {
        _cloud.saveRecommendation(uid, id, snapshot.toJson());
      }
    }
    final remoteNotifications = {
      for (final n in cloud?.notifications ?? const <Map<String, dynamic>>[])
        n['id']: n['read'] == true,
    };
    for (final n in _notifications) {
      if (remoteNotifications[n.id] != n.read) {
        _cloud.saveNotification(uid, n.id, n.toJson());
      }
    }
    final remoteTransactions = {
      for (final t in cloud?.transactions ?? const <Map<String, dynamic>>[])
        t['id'],
    };
    for (final t in _transactions) {
      if (!remoteTransactions.contains(t.id)) {
        _cloud.saveTransaction(uid, t.id, t.toJson());
      }
    }
    final remoteCourses = {
      for (final c in cloud?.courses ?? const <Map<String, dynamic>>[])
        c['labId'],
    };
    _courses.forEach((labId, date) {
      if (!remoteCourses.contains(labId)) {
        _cloud.saveCourse(uid, labId, _courseJson(labId, date));
      }
    });
  }

  static Map<String, dynamic> _courseJson(String labId, DateTime date) => {
    'labId': labId,
    'completedAt': date.toIso8601String(),
  };

  static MapEntry<String, DateTime>? _courseEntry(Map<String, dynamic> json) {
    final labId = json['labId'];
    final date = DateTime.tryParse(json['completedAt'] as String? ?? '');
    return labId is String && date != null ? MapEntry(labId, date) : null;
  }

  bool _sameProfile(UserProfile a, UserProfile b) =>
      jsonEncode(a.toJson()) == jsonEncode(b.toJson());

  String? get _cloudUid => _auth.isCloud ? _user?.uid : null;

  static String _historyId(RecommendationSnapshot snapshot) =>
      snapshot.createdAt.microsecondsSinceEpoch.toString();

  /// Result document stored in Firestore: the full result plus the overall
  /// score, so scores and time spent are readable in the console.
  Map<String, dynamic> _resultCloudJson(LabResult result) => {
    ...result.toJson(),
    'score': result.overall,
  };

  List<T> _readList<T>(
    String collection,
    String email,
    T Function(Map<String, dynamic>) fromJson,
  ) => [
    for (final item in _store.read(collection, email) as List? ?? const [])
      fromJson(item as Map<String, dynamic>),
  ];

  /// Moves data saved by older versions (one SharedPreferences blob per
  /// user) into the offline database.
  void _migrateLegacyData(String email) {
    final legacyKey = 'cv_user_$email';
    final raw = _prefs.getString(legacyKey);
    if (raw == null) return;
    final data = jsonDecode(raw) as Map<String, dynamic>;
    _store.write(LocalStore.profiles, email, data['profile']);
    _store.write(LocalStore.labResults, email, data['results'] ?? []);
    _store.write(LocalStore.notifications, email, data['notifications'] ?? []);
    _store.write(LocalStore.recommendations, email, data['history'] ?? []);
    _prefs.remove(legacyKey);
  }

  String get _owner => _profile!.email;

  Future<void> _saveProfile() =>
      _store.write(LocalStore.profiles, _owner, _profile!.toJson());

  Future<void> _saveResults() => _store.write(
    LocalStore.labResults,
    _owner,
    _results.map((r) => r.toJson()).toList(),
  );

  Future<void> _saveHistory() => _store.write(
    LocalStore.recommendations,
    _owner,
    _history.map((h) => h.toJson()).toList(),
  );

  Future<void> _saveNotifications() => _store.write(
    LocalStore.notifications,
    _owner,
    _notifications.map((n) => n.toJson()).toList(),
  );

  Future<void> _saveAll() async {
    await _saveProfile();
    await _saveResults();
    await _saveHistory();
    await _saveNotifications();
    await _saveTransactions();
    await _saveCourses();
  }

  Future<void> _saveCourses() => _store.write(LocalStore.courses, _owner, [
    for (final e in _courses.entries) _courseJson(e.key, e.value),
  ]);

  Future<void> _saveTransactions() => _store.write(
    LocalStore.transactions,
    _owner,
    _transactions.map((t) => t.toJson()).toList(),
  );

  // ------------------------------------------------------------- Premium

  /// End of the current Premium access, or null if it never existed.
  DateTime? get premiumUntil {
    DateTime? until;
    for (final t in _transactions) {
      if (t.status != 'succeeded') continue;
      if (until == null || t.premiumUntil.isAfter(until)) {
        until = t.premiumUntil;
      }
    }
    return until;
  }

  bool get isPremium {
    final until = premiumUntil;
    return until != null && until.isAfter(DateTime.now());
  }

  bool isLabLocked(Lab lab) => lab.isPremium && !isPremium;

  /// Pays [plan] with [payments] and extends Premium access. Returns the
  /// recorded transaction; throws [PaymentException] on failure.
  Future<PaymentTransaction> buyPremium(
    PaymentService payments, {
    PremiumPlan plan = PremiumPlan.monthly,
    ThemeMode style = ThemeMode.system,
  }) async {
    final receipt = await payments.pay(
      plan: plan,
      uid: _user?.uid ?? _owner,
      email: _owner,
      style: style,
    );
    final now = DateTime.now();
    final current = premiumUntil;
    final start = current != null && current.isAfter(now) ? current : now;
    final transaction = PaymentTransaction(
      id: receipt.id,
      plan: plan.id,
      amountCents: receipt.amountCents,
      currency: receipt.currency,
      status: receipt.status,
      createdAt: now,
      premiumUntil: start.add(Duration(days: plan.days)),
      cardBrand: receipt.cardBrand,
      cardLast4: receipt.cardLast4,
    );
    _transactions.insert(0, transaction);
    _notifications.insert(
      0,
      AppNotification(
        id: _newId(),
        kind: NotificationKind.premium,
        data: {'until': transaction.premiumUntil.toIso8601String()},
        createdAt: now,
      ),
    );
    await _saveTransactions();
    await _saveNotifications();
    final uid = _cloudUid;
    if (uid != null) {
      _cloud.saveTransaction(uid, transaction.id, transaction.toJson());
      _cloud.saveNotification(
        uid,
        _notifications.first.id,
        _notifications.first.toJson(),
      );
    }
    notifyListeners();
    return transaction;
  }

  // ------------------------------------------------------------- Profile

  Future<void> updateProfile(UserProfile profile) async {
    _profile = profile.copyWith(updatedAt: DateTime.now());
    await _saveProfile();
    final uid = _cloudUid;
    if (uid != null) _cloud.saveProfile(uid, _profile!.toJson());
    notifyListeners();
  }

  // ------------------------------------------------------------- Results

  Future<LabResult> recordResult({
    required Career career,
    required Lab lab,
    required List<Set<int>> answers,
    required int durationSeconds,
  }) async {
    if (deletedCareerIds.contains(career.id) || deletedLabIds.contains(lab.id)) {
      throw StateError('This career has been permanently deleted');
    }
    final perSkillTotal = <String, int>{};
    final perSkillCorrect = <String, int>{};
    var correct = 0;
    for (var i = 0; i < lab.questions.length; i++) {
      final question = lab.questions[i];
      final ok = i < answers.length && question.isCorrect(answers[i]);
      if (ok) correct++;
      perSkillTotal.update(question.skill, (v) => v + 1, ifAbsent: () => 1);
      perSkillCorrect.update(
        question.skill,
        (v) => v + (ok ? 1 : 0),
        ifAbsent: () => ok ? 1 : 0,
      );
    }
    final previousBest = bestResult(lab.id);
    final result = LabResult(
      id: _newId(),
      careerId: career.id,
      labId: lab.id,
      correct: correct,
      total: lab.questions.length,
      durationSeconds: durationSeconds,
      expectedSeconds: lab.expectedSeconds,
      correctnessWeight: lab.correctnessWeight,
      passMark: lab.passMark,
      skillScores: perSkillTotal.map(
        (skill, total) =>
            MapEntry(skill, (perSkillCorrect[skill]! * 100 / total).round()),
      ),
      completedAt: DateTime.now(),
    );
    _results.insert(0, result);

    final recommendations = matches;
    final top = recommendations.isEmpty ? null : recommendations.first;
    if (top != null) {
      _history.insert(
      0,
      RecommendationSnapshot(
        careerId: top.career.id,
        score: top.score,
        createdAt: DateTime.now(),
      ),
    );
    }

    final improved =
        previousBest != null && result.overall > previousBest.overall;
    _notifications.insert(
      0,
      AppNotification(
        id: _newId(),
        kind: NotificationKind.labResult,
        data: {
          'labId': lab.id,
          'score': result.overall,
          'improved': improved,
          if (top != null) 'topCareerId': top.career.id,
          if (top != null) 'topScore': top.score,
        },
        createdAt: DateTime.now(),
        resultId: result.id,
      ),
    );
    await _saveResults();
    await _saveHistory();
    await _saveNotifications();
    final uid = _cloudUid;
    if (uid != null) {
      _cloud.saveResult(uid, result.id, _resultCloudJson(result));
      if (top != null) {
        _cloud.saveRecommendation(
        uid,
        _historyId(_history.first),
        _history.first.toJson(),
      );
      }
      _cloud.saveNotification(
        uid,
        _notifications.first.id,
        _notifications.first.toJson(),
      );
    }
    notifyListeners();
    return result;
  }

  LabResult? resultById(String id) {
    for (final result in _results) {
      if (result.id == id) return result;
    }
    return null;
  }

  List<LabResult> resultsForLab(String labId) =>
      _results.where((r) => r.labId == labId).toList();

  LabResult? bestResult(String labId) {
    LabResult? best;
    for (final result in _results) {
      if (result.labId != labId) continue;
      if (best == null || result.overall > best.overall) best = result;
    }
    return best;
  }

  bool isCompleted(String labId) => _results.any((r) => r.labId == labId);

  int completedLabs(Career career) =>
      career.labs.where((lab) => isCompleted(lab.id)).length;

  int get totalCompletedLabs =>
      careers.fold(0, (sum, career) => sum + completedLabs(career));

  int get totalLabs => careers.fold(0, (sum, c) => sum + c.labs.length);

  /// Average of the best score of each completed lab of the career.
  int? careerAverage(Career career) {
    final bests = career.labs
        .map((lab) => bestResult(lab.id))
        .whereType<LabResult>()
        .toList();
    if (bests.isEmpty) return null;
    return (bests.fold(0, (sum, r) => sum + r.overall) / bests.length).round();
  }

  int? get averageScore {
    final bests = careers
        .expand((c) => c.labs)
        .map((lab) => bestResult(lab.id))
        .whereType<LabResult>()
        .toList();
    if (bests.isEmpty) return null;
    return (bests.fold(0, (sum, r) => sum + r.overall) / bests.length).round();
  }

  int get totalMinutes =>
      (_results.fold(0, (sum, r) => sum + r.durationSeconds) / 60).round();

  /// Average per skill across the best attempt of every completed lab.
  Map<String, int> get skillAverages {
    final totals = <String, List<int>>{};
    for (final lab in careers.expand((c) => c.labs)) {
      final best = bestResult(lab.id);
      if (best == null) continue;
      best.skillScores.forEach((skill, score) {
        totals.putIfAbsent(skill, () => []).add(score);
      });
    }
    final averages = totals.map(
      (skill, scores) => MapEntry(
        skill,
        (scores.fold(0, (a, b) => a + b) / scores.length).round(),
      ),
    );
    final sorted = averages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted);
  }

  /// The next lab of the same career, or the first unfinished lab of the
  /// best-matching career when the career is finished.
  (Career, Lab)? nextLab(String labId) {
    final found = findLab(labId);
    if (found == null) return null;
    final (career, lab) = found;
    final index = career.labs.indexOf(lab);
    if (!isCareerArchived(career.id) && index + 1 < career.labs.length) {
      return (career, career.labs[index + 1]);
    }
    for (final match in matches) {
      for (final candidate in match.career.labs) {
        if (!isCompleted(candidate.id)) return (match.career, candidate);
      }
    }
    return null;
  }

  // ------------------------------------------------------------- Courses

  bool isCourseCompleted(String labId) => _courses.containsKey(labId);

  int completedCourses(Career career) =>
      career.labs.where((lab) => isCourseCompleted(lab.id)).length;

  /// Marks the course of [labId] as read (kept offline and in the cloud).
  Future<void> completeCourse(String labId) async {
    if (isCourseCompleted(labId)) return;
    final now = DateTime.now();
    _courses[labId] = now;
    await _saveCourses();
    final uid = _cloudUid;
    if (uid != null) _cloud.saveCourse(uid, labId, _courseJson(labId, now));
    notifyListeners();
  }

  /// First lab of the career that has not been completed yet.
  Lab? currentLab(Career career) {
    for (final lab in career.labs) {
      if (!isCompleted(lab.id)) return lab;
    }
    return null;
  }

  // ------------------------------------------------------ Recommendations

  /// Career match = 75% lab performance + 25% interest fit when the user
  /// has tested the career, otherwise 60% of the interest fit only.
  List<CareerMatch> get matches {
    final catalogue = activeCareers;
    final list = catalogue.map(matchForCareer).toList();
    list.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      return catalogue.indexWhere((c) => c.id == a.career.id)
          .compareTo(catalogue.indexWhere((c) => c.id == b.career.id));
    });
    return list;
  }

  CareerMatch matchForCareer(Career career) {
    final interests = _profile?.interests.toSet() ?? <String>{};
      final related = interestsForCareer(career);
      final shared = related.where(interests.contains).toList();
      final interestScore = related.isEmpty
          ? 0
          : (shared.length * 100 / related.length).round();
      final performance = careerAverage(career);
      final tested = performance != null;
      final score = tested
          ? (performance * 0.75 + interestScore * 0.25).round()
          : (interestScore * 0.6).round();
      return CareerMatch(
        career: career,
        score: score,
        tested: tested,
        performance: performance,
        labsDone: completedLabs(career),
        strongestSkill: tested ? _strongestSkill(career) : null,
        sharedInterests: shared,
      );
  }

  String? _strongestSkill(Career career) {
    final skills = <String, List<int>>{};
    for (final lab in career.labs) {
      bestResult(lab.id)?.skillScores.forEach(
        (skill, score) => skills.putIfAbsent(skill, () => []).add(score),
      );
    }
    if (skills.isEmpty) return null;
    final entries = skills.entries.toList()
      ..sort((a, b) => _avg(b.value).compareTo(_avg(a.value)));
    return entries.first.key;
  }

  double _avg(List<int> values) =>
      values.fold(0, (a, b) => a + b) / values.length;

  // -------------------------------------------------------- Notifications

  Future<void> markRead(String id) async {
    final unread = _notifications.where((n) => n.id == id && !n.read);
    await _markRead(unread.toList());
  }

  Future<void> markAllRead() =>
      _markRead(_notifications.where((n) => !n.read).toList());

  Future<void> _markRead(List<AppNotification> changed) async {
    if (changed.isEmpty) return;
    final ids = {for (final n in changed) n.id};
    _notifications = [
      for (final n in _notifications) ids.contains(n.id) ? n.markRead() : n,
    ];
    await _saveNotifications();
    final uid = _cloudUid;
    if (uid != null) {
      for (final n in _notifications.where((n) => ids.contains(n.id))) {
        _cloud.saveNotification(uid, n.id, n.toJson());
      }
    }
    notifyListeners();
  }

  Future<void> clearNotifications() async {
    final ids = [for (final n in _notifications) n.id];
    _notifications = [];
    await _saveNotifications();
    final uid = _cloudUid;
    if (uid != null) _cloud.deleteNotifications(uid, ids);
    notifyListeners();
  }

  Future<void> resetProgress() async {
    final resultIds = [for (final r in _results) r.id];
    final historyIds = [for (final h in _history) _historyId(h)];
    final courseIds = _courses.keys.toList();
    _results = [];
    _history = [];
    _courses = {};
    await _saveResults();
    await _saveHistory();
    await _saveCourses();
    final uid = _cloudUid;
    if (uid != null) {
      _cloud.deleteProgress(
        uid,
        resultIds: resultIds,
        recommendationIds: historyIds,
        courseIds: courseIds,
      );
    }
    notifyListeners();
  }
}
