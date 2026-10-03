import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final matches = state.matches;
    final tested = matches.where((m) => m.tested).length;
    final top = matches.first;
    final loc = context.l10n;

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          loc.aiRecommendations,
          style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [navy, Color(0xFF0C2B61)]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFF7CF2D7),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            loc.bestMatch,
                            style: const TextStyle(color: Color(0xFF7CF2D7)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        top.career.title,
                        key: const Key('top-match'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        loc.matchReason(top),
                        style: const TextStyle(
                          color: Color(0xFFB5C8E8),
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ScoreRing(
                  score: top.score,
                  size: 76,
                  color: const Color(0xFF10D3D0),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE8FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              tested == 0
                  ? loc.matchesInterestsOnly
                  : loc.matchesAnalysis(tested),
              style: const TextStyle(color: ink, fontSize: 12, height: 1.4),
            ),
          ),
          const SizedBox(height: 18),
          SectionTitle(loc.allMatches),
          const SizedBox(height: 8),
          ...matches.map(
            (match) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () =>
                    Navigator.of(context)
                        .pushNamed('/career', arguments: match.career.id),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: match.career.color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(match.career.icon, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              match.career.title,
                              style: const TextStyle(
                                color: ink,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            '${match.score}%',
                            style: TextStyle(
                              color: scoreColor(match.score),
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: match.score / 100,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFE6ECF7),
                          color: scoreColor(match.score),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.matchReason(match),
                        style: const TextStyle(color: mutedInk, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SectionTitle(loc.recommendationHistory),
          const SizedBox(height: 8),
          if (state.recommendationHistory.isEmpty)
            EmptyState(
              icon: Icons.history,
              title: loc.noRecommendationYet,
              message: loc.noRecommendationYetMessage,
            )
          else
            ...state.recommendationHistory.take(10).map((snapshot) {
              final career = careerById(snapshot.careerId)!;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(career.icon, color: career.color),
                title: Text(
                  career.title,
                  style: const TextStyle(color: ink, fontSize: 13),
                ),
                subtitle: Text(
                  loc.timeAgo(snapshot.createdAt),
                  style: const TextStyle(fontSize: 11),
                ),
                trailing: Text(
                  '${snapshot.score}%',
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
