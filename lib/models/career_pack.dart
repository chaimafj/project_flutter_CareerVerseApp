import 'career.dart';
import 'course.dart';

/// Everything a career needs, in one place: the English career (labs and
/// questions), its translations, the interests it matches and the courses
/// that prepare each lab.
class CareerPack {
  const CareerPack({
    required this.career,
    required this.interests,
    required this.contentFr,
    required this.contentAr,
    required this.coursesEn,
    required this.coursesFr,
    required this.coursesAr,
    required this.courseExamples,
  });

  /// English source; ids, levels, skills and tags stay in English.
  final Career career;

  /// Entries of `allInterests` that fit this career.
  final List<String> interests;

  /// Translations keyed by the English strings of [career].
  final Map<String, String> contentFr;
  final Map<String, String> contentAr;

  /// Courses keyed by lab id, with the same structure in every language.
  final Map<String, Course> coursesEn;
  final Map<String, Course> coursesFr;
  final Map<String, Course> coursesAr;

  /// One code/command example (or null) per course section, shared by all
  /// languages.
  final Map<String, List<String?>> courseExamples;
}
