import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final skills = state.skillAverages;

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Progress',
          style: TextStyle(color: ink, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              _Stat(
                value: '${state.totalCompletedLabs}/${state.totalLabs}',
                label: 'Labs done',
                icon: Icons.science_outlined,
                color: purple,
              ),
              const SizedBox(width: 10),
              _Stat(
                value: state.averageScore == null
                    ? '--'
                    : '${state.averageScore}%',
                label: 'Avg score',
                icon: Icons.track_changes,
                color: const Color(0xFF10A37F),
              ),
              const SizedBox(width: 10),
              _Stat(
                value: '${state.totalMinutes}',
                label: 'Minutes',
                icon: Icons.timer_outlined,
                color: blue,
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SectionTitle('Career progress'),
          const SizedBox(height: 8),
          ...careers.map((career) {
            final done = state.completedLabs(career);
            final avg = state.careerAverage(career);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () =>
                      Navigator.of(context)
                          .pushNamed('/career', arguments: career.id),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(career.icon, color: career.color),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                career.title,
                                style: const TextStyle(
                                  color: ink,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: done / career.labs.length,
                                  minHeight: 6,
                                  backgroundColor: const Color(0xFFE6ECF7),
                                  color: career.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          avg == null ? '$done/${career.labs.length}' : '$avg%',
                          style: TextStyle(
                            color: avg == null ? mutedInk : scoreColor(avg),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          const SectionTitle('Skills'),
          const SizedBox(height: 8),
          if (skills.isEmpty)
            const Text(
              'Complete a lab to measure your skills.',
              style: TextStyle(color: mutedInk, fontSize: 13),
            )
          else
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: skills.entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Text(
                                e.key,
                                style: const TextStyle(
                                  color: ink,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: e.value / 100,
                                  minHeight: 8,
                                  backgroundColor: const Color(0xFFE6ECF7),
                                  color: scoreColor(e.value),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 38,
                              child: Text(
                                '${e.value}%',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: ink,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          const SizedBox(height: 18),
          const SectionTitle('History'),
          const SizedBox(height: 8),
          if (state.results.isEmpty)
            const EmptyState(
              icon: Icons.history,
              title: 'No attempts yet',
              message: 'Your completed labs will be listed here.',
            )
          else
            ...state.results.map((result) {
              final (career, lab) = findLab(result.labId)!;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  onTap: () =>
                      Navigator.of(context)
                          .pushNamed('/results', arguments: result.id),
                  leading: CircleAvatar(
                    backgroundColor: scoreColor(result.overall)
                        .withValues(alpha: 0.12),
                    child: Text(
                      '${result.overall}',
                      style: TextStyle(
                        color: scoreColor(result.overall),
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  title: Text(
                    lab.title,
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  subtitle: Text(
                    '${career.title} · ${result.correct}/${result.total} · '
                    '${formatDuration(result.durationSeconds)} · '
                    '${timeAgo(result.completedAt)}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            Text(label, style: const TextStyle(color: mutedInk, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
