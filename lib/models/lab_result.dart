class LabResult {
  const LabResult({
    required this.id,
    required this.careerId,
    required this.labId,
    required this.correct,
    required this.total,
    required this.durationSeconds,
    required this.expectedSeconds,
    required this.skillScores,
    required this.completedAt,
    this.correctnessWeight = 0.8,
    this.passMark = 60,
  });

  final String id;
  final String careerId;
  final String labId;
  final int correct;
  final int total;
  final int durationSeconds;
  final int expectedSeconds;

  /// Percentage of correct answers per skill (0-100).
  final Map<String, int> skillScores;
  final DateTime completedAt;
  final double correctnessWeight;
  final int passMark;

  int get correctness => total == 0 ? 0 : (correct * 100 / total).round();

  /// 100 when finished within the expected time, then decreases linearly
  /// down to 40 at twice the expected time.
  int get timeScore {
    if (durationSeconds <= expectedSeconds) return 100;
    final overRatio = (durationSeconds - expectedSeconds) / expectedSeconds;
    return (100 - overRatio * 60).clamp(40, 100).round();
  }

  int get overall =>
      (correctnessWeight * correctness + (1 - correctnessWeight) * timeScore).round();

  bool get passed => overall >= passMark;

  Map<String, dynamic> toJson() => {
    'id': id,
    'careerId': careerId,
    'labId': labId,
    'correct': correct,
    'total': total,
    'durationSeconds': durationSeconds,
    'expectedSeconds': expectedSeconds,
    'skillScores': skillScores,
    'completedAt': completedAt.toIso8601String(),
    'correctnessWeight': correctnessWeight,
    'passMark': passMark,
  };

  factory LabResult.fromJson(Map<String, dynamic> json) => LabResult(
    id: json['id'] as String,
    careerId: json['careerId'] as String,
    labId: json['labId'] as String,
    correct: json['correct'] as int,
    total: json['total'] as int,
    durationSeconds: json['durationSeconds'] as int,
    expectedSeconds: json['expectedSeconds'] as int,
    skillScores: (json['skillScores'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, value as int),
    ),
    completedAt: DateTime.parse(json['completedAt'] as String),
    correctnessWeight: (json['correctnessWeight'] as num?)?.toDouble() ?? 0.8,
    passMark: json['passMark'] as int? ?? 60,
  );
}
