import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../data/courses.dart';
import '../l10n/l10n.dart';
import '../models/course.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

/// Course that prepares a lab: one lesson per page (explanation, key points
/// and an example), then a summary page with what to remember.
class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int _page = 0;
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _go(int page) {
    setState(() => _page = page);
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  Future<void> _finish({required bool startLab, required String labId}) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final done = context.l10n.courseCompleted;
    await context.read<AppState>().completeCourse(labId);
    if (startLab) {
      navigator.pushReplacementNamed('/simulation', arguments: labId);
    } else {
      messenger.showSnackBar(SnackBar(content: Text(done)));
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final labId = ModalRoute.of(context)!.settings.arguments as String;
    final found = findLab(labId);
    final course = courseFor(labId);
    final loc = context.l10n;
    if (found == null || course == null) {
      return Scaffold(
        appBar: AppBar(title: Text(loc.courseLabel)),
        body: const Center(
          child: Icon(Icons.menu_book_outlined, size: 48, color: mutedInk),
        ),
      );
    }
    final (career, lab) = found;
    final total = course.sections.length;
    final isSummary = _page >= total;
    final state = context.watch<AppState>();
    final locked = state.isLabLocked(lab);

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          '${loc.courseLabel} · ${lab.title}',
          style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
          overflow: TextOverflow.ellipsis,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_page + 1) / (total + 1),
            minHeight: 4,
            color: career.color,
            backgroundColor: career.color.withValues(alpha: 0.15),
          ),
        ),
      ),
      body: ListView(
        key: const Key('course-body'),
        controller: _scroll,
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              Icon(Icons.menu_book_rounded, color: career.color, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  isSummary
                      ? loc.summaryLabel
                      : loc.lessonProgress(_page + 1, total),
                  style: TextStyle(
                    color: career.color,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                '~${loc.minutesShort(course.minutes)}',
                style: const TextStyle(color: mutedInk, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_page == 0) ...[
            _Card(
              color: career.color.withValues(alpha: 0.08),
              child: Text(
                course.intro,
                style: const TextStyle(color: ink, height: 1.5),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (isSummary)
            _Summary(course: course, color: career.color)
          else
            _Lesson(section: course.sections[_page], color: career.color),
          const SizedBox(height: 20),
          if (isSummary) ...[
            GradientActionButton(
              key: const Key('finish-start-lab'),
              label: locked ? loc.finishCourse : loc.finishAndStartLab,
              icon: locked ? Icons.check_rounded : Icons.play_arrow_rounded,
              onPressed: () => _finish(startLab: !locked, labId: lab.id),
            ),
            if (!locked)
              TextButton(
                key: const Key('finish-course'),
                onPressed: () => _finish(startLab: false, labId: lab.id),
                child: Text(loc.finishCourse),
              ),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          color: Colors.white,
          child: Row(
            children: [
              if (_page > 0)
                OutlinedButton.icon(
                  key: const Key('course-previous'),
                  onPressed: () => _go(_page - 1),
                  icon: const Icon(Icons.chevron_left_rounded),
                  label: Text(loc.previous),
                ),
              const Spacer(),
              if (!isSummary)
                FilledButton.icon(
                  key: const Key('course-next'),
                  style: FilledButton.styleFrom(
                    backgroundColor: career.color,
                    iconAlignment: IconAlignment.end,
                  ),
                  onPressed: () => _go(_page + 1),
                  icon: const Icon(Icons.chevron_right_rounded),
                  label: Text(loc.next),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.color = Colors.white});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: child,
  );
}

class _Lesson extends StatelessWidget {
  const _Lesson({required this.section, required this.color});

  final CourseSection section;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: const TextStyle(
                  color: ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                section.body,
                style: const TextStyle(color: ink, height: 1.55),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline_rounded, color: color),
                  const SizedBox(width: 6),
                  Text(
                    loc.keyPoints,
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (final point in section.points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_rounded, size: 16, color: color),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          point,
                          style: const TextStyle(color: ink, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (section.example != null) ...[
          const SizedBox(height: 12),
          Text(
            loc.exampleLabel,
            style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Directionality(
            // Code always reads left to right, even in Arabic.
            textDirection: TextDirection.ltr,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  section.example!,
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.course, required this.color});

  final Course course;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag_rounded, color: color),
              const SizedBox(width: 6),
              Text(
                loc.takeaways,
                style: const TextStyle(
                  color: ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < course.takeaways.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 11,
                    backgroundColor: color,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      course.takeaways[i],
                      style: const TextStyle(color: ink, height: 1.45),
                    ),
                  ),
                ],
              ),
            ),
          const Divider(height: 20),
          for (final section in course.sections)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.done_rounded, size: 16, color: mutedInk),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      section.title,
                      style: const TextStyle(color: mutedInk, fontSize: 12),
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
