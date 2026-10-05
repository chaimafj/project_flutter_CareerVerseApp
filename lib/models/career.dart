import 'package:flutter/material.dart';

class LabQuestion {
  const LabQuestion({
    required this.prompt,
    required this.options,
    required this.correct,
    required this.skill,
    required this.explanation,
  });

  final String prompt;
  final List<String> options;
  final Set<int> correct;
  final String skill;
  final String explanation;

  bool get isMultiple => correct.length > 1;

  bool isCorrect(Set<int> selected) =>
      selected.length == correct.length && selected.containsAll(correct);

  LabQuestion translate(String Function(String) t) => LabQuestion(
    prompt: t(prompt),
    options: [for (final option in options) t(option)],
    correct: correct,
    skill: skill,
    explanation: t(explanation),
  );
}

class Lab {
  const Lab({
    required this.id,
    required this.title,
    required this.scenario,
    required this.level,
    required this.questions,
    this.secondsPerQuestion = 60,
    this.correctnessWeight = 0.8,
    this.passMark = 60,
  });

  final String id;
  final String title;
  final String scenario;
  final String level;
  final List<LabQuestion> questions;
  final int secondsPerQuestion;
  final double correctnessWeight;
  final int passMark;

  int get expectedSeconds => questions.length * secondsPerQuestion;
  int get minutes => (expectedSeconds / 60).ceil() + 2;

  /// Advanced labs need a Premium subscription.
  bool get isPremium => level == 'Advanced';

  List<String> get skills =>
      questions.map((question) => question.skill).toSet().toList();

  /// Level stays untranslated: it is used as a filter key.
  Lab translate(String Function(String) t) => Lab(
    id: id,
    title: t(title),
    scenario: t(scenario),
    level: level,
    questions: [for (final question in questions) question.translate(t)],
    secondsPerQuestion: secondsPerQuestion,
    correctnessWeight: correctnessWeight,
    passMark: passMark,
  );
}

class Career {
  const Career({
    required this.id,
    required this.title,
    required this.summary,
    required this.description,
    required this.icon,
    required this.color,
    required this.tools,
    required this.tags,
    required this.salary,
    required this.outlook,
    required this.education,
    required this.dailyTasks,
    required this.labs,
  });

  final String id;
  final String title;
  final String summary;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> tools;
  final List<String> tags;
  final String salary;
  final String outlook;
  final String education;
  final List<String> dailyTasks;
  final List<Lab> labs;

  int get totalMinutes => labs.fold(0, (sum, lab) => sum + lab.minutes);

  /// Tags stay untranslated: they are matched against user interests.
  Career translate(String Function(String) t) => Career(
    id: id,
    title: t(title),
    summary: t(summary),
    description: t(description),
    icon: icon,
    color: color,
    tools: tools,
    tags: tags,
    salary: t(salary),
    outlook: t(outlook),
    education: t(education),
    dailyTasks: [for (final task in dailyTasks) t(task)],
    labs: [for (final lab in labs) lab.translate(t)],
  );
}
