import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show listEquals, setEquals;

import 'career.dart';
import 'course.dart';

/// A published Firestore career, including its translated labs and courses.
class ManagedCareer {
  ManagedCareer({
    required this.id,
    required this.variants,
    required this.archived,
  });

  final String id;
  final Map<String, Map<String, dynamic>> variants;
  final bool archived;
  List<String> get interests => strings(variants['en']!['interests']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'archived': archived,
    'variants': variants,
  };

  factory ManagedCareer.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! String || !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(id)) {
      throw const FormatException('Invalid career ID');
    }
    if (json['archived'] is! bool) {
      throw const FormatException('Archived must be a boolean');
    }
    final variants = <String, Map<String, dynamic>>{};
    for (final language in ['en', 'fr', 'ar']) {
      variants[language] = object(object(json['variants'])[language]);
    }
    final result = ManagedCareer(
      id: id,
      variants: variants,
      archived: json['archived'] as bool,
    );
    final base = result.career('en');
    if (base.labs.isEmpty || base.labs.length > 30) {
      throw const FormatException('A career needs 1 to 30 labs');
    }
    if (base.labs.map((lab) => lab.id).toSet().length != base.labs.length) {
      throw const FormatException('Duplicate lab IDs');
    }
    for (final language in variants.keys) {
      final translated = result.career(language);
      if (translated.labs.length != base.labs.length ||
          !listEquals(strings(variants[language]!['interests']), result.interests) ||
          !listEquals(translated.tags, base.tags) ||
          !listEquals(translated.tools, base.tools)) {
        throw const FormatException('Lab IDs must match across languages');
      }
      for (var index = 0; index < base.labs.length; index++) {
        final lab = translated.labs[index];
        final original = base.labs[index];
        if (lab.id != original.id ||
            lab.level != original.level ||
            lab.secondsPerQuestion != original.secondsPerQuestion ||
            lab.correctnessWeight != original.correctnessWeight ||
            lab.passMark != original.passMark ||
            lab.questions.length != original.questions.length) {
          throw const FormatException('Lab structure must match across languages');
        }
        for (var q = 0; q < lab.questions.length; q++) {
          if (lab.questions[q].skill != original.questions[q].skill ||
              lab.questions[q].options.length != original.questions[q].options.length ||
              !setEquals(lab.questions[q].correct, original.questions[q].correct)) {
            throw const FormatException('Answer keys and skills must match across languages');
          }
        }
        result.course(language, lab.id);
      }
    }
    return result;
  }

  Career career(String language, {IconData? icon, Color? color}) {
    final data = variants[language] ?? variants['en']!;
    return Career(
      id: id,
      title: text(data['title']),
      summary: text(data['summary']),
      description: text(data['description']),
      icon: icon ?? Icons.work_outline,
      color: color ?? const Color(0xFF673EFF),
      tools: strings(data['tools']),
      tags: strings(data['tags']),
      salary: text(data['salary']),
      outlook: text(data['outlook']),
      education: text(data['education']),
      dailyTasks: strings(data['dailyTasks']),
      labs: [
        for (final raw in list(data['labs'])) _lab(object(raw)),
      ],
    );
  }

  Lab _lab(Map<String, dynamic> data) {
    final labId = text(data['id']);
    if (!labId.startsWith('$id-') || !RegExp(r'^[a-z0-9-]+$').hasMatch(labId)) {
      throw const FormatException('Lab ID must start with the career ID');
    }
    final level = text(data['level']);
    if (!['Beginner', 'Intermediate', 'Advanced'].contains(level)) {
      throw const FormatException('Invalid lab level');
    }
    final questions = [
      for (final raw in list(data['questions'])) _question(object(raw)),
    ];
    if (questions.isEmpty || questions.length > 30) {
      throw const FormatException('A lab needs 1 to 30 questions');
    }
    final seconds = data['secondsPerQuestion'] ?? 60;
    final weight = data['correctnessWeight'] ?? 0.8;
    final passMark = data['passMark'] ?? 60;
    if (seconds is! int || seconds < 10 || seconds > 3600 ||
        weight is! num || !weight.isFinite || weight < 0 || weight > 1 ||
        passMark is! int || passMark < 1 || passMark > 100) {
      throw const FormatException('Invalid assessment criteria');
    }
    return Lab(
      id: labId,
      title: text(data['title']),
      scenario: text(data['scenario']),
      level: level,
      questions: questions,
      secondsPerQuestion: seconds,
      correctnessWeight: weight.toDouble(),
      passMark: passMark,
    );
  }

  LabQuestion _question(Map<String, dynamic> data) {
    final options = strings(data['options']);
    final rawCorrect = list(data['correct']);
    if (rawCorrect.any((value) => value is! int)) {
      throw const FormatException('Answer indexes must be integers');
    }
    final correct = rawCorrect.cast<int>().toSet();
    if (options.length < 2 ||
        correct.isEmpty ||
        correct.any((value) => value < 0 || value >= options.length)) {
      throw const FormatException('Invalid question answer key');
    }
    return LabQuestion(
      prompt: text(data['prompt']),
      options: options,
      correct: correct,
      skill: text(data['skill']),
      explanation: text(data['explanation']),
    );
  }

  Course course(String language, String labId) {
    final data = object(object(variants[language]!['courses'])[labId]);
    final sections = [
      for (final raw in list(data['sections']))
        CourseSection(
          title: text(object(raw)['title']),
          body: text(object(raw)['body']),
          points: strings(object(raw)['points']),
          example: object(raw)['example'] as String?,
        ),
    ];
    if (sections.isEmpty) throw const FormatException('A course needs lessons');
    return Course(
      labId: labId,
      intro: text(data['intro']),
      sections: sections,
      takeaways: strings(data['takeaways']),
    );
  }

  static Map<String, dynamic> object(Object? value) {
    if (value is! Map) throw const FormatException('Expected an object');
    return Map<String, dynamic>.from(value);
  }

  static List<dynamic> list(Object? value) {
    if (value is! List) throw const FormatException('Expected a list');
    return value;
  }

  static String text(Object? value) {
    if (value is! String || value.trim().isEmpty) {
      throw const FormatException('Required text is missing');
    }
    return value;
  }

  static List<String> strings(Object? value) =>
      list(value).map(text).toList();

  static Map<String, dynamic> encodeCareer(Career career) => {
    'title': career.title,
    'summary': career.summary,
    'description': career.description,
    'salary': career.salary,
    'outlook': career.outlook,
    'education': career.education,
    'tools': career.tools,
    'tags': career.tags,
    'dailyTasks': career.dailyTasks,
    'labs': [
      for (final lab in career.labs)
        {
          'id': lab.id,
          'title': lab.title,
          'scenario': lab.scenario,
          'level': lab.level,
          'secondsPerQuestion': lab.secondsPerQuestion,
          'correctnessWeight': lab.correctnessWeight,
          'passMark': lab.passMark,
          'questions': [
            for (final question in lab.questions)
              {
                'prompt': question.prompt,
                'options': question.options,
                'correct': question.correct.toList(),
                'skill': question.skill,
                'explanation': question.explanation,
              },
          ],
        },
    ],
  };

  static Map<String, dynamic> encodeCourse(Course course) => {
    'intro': course.intro,
    'takeaways': course.takeaways,
    'sections': [
      for (final section in course.sections)
        {
          'title': section.title,
          'body': section.body,
          'points': section.points,
          'example': section.example,
        },
    ],
  };
}
