/// One lesson of a course: an explanation, the key points to remember and
/// an optional concrete example (code, command or configuration).
class CourseSection {
  const CourseSection({
    required this.title,
    required this.body,
    required this.points,
    this.example,
  });

  final String title;
  final String body;
  final List<String> points;
  final String? example;

  CourseSection withExample(String? example) =>
      CourseSection(title: title, body: body, points: points, example: example);
}

/// Course that prepares a lab: read the lessons, then practice in the lab.
class Course {
  const Course({
    required this.labId,
    required this.intro,
    required this.sections,
    required this.takeaways,
  });

  final String labId;
  final String intro;
  final List<CourseSection> sections;
  final List<String> takeaways;

  /// Reading time, at about 180 words per minute (at least 3 minutes).
  int get minutes {
    final words = [
      intro,
      for (final section in sections) ...[
        section.title,
        section.body,
        ...section.points,
        section.example ?? '',
      ],
      ...takeaways,
    ].join(' ').split(RegExp(r'\s+')).length;
    final reading = (words / 180).ceil() + sections.length;
    return reading < 3 ? 3 : reading;
  }
}
