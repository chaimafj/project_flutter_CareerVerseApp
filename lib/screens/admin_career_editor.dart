import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../data/managed_catalog.dart';
import '../l10n/l10n.dart';
import '../models/managed_career.dart';
import '../providers/admin_provider.dart';
import '../widgets/admin_ui.dart';
import '../widgets/form_fields.dart';

class AdminCareerEditor extends StatefulWidget {
  const AdminCareerEditor({super.key, this.initial});
  final Map<String, dynamic>? initial;

  @override
  State<AdminCareerEditor> createState() => _AdminCareerEditorState();
}

class _AdminCareerEditorState extends State<AdminCareerEditor> {
  late Map<String, dynamic>? _document = widget.initial == null
      ? null
      : ManagedCareer.object(jsonDecode(jsonEncode(widget.initial)));
  String _id = '';
  final String _language = 'en';
  bool _saving = false;

  Map<String, dynamic> get _variants =>
      ManagedCareer.object(_document!['variants']);
  Map<String, dynamic> get _content =>
      _variants[_language] as Map<String, dynamic>;
  List<dynamic> get _labs => _content['labs'] as List<dynamic>;

  static Map<String, dynamic> _question() => {
    'prompt': '',
    'options': ['', ''],
    'correct': [0],
    'skill': '',
    'explanation': '',
  };

  static Map<String, dynamic> _lesson() => {
    'title': '',
    'body': '',
    'points': <String>[],
    'example': '',
  };

  static Map<String, dynamic> _course() => {
    'intro': '',
    'takeaways': <String>[],
    'sections': [_lesson()],
  };

  static Map<String, dynamic> _lab(String id) => {
    'id': id,
    'title': '',
    'scenario': '',
    'level': 'Beginner',
    'secondsPerQuestion': 60,
    'correctnessWeight': 0.8,
    'passMark': 60,
    'questions': [_question()],
  };

  void _create() {
    final loc = context.l10n;
    if (!RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(_id) ||
        careerById(_id) != null || deletedCareerIds.contains(_id)) {
      showError(context, loc.adminInvalidId);
      return;
    }
    setState(() {
      _document = {
        'id': _id,
        'archived': false,
        'variants': {
          for (final language in ['en'])
            language: {
              for (final field in [
                'title',
                'summary',
                'description',
                'salary',
                'outlook',
                'education',
              ])
                field: '',
              'tools': <String>[],
              'tags': <String>[],
              'interests': <String>[],
              'dailyTasks': <String>[],
              'labs': [_lab('$_id-1')],
              'courses': {'$_id-1': _course()},
            },
        },
      };
    });
  }

  void _forLanguages(void Function(Map<String, dynamic>) edit) {
    for (final variant in _variants.values) {
      edit(variant as Map<String, dynamic>);
    }
  }

  void _addLab() {
    final id = '${_document!['id']}-${_labs.length + 1}';
    setState(
      () => _forLanguages((variant) {
        (variant['labs'] as List).add(_lab(id));
        (variant['courses'] as Map)[id] = _course();
      }),
    );
  }

  Widget _field(
    Map<String, dynamic> data,
    String key,
    String label, {
    bool lines = false,
    bool list = false,
    bool shared = false,
    void Function(String)? onChanged,
  }) {
    final value = data[key];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        key: ValueKey('$_language/${identityHashCode(data)}/$key'),
        initialValue: list ? (value as List).join('\n') : '${value ?? ''}',
        decoration: InputDecoration(
          labelText: label,
          helperText: list ? context.l10n.adminOnePerLine : null,
          border: const OutlineInputBorder(),
        ),
        minLines: lines || list ? 2 : 1,
        maxLines: lines || list ? 8 : 1,
        onChanged:
            onChanged ??
            (value) {
              data[key] = list
                  ? value
                        .split('\n')
                        .map((line) => line.trim())
                        .where((line) => line.isNotEmpty)
                        .toList()
                  : value.trim();
              if (shared) {
                _forLanguages((variant) => variant[key] = data[key]);
              }
            },
      ),
    );
  }

  void _sharedLab(int index, String key, Object value) {
    _forLanguages((variant) => (variant['labs'] as List)[index][key] = value);
  }

  Object? _completeTranslation(Object? english, Object? translated) {
    if (translated == null ||
        (translated is String && translated.trim().isEmpty)) {
      return english;
    }
    if (english is Map && translated is Map) {
      return {
        for (final key in english.keys)
          key: _completeTranslation(english[key], translated[key]),
      };
    }
    if (english is List && translated is List) {
      if (english.length != translated.length) return english;
      return [
        for (var index = 0; index < english.length; index++)
          _completeTranslation(english[index], translated[index]),
      ];
    }
    return translated;
  }

  Future<void> _save() async {
    final loc = context.l10n;
    setState(() => _saving = true);
    try {
      final data = ManagedCareer.object(jsonDecode(jsonEncode(_document)));
      final variants = ManagedCareer.object(data['variants']);
      for (final language in ['fr', 'ar']) {
        if (variants.containsKey(language)) {
          variants[language] = _completeTranslation(variants['en'], variants[language]);
        }
      }
      data['variants'] = variants;
      await context.read<AdminProvider>().saveCareer(
        ManagedCareer.fromJson(data),
      );
      if (mounted) Navigator.pop(context);
    } on FirebaseException catch (error) {
      if (mounted) {
        showError(
          context,
          loc.adminOperationError(error.message ?? error.code),
        );
      }
    } on FormatException catch (error) {
      if (mounted) showError(context, loc.adminOperationError(error.message));
    } on StateError catch (error) {
      if (mounted) showError(context, loc.adminOperationError(error.message));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    if (!context.watch<AdminProvider>().isAdmin) {
      return Scaffold(body: Center(child: Text(loc.adminAccessDenied)));
    }
    final labels = <String, String>{
      'title': loc.adminFieldTitle,
      'summary': loc.adminFieldSummary,
      'description': loc.adminFieldDescription,
      'salary': loc.adminFieldSalary,
      'outlook': loc.adminFieldOutlook,
      'education': loc.adminFieldEducation,
      'tools': loc.adminFieldTools,
      'tags': loc.adminFieldTags,
      'interests': loc.adminFieldInterests,
      'dailyTasks': loc.adminFieldTasks,
    };
    return Scaffold(
      appBar: AppBar(title: Text(loc.adminContent)),
      bottomNavigationBar: _document == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  key: const Key('admin-publish'),
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const CircularProgressIndicator()
                      : Text(loc.saveChanges),
                ),
              ),
            ),
      body: AdminPageBody(
        child: _document == null
            ? ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  AdminSectionHeader(
                    icon: Icons.add_business_outlined,
                    title: loc.adminAddCareer,
                    description: loc.adminIdHelp,
                  ),
                  TextField(
                    key: const Key('admin-career-id'),
                    decoration: const InputDecoration(
                      labelText: 'ID',
                      prefixIcon: Icon(Icons.tag),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _id = value.trim(),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _create,
                    icon: const Icon(Icons.add),
                    label: Text(loc.adminAddCareer),
                  ),
                ],
              )
            : ListView(
                key: const Key('admin-career-form'),
                padding: const EdgeInsets.all(16),
                children: [
                  AdminSectionHeader(
                    icon: Icons.edit_note_outlined,
                    title: 'ID: ${_document!['id']}',
                    description: loc.adminTranslationHelp,
                  ),
                  Chip(
                    avatar: const Icon(Icons.language, size: 18),
                    label: Text(loc.adminEnglishContent),
                  ),
                  const SizedBox(height: 20),
                  AdminPanel(
                    child: Column(
                      children: [
                        for (final key in labels.keys)
                          _field(
                            _content,
                            key,
                            labels[key]!,
                            lines: ['summary', 'description'].contains(key),
                            list: [
                              'tools',
                              'tags',
                              'interests',
                              'dailyTasks',
                            ].contains(key),
                            shared: [
                              'tools',
                              'tags',
                              'interests',
                            ].contains(key),
                          ),
                      ],
                    ),
                  ),
                  for (var index = 0; index < _labs.length; index++)
                    _labEditor(index, _labs[index] as Map<String, dynamic>),
                  OutlinedButton.icon(
                    onPressed: _saving || _labs.length >= 30 ? null : _addLab,
                    icon: const Icon(Icons.add),
                    label: Text(loc.adminAddLab),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _labEditor(int index, Map<String, dynamic> lab) {
    final loc = context.l10n;
    final questions = lab['questions'] as List;
    final course =
        (_content['courses'] as Map)[lab['id']] as Map<String, dynamic>;
    final sections = course['sections'] as List;
    return AdminPanel(
      padding: EdgeInsets.zero,
      child: ExpansionTile(
        key: ValueKey('$_language/${lab['id']}'),
        maintainState: true,
        leading: const Icon(Icons.science_outlined),
        title: Text(
          '${loc.labs} ${index + 1}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text('${lab['id']} · ${tc(lab['level'] as String)}'),
        shape: const Border(),
        collapsedShape: const Border(),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _field(lab, 'title', loc.adminFieldTitle),
                _field(lab, 'scenario', loc.adminFieldScenario, lines: true),
                DropdownButton<String>(
                  value: lab['level'] as String,
                  items: [
                    for (final level in [
                      'Beginner',
                      'Intermediate',
                      'Advanced',
                    ])
                      DropdownMenuItem(value: level, child: Text(tc(level))),
                  ],
                  onChanged: (value) =>
                      setState(() => _sharedLab(index, 'level', value!)),
                ),
                for (final entry in {
                  'secondsPerQuestion': loc.adminSeconds,
                  'correctnessWeight': loc.adminWeight,
                  'passMark': loc.adminPassMark,
                }.entries)
                  _field(
                    lab,
                    entry.key,
                    entry.value,
                    onChanged: (value) => _sharedLab(
                      index,
                      entry.key,
                      entry.key == 'correctnessWeight'
                          ? double.tryParse(value) ?? value
                          : int.tryParse(value) ?? value,
                    ),
                  ),
                for (var q = 0; q < questions.length; q++)
                  _questionEditor(
                    index,
                    q,
                    questions[q] as Map<String, dynamic>,
                  ),
                TextButton(
                  onPressed: questions.length >= 30
                      ? null
                      : () => setState(
                          () => _forLanguages(
                            (variant) =>
                                ((variant['labs'] as List)[index]['questions']
                                        as List)
                                    .add(_question()),
                          ),
                        ),
                  child: Text(loc.adminAddQuestion),
                ),
                Text(
                  loc.courseLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _field(course, 'intro', loc.adminFieldIntro, lines: true),
                _field(
                  course,
                  'takeaways',
                  loc.adminFieldTakeaways,
                  list: true,
                ),
                for (var s = 0; s < sections.length; s++) ...[
                  Text('${loc.adminLesson} ${s + 1}'),
                  _field(
                    sections[s] as Map<String, dynamic>,
                    'title',
                    loc.adminFieldTitle,
                  ),
                  _field(
                    sections[s] as Map<String, dynamic>,
                    'body',
                    loc.adminFieldExplanation,
                    lines: true,
                  ),
                  _field(
                    sections[s] as Map<String, dynamic>,
                    'points',
                    loc.adminFieldPoints,
                    list: true,
                  ),
                  _field(
                    sections[s] as Map<String, dynamic>,
                    'example',
                    loc.adminFieldExample,
                    lines: true,
                  ),
                ],
                TextButton(
                  onPressed: () => setState(
                    () => _forLanguages((variant) {
                      ((variant['courses'] as Map)[lab['id']]['sections']
                              as List)
                          .add(_lesson());
                    }),
                  ),
                  child: Text(loc.adminAddLesson),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionEditor(
    int labIndex,
    int index,
    Map<String, dynamic> question,
  ) {
    final loc = context.l10n;
    void shared(String key, Object value) => _forLanguages((variant) {
      (variant['labs'] as List)[labIndex]['questions'][index][key] = value;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        Text('${loc.adminQuestion} ${index + 1}'),
        _field(question, 'prompt', loc.adminFieldPrompt, lines: true),
        _field(question, 'options', loc.adminFieldOptions, list: true),
        _field(
          {
            'answers': (question['correct'] as List)
                .map((value) => (value as int) + 1)
                .join(','),
          },
          'answers',
          loc.adminFieldAnswers,
          onChanged: (value) {
            final values = value
                .split(',')
                .map((part) => int.tryParse(part.trim()))
                .toList();
            shared(
              'correct',
              values.any((number) => number == null)
                  ? <int>[]
                  : values.map((number) => number! - 1).toList(),
            );
          },
        ),
        _field(
          question,
          'skill',
          loc.adminFieldSkill,
          onChanged: (value) => shared('skill', value.trim()),
        ),
        _field(question, 'explanation', loc.adminFieldExplanation, lines: true),
      ],
    );
  }
}
