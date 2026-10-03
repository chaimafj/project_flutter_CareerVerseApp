import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/catalog.dart';
import '../models/app_notification.dart';
import '../models/career.dart';
import '../models/lab_result.dart';
import '../models/user_profile.dart';

class CareerMatch {
  const CareerMatch({
    required this.career,
    required this.score,
    required this.reason,
    required this.tested,
  });

  final Career career;
  final int score;
  final String reason;
  final bool tested;
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

/// Local-first application state: accounts, profile, lab results,
/// recommendations and notifications are persisted in SharedPreferences,
/// scoped per user.
class AppState extends ChangeNotifier {
  AppState(this._prefs) {
    final session = _prefs.getString(_sessionKey);
    if (session != null) _loadUser(session);
  }

  static const _accountsKey = 'cv_accounts';
  static const _sessionKey = 'cv_session';

  final SharedPreferences _prefs;
  final _random = Random.secure();

  UserProfile? _profile;
  List<LabResult> _results = [];
  List<AppNotification> _notifications = [];
  List<RecommendationSnapshot> _history = [];

  bool get isLoggedIn => _profile != null;
  UserProfile get profile => _profile!;
  List<LabResult> get results => List.unmodifiable(_results);
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  List<RecommendationSnapshot> get recommendationHistory =>
      List.unmodifiable(_history);
  int get unreadCount => _notifications.where((n) => !n.read).length;

  // ---------------------------------------------------------------- Auth

  Map<String, dynamic> get _accounts =>
      jsonDecode(_prefs.getString(_accountsKey) ?? '{}')
          as Map<String, dynamic>;

  String _hash(String salt, String password) =>
      sha256.convert(utf8.encode('$salt:$password')).toString();

  String _newId() =>
      '${DateTime.now().microsecondsSinceEpoch}${_random.nextInt(9999)}';

  /// Returns an error message, or null on success.
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final key = email.trim().toLowerCase();
    final accounts = _accounts;
    if (accounts.containsKey(key)) {
      return 'An account already exists with this email.';
    }
    final salt = base64Url.encode(
      List.generate(16, (_) => _random.nextInt(256)),
    );
    accounts[key] = {'salt': salt, 'hash': _hash(salt, password)};
    await _prefs.setString(_accountsKey, jsonEncode(accounts));

    _profile = UserProfile(
      name: name.trim(),
      email: key,
      createdAt: DateTime.now(),
    );
    _results = [];
    _history = [];
    _notifications = [
      AppNotification(
        id: _newId(),
        title: 'Welcome to CareerVerse 🎉',
        body:
            'Complete your profile and start your first Career Lab to get '
            'personalized recommendations.',
        createdAt: DateTime.now(),
      ),
    ];
    await _prefs.setString(_sessionKey, key);
    await _save();
    notifyListeners();
    return null;
  }

  Future<String?> login(String email, String password) async {
    final key = email.trim().toLowerCase();
    final account = _accounts[key] as Map<String, dynamic>?;
    if (account == null) return 'No account found for this email.';
    if (_hash(account['salt'] as String, password) != account['hash']) {
      return 'Incorrect password.';
    }
    await _prefs.setString(_sessionKey, key);
    _loadUser(key);
    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    await _prefs.remove(_sessionKey);
    _profile = null;
    _results = [];
    _notifications = [];
    _history = [];
    notifyListeners();
  }

  void _loadUser(String email) {
    final raw = _prefs.getString('cv_user_$email');
    if (raw == null) {
      _profile = UserProfile(
        name: email.split('@').first,
        email: email,
        createdAt: DateTime.now(),
      );
      return;
    }
    final data = jsonDecode(raw) as Map<String, dynamic>;
    _profile = UserProfile.fromJson(data['profile'] as Map<String, dynamic>);
    _results = (data['results'] as List? ?? [])
        .map((item) => LabResult.fromJson(item as Map<String, dynamic>))
        .toList();
    _notifications = (data['notifications'] as List? ?? [])
        .map((item) => AppNotification.fromJson(item as Map<String, dynamic>))
        .toList();
    _history = (data['history'] as List? ?? [])
        .map(
          (item) =>
              RecommendationSnapshot.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> _save() async {
    final profile = _profile;
    if (profile == null) return;
    await _prefs.setString(
      'cv_user_${profile.email}',
      jsonEncode({
        'profile': profile.toJson(),
        'results': _results.map((r) => r.toJson()).toList(),
        'notifications': _notifications.map((n) => n.toJson()).toList(),
        'history': _history.map((h) => h.toJson()).toList(),
      }),
    );
  }

  // ------------------------------------------------------------- Profile

  Future<void> updateProfile(UserProfile profile) async {
    _profile = profile;
    await _save();
    notifyListeners();
  }

  // ------------------------------------------------------------- Results

  Future<LabResult> recordResult({
    required Career career,
    required Lab lab,
    required List<Set<int>> answers,
    required int durationSeconds,
  }) async {
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
      skillScores: perSkillTotal.map(
        (skill, total) =>
            MapEntry(skill, (perSkillCorrect[skill]! * 100 / total).round()),
      ),
      completedAt: DateTime.now(),
    );
    _results.insert(0, result);

    final top = matches.first;
    _history.insert(
      0,
      RecommendationSnapshot(
        careerId: top.career.id,
        score: top.score,
        createdAt: DateTime.now(),
      ),
    );

    final improved =
        previousBest != null && result.overall > previousBest.overall;
    _notifications.insert(
      0,
      AppNotification(
        id: _newId(),
        title: 'Your recommendations are ready!',
        body:
            '${lab.title}: ${result.overall}%'
            '${improved ? ' (new personal best)' : ''}. '
            'Top match: ${top.career.title} (${top.score}%).',
        createdAt: DateTime.now(),
        resultId: result.id,
      ),
    );
    await _save();
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
    if (index + 1 < career.labs.length) return (career, career.labs[index + 1]);
    for (final match in matches) {
      for (final candidate in match.career.labs) {
        if (!isCompleted(candidate.id)) return (match.career, candidate);
      }
    }
    return null;
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
    final interests = _profile?.interests.toSet() ?? <String>{};
    final list = careers.map((career) {
      final related = careerInterests[career.id] ?? const [];
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
        reason: _reason(career, performance, shared),
      );
    }).toList();
    list.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      return careers.indexOf(a.career).compareTo(careers.indexOf(b.career));
    });
    return list;
  }

  String _reason(Career career, int? performance, List<String> shared) {
    final parts = <String>[];
    if (performance != null) {
      final done = completedLabs(career);
      final skills = <String, List<int>>{};
      for (final lab in career.labs) {
        bestResult(lab.id)?.skillScores.forEach(
          (skill, score) => skills.putIfAbsent(skill, () => []).add(score),
        );
      }
      final strongest = skills.entries.isEmpty
          ? null
          : (skills.entries.toList()
                  ..sort((a, b) => _avg(b.value).compareTo(_avg(a.value))))
                .first
                .key;
      parts.add(
        'You scored $performance% on $done/${career.labs.length} labs'
        '${strongest != null ? ', strongest in $strongest' : ''}.',
      );
    } else {
      parts.add('Not tested yet: try a lab to confirm this match.');
    }
    if (shared.isNotEmpty) {
      parts.add('Matches your interests: ${shared.join(', ')}.');
    }
    return parts.join(' ');
  }

  double _avg(List<int> values) =>
      values.fold(0, (a, b) => a + b) / values.length;

  // -------------------------------------------------------- Notifications

  Future<void> markRead(String id) async {
    _notifications = [
      for (final n in _notifications) n.id == id ? n.markRead() : n,
    ];
    await _save();
    notifyListeners();
  }

  Future<void> markAllRead() async {
    _notifications = [for (final n in _notifications) n.markRead()];
    await _save();
    notifyListeners();
  }

  Future<void> clearNotifications() async {
    _notifications = [];
    await _save();
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _results = [];
    _history = [];
    await _save();
    notifyListeners();
  }
}
