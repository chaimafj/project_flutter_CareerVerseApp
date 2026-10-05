import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../models/lab_result.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultId = ModalRoute.of(context)!.settings.arguments as String;
    final state = context.watch<AppState>();
    final result = state.resultById(resultId);
    if (result == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: EmptyState(
            icon: Icons.search_off,
            title: context.l10n.resultNotFound,
            message: context.l10n.resultNotFoundMessage,
          ),
        ),
      );
    }
    final loc = context.l10n;
    final (career, lab) = findLab(result.labId)!;
    final previous = state
        .resultsForLab(lab.id)
        .where(
          (r) =>
              r.id != result.id && r.completedAt.isBefore(result.completedAt),
        )
        .toList();
    LabResult? previousBest;
    for (final r in previous) {
      if (previousBest == null || r.overall > previousBest.overall) {
        previousBest = r;
      }
    }
    final next = state.nextLab(lab.id);
    final match = state.matchForCareer(career);
    final passed = result.passed;

    return Scaffold(
      backgroundColor: canvas,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 46, 16, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [navy, Color(0xFF0C2B61)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/home', (_) => false),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                    Expanded(
                      child: Text(
                        loc.labResults,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 96,
                  child: Lottie.asset(
                    passed
                        ? 'assets/lottie/success.json'
                        : 'assets/lottie/retry.json',
                    key: Key(passed ? 'lottie-success' : 'lottie-retry'),
                    repeat: false,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      passed ? Icons.emoji_events : Icons.replay_circle_filled,
                      color: passed
                          ? const Color(0xFFFFC53D)
                          : const Color(0xFF7CB2FF),
                      size: 54,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  passed ? loc.labCompleted : loc.keepPracticing,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${career.title} · ${lab.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFB5C8E8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 18),
                ScoreRing(
                  key: const Key('result-score'),
                  score: result.overall,
                  size: 120,
                  color: scoreColor(result.overall),
                  textColor: Colors.white,
                  label: loc.overall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _StatTile(
                      icon: Icons.check_circle_outline,
                      value: '${result.correct}/${result.total}',
                      label: loc.correctAnswers,
                      color: const Color(0xFF10A37F),
                    ),
                    const SizedBox(width: 10),
                    _StatTile(
                      icon: Icons.timer_outlined,
                      value: formatDuration(result.durationSeconds),
                      label: loc.timeTarget(
                        formatDuration(result.expectedSeconds),
                      ),
                      color: blue,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _StatTile(
                      icon: Icons.track_changes,
                      value: '${result.correctness}%',
                      label: loc.accuracyWeightValue(
                        (result.correctnessWeight * 100).round(),
                      ),
                      color: purple,
                    ),
                    const SizedBox(width: 10),
                    _StatTile(
                      icon: Icons.speed,
                      value: '${result.timeScore}%',
                      label: loc.speedWeightValue(
                        ((1 - result.correctnessWeight) * 100).round(),
                      ),
                      color: const Color(0xFFF59E0B),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                if (previousBest != null)
                  _InfoBanner(
                    icon: result.overall > previousBest.overall
                        ? Icons.trending_up
                        : Icons.trending_flat,
                    color: result.overall > previousBest.overall
                        ? const Color(0xFF10A37F)
                        : mutedInk,
                    text: result.overall > previousBest.overall
                        ? loc.newPersonalBest(
                            result.overall - previousBest.overall,
                            previousBest.overall,
                          )
                        : loc.stillBest(previousBest.overall),
                  ),
                const SizedBox(height: 16),
                SectionTitle(loc.skillsBreakdown),
                const SizedBox(height: 8),
                ...result.skillScores.entries.map(
                  (entry) =>
                      _SkillBar(skill: tc(entry.key), value: entry.value),
                ),
                const SizedBox(height: 14),
                _InfoBanner(
                  icon: Icons.auto_awesome,
                  color: purple,
                  text: loc.matchNow(
                    career.title,
                    match.score,
                    state.completedLabs(career),
                    career.labs.length,
                  ),
                ),
                const SizedBox(height: 20),
                if (next != null)
                  GradientActionButton(
                    key: const Key('next-lab'),
                    label: next.$1.id == career.id
                        ? loc.nextLabNamed(next.$2.title)
                        : loc.tryCareerLab(next.$1.title, next.$2.title),
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                      '/simulation',
                      arguments: next.$2.id,
                    ),
                  )
                else
                  GradientActionButton(
                    key: const Key('view-recommendations'),
                    label: loc.viewRecommendations,
                    icon: Icons.auto_awesome,
                    onPressed: () =>
                        Navigator.of(context)
                            .pushReplacementNamed('/recommendations'),
                  ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(
                              '/simulation',
                              arguments: lab.id,
                            ),
                        icon: const Icon(Icons.replay),
                        label: Text(loc.retry),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            Navigator.of(context)
                                .pushReplacementNamed('/recommendations'),
                        icon: const Icon(Icons.auto_awesome),
                        label: Text(loc.matches),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Center(
                  child: TextButton.icon(
                    key: const Key('review-course'),
                    onPressed: () =>
                        Navigator.of(context)
                            .pushNamed('/course', arguments: lab.id),
                    icon: const Icon(Icons.menu_book_rounded, size: 18),
                    label: Text(loc.reviewCourse),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/home', (_) => false),
                    child: Text(loc.backToHome),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(color: mutedInk, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  const _SkillBar({required this.skill, required this.value});

  final String skill;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  skill,
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                '$value%',
                style: TextStyle(
                  color: scoreColor(value),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value / 100),
              duration: const Duration(milliseconds: 800),
              builder: (context, v, _) => LinearProgressIndicator(
                value: v,
                minHeight: 8,
                backgroundColor: const Color(0xFFE6ECF7),
                color: scoreColor(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: ink, fontSize: 13, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}
