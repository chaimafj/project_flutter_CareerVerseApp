import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../models/career.dart';
import '../providers/app_state.dart';
import '../providers/salary_currency_provider.dart';
import '../widgets/career_ui.dart';
import '../widgets/salary_display.dart';

class CareerLabDetailScreen extends StatelessWidget {
  const CareerLabDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final careerId = ModalRoute.of(context)!.settings.arguments as String;
    final career = careerById(careerId);
    if (career == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(context.l10n.noCareerFound)),
      );
    }
    final state = context.watch<AppState>();
    final match = state.matchForCareer(career);
    final current = state.currentLab(career);
    final done = state.completedLabs(career);
    final loc = context.l10n;

    return Scaffold(
      backgroundColor: canvas,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 230,
            backgroundColor: navy,
            foregroundColor: Colors.white,
            title: Text(career.title),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(20, 96, 20, 18),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [navy, Color(0xFF0C2B61)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Hero(
                      tag: 'career-${career.id}',
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: career.color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(career.icon, color: Colors.white, size: 40),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            career.summary,
                            style: const TextStyle(
                              color: Color(0xFFDCE7FF),
                              fontSize: 13,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            loc.labsCompletedOf(done, career.labs.length),
                            style: const TextStyle(
                              color: Color(0xFF7CF2D7),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ScoreRing(
                      score: match.score,
                      size: 64,
                      color: const Color(0xFF10D3D0),
                      textColor: Colors.white,
                      label: loc.match,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    _Fact(
                      icon: Icons.euro,
                      label: context
                          .watch<SalaryCurrencyProvider>()
                          .salaryLabel(state.profile.countryCode, loc),
                      value: career.salary,
                      valueWidget: SalaryDisplay(euroSalary: career.salary),
                    ),
                    const SizedBox(width: 10),
                    _Fact(
                      icon: Icons.school_outlined,
                      label: loc.education,
                      value: career.education,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _Card(
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up, color: Color(0xFF10A37F)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          career.outlook,
                          style: const TextStyle(color: ink, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionTitle(loc.aboutTheJob),
                const SizedBox(height: 6),
                Text(
                  career.description,
                  style: const TextStyle(
                    color: mutedInk,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),
                SectionTitle(loc.typicalDay),
                const SizedBox(height: 6),
                ...career.dailyTasks.map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: career.color, size: 17),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            task,
                            style: const TextStyle(color: ink, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SectionTitle(loc.toolsYouWillUse),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: career.tools
                      .map((tool) => ToolPill(tool, icon: Icons.build_outlined))
                      .toList(),
                ),
                const SizedBox(height: 18),
                SectionTitle(
                  loc.careerLabs,
                  action: loc.learningPath,
                  onAction: () =>
                      Navigator.of(context)
                          .pushNamed('/learning-path', arguments: career.id),
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < career.labs.length; i++)
                  _LabTile(career: career, lab: career.labs[i], index: i),
                const SizedBox(height: 12),
                GradientActionButton(
                  key: const Key('start-lab'),
                  label: current == null
                      ? loc.replayFirstLab
                      : done == 0
                      ? loc.startLabNamed(current.title)
                      : loc.continueLabNamed(current.title),
                  icon: Icons.play_arrow_rounded,
                  onPressed: () => Navigator.of(context).pushNamed(
                    '/simulation',
                    arguments: (current ?? career.labs.first).id,
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

class _LabTile extends StatelessWidget {
  const _LabTile({
    required this.career,
    required this.lab,
    required this.index,
  });

  final Career career;
  final Lab lab;
  final int index;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final best = state.bestResult(lab.id);
    final attempts = state.resultsForLab(lab.id).length;
    final locked = state.isLabLocked(lab);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _Card(
        onTap: () =>
            Navigator.of(context).pushNamed('/simulation', arguments: lab.id),
        child: Row(
          children: [
            CircleAvatar(
              radius: 19,
              backgroundColor: best != null
                  ? const Color(0xFFE7F8F2)
                  : const Color(0xFFF0F4FC),
              child: best != null
                  ? const Icon(Icons.check, color: Color(0xFF10A37F))
                  : Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.title,
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${tc(lab.level)} · ${context.l10n.tasksCount(lab.questions.length)} · ~${context.l10n.minutesShort(lab.minutes)}'
                    '${attempts > 0 ? ' · ${context.l10n.attemptsCount(attempts)}' : ''}',
                    style: TextStyle(
                      color: levelColor(lab.level),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (best != null)
              Text(
                '${best.overall}%',
                style: TextStyle(
                  color: scoreColor(best.overall),
                  fontWeight: FontWeight.w800,
                ),
              )
            else if (locked)
              const Icon(Icons.lock_outline, color: Color(0xFFE0A100), size: 26)
            else
              const Icon(Icons.play_circle_fill, color: purple, size: 28),
            IconButton(
              key: Key('open-course-${lab.id}'),
              tooltip: state.isCourseCompleted(lab.id)
                  ? context.l10n.courseRead
                  : context.l10n.readCourse,
              onPressed: () =>
                  Navigator.of(context).pushNamed('/course', arguments: lab.id),
              icon: Icon(
                state.isCourseCompleted(lab.id)
                    ? Icons.menu_book_rounded
                    : Icons.menu_book_outlined,
                color: state.isCourseCompleted(lab.id)
                    ? const Color(0xFF10A37F)
                    : career.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({
    required this.icon,
    required this.label,
    required this.value,
    this.valueWidget,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: purple, size: 20),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: mutedInk, fontSize: 11)),
            const SizedBox(height: 2),
            DefaultTextStyle(
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              child: valueWidget ?? Text(value),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(padding: const EdgeInsets.all(13), child: child),
      ),
    );
  }
}
