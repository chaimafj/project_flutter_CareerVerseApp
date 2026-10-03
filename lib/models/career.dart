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
}

class Lab {
  const Lab({
    required this.id,
    required this.title,
    required this.scenario,
    required this.level,
    required this.questions,
  });

  final String id;
  final String title;
  final String scenario;
  final String level;
  final List<LabQuestion> questions;

  int get expectedSeconds => questions.length * 60;
  int get minutes => (expectedSeconds / 60).ceil() + 2;

  List<String> get skills =>
      questions.map((question) => question.skill).toSet().toList();
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
}
