import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

class LearningPathScreen extends StatefulWidget {
  const LearningPathScreen({super.key});

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen> {
  String? _careerId;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    _careerId ??=
        ModalRoute.of(context)?.settings.arguments as String? ??
        state.matches.first.career.id;
    final career = careerById(_careerId!)!;
    final current = state.currentLab(career);
    final done = state.completedLabs(career);
    final loc = context.l10n;

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          loc.learningPathTitle,
          style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: careers
                  .map(
                    (c) => Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: ChoiceChip(
                        avatar: Icon(c.icon, size: 16, color: c.color),
                        label: Text(c.title),
                        selected: c.id == career.id,
                        onSelected: (_) => setState(() => _careerId = c.id),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.becomeCareer(career.title),
                        style: const TextStyle(
                          color: ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc.pathSteps(
                          done,
                          career.labs.length,
                          career.totalMinutes,
                        ),
                        style: const TextStyle(color: mutedInk, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                ScoreRing(
                  score: (done * 100 / career.labs.length).round(),
                  size: 60,
                  color: career.color,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < career.labs.length; i++)
            Builder(
              builder: (context) {
                final lab = career.labs[i];
                final best = state.bestResult(lab.id);
                final isCurrent = current?.id == lab.id;
                final color = best != null
                    ? const Color(0xFF10A37F)
                    : isCurrent
                    ? purple
                    : const Color(0xFFC9D3E6);
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: color,
                            child: best != null
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : Text(
                                    '${i + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: Container(
                              width: 3,
                              color: i == career.labs.length - 1
                                  ? Colors.transparent
                                  : color.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () => Navigator.of(context)
                                  .pushNamed('/simulation', arguments: lab.id),
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lab.title,
                                            style: const TextStyle(
                                              color: ink,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          best != null
                                              ? '${best.overall}%'
                                              : isCurrent
                                              ? loc.upNext
                                              : loc.later,
                                          style: TextStyle(
                                            color: best != null
                                                ? scoreColor(best.overall)
                                                : isCurrent
                                                ? purple
                                                : mutedInk,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${tc(lab.level)} · ~${loc.minutesShort(lab.minutes)}',
                                      style: TextStyle(
                                        color: levelColor(lab.level),
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: lab.skills
                                          .map((s) => ToolPill(tc(s)))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          const SizedBox(height: 6),
          if (current != null)
            GradientActionButton(
              label: done == 0
                  ? loc.startThePath
                  : loc.continueLabNamed(current.title),
              icon: Icons.play_arrow_rounded,
              onPressed: () =>
                  Navigator.of(context)
                      .pushNamed('/simulation', arguments: current.id),
            )
          else
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F8F2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                loc.pathCompleted(
                  career.title,
                  state.careerAverage(career) ?? 0,
                ),
                style: const TextStyle(color: ink, fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }
}
