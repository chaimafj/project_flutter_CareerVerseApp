import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../data/courses.dart';
import '../data/managed_catalog.dart';
import '../l10n/l10n.dart';
import '../models/managed_career.dart';
import '../providers/admin_provider.dart';
import '../widgets/form_fields.dart';
import 'admin_career_editor.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminProvider>();
    final loc = context.l10n;
    if (!admin.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: Text(loc.adminTitle)),
        body: Center(child: Text(loc.adminAccessDenied)),
      );
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.adminTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: loc.adminContent),
              Tab(text: loc.adminStudents),
              Tab(text: loc.adminStatistics),
            ],
          ),
        ),
        body: Column(
          children: [
            if (admin.error != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(loc.adminOperationError(admin.error!)),
              ),
            const Expanded(
              child: TabBarView(
                children: [_ContentTab(), _StudentsTab(), _StatisticsTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Use the same localized careers/courses as the student app to prepare a
/// complete editable document without altering the global language.
Map<String, dynamic> editableCareer(String id) {
  final managed = managedCareers[id];
  if (managed != null) return managed.toJson();
  final language = catalogLanguage;
  final variants = <String, dynamic>{};
  try {
    for (final code in ['en', 'fr', 'ar']) {
      setCatalogLanguage(code);
      final career = careerById(id)!;
      variants[code] = {
        ...ManagedCareer.encodeCareer(career),
        'interests': careerInterests[id] ?? career.tags,
        'courses': {
          for (final lab in career.labs)
            lab.id: ManagedCareer.encodeCourse(courseFor(lab.id)!),
        },
      };
    }
  } finally {
    setCatalogLanguage(language);
  }
  return {'id': id, 'archived': false, 'variants': variants};
}

class _ContentTab extends StatelessWidget {
  const _ContentTab();

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminProvider>();
    final loc = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(loc.adminContentHelp),
        const SizedBox(height: 12),
        FilledButton.icon(
          key: const Key('admin-add-career'),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AdminCareerEditor(),
            ),
          ),
          icon: const Icon(Icons.add),
          label: Text(loc.adminAddCareer),
        ),
        for (final career in careers)
          ListTile(
            title: Text(career.title),
            subtitle: Text(
              managedCareers[career.id]?.archived == true
                  ? loc.adminArchived
                  : loc.adminPublished,
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => AdminCareerEditor(
                  initial: editableCareer(career.id),
                ),
              ),
            ),
            trailing: IconButton(
              tooltip: loc.adminArchive,
              icon: Icon(
                managedCareers[career.id]?.archived == true
                    ? Icons.unarchive_outlined
                    : Icons.archive_outlined,
              ),
              onPressed: () async {
                final archived = managedCareers[career.id]?.archived == true;
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(loc.adminArchive),
                    content: Text(loc.adminArchiveHelp),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(loc.cancel),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(loc.saveChanges),
                      ),
                    ],
                  ),
                );
                if (confirmed != true || !context.mounted) return;
                try {
                  final data = editableCareer(career.id);
                  data['archived'] = !archived;
                  await admin.saveCareer(ManagedCareer.fromJson(data));
                } on FirebaseException catch (error) {
                  if (context.mounted) showError(context, loc.adminOperationError(error.message ?? error.code));
                } on FormatException catch (error) {
                  if (context.mounted) showError(context, loc.adminOperationError(error.message));
                } on StateError catch (error) {
                  if (context.mounted) showError(context, loc.adminOperationError(error.message));
                }
              },
            ),
          ),
      ],
    );
  }
}

class _StudentsTab extends StatefulWidget {
  const _StudentsTab();

  @override
  State<_StudentsTab> createState() => _StudentsTabState();
}

class _StudentsTabState extends State<_StudentsTab> {
  Future<List<AdminStudent>>? _students;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _students ??= context.read<AdminProvider>().students();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return FutureBuilder<List<AdminStudent>>(
      future: _students,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: TextButton(
              onPressed: () => setState(() => _students = context.read<AdminProvider>().students()),
              child: Text(loc.adminOperationError('${snapshot.error}')),
            ),
          );
        }
        final students = snapshot.data!;
        return RefreshIndicator(
          onRefresh: () async {
            final future = context.read<AdminProvider>().students();
            setState(() => _students = future);
            await future;
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              Text(loc.adminStudentHelp),
              if (students.isEmpty) Text(loc.adminNoStudents),
              for (final student in students)
                ListTile(
                  title: Text(student.profile.name),
                  subtitle: Text(student.profile.email),
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => _StudentEditor(student: student),
                      ),
                    );
                    if (mounted) setState(() => _students = context.read<AdminProvider>().students());
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _StudentEditor extends StatefulWidget {
  const _StudentEditor({required this.student});
  final AdminStudent student;

  @override
  State<_StudentEditor> createState() => _StudentEditorState();
}

class _StudentEditorState extends State<_StudentEditor> {
  final _form = GlobalKey<FormState>();
  late String _name = widget.student.profile.name;
  late String _university = widget.student.profile.university;
  late String _bio = widget.student.profile.bio;
  late String _studyLevel = widget.student.profile.studyLevel;
  late String _specialty = widget.student.profile.specialty;
  Future<AdminStatistics>? _statistics;
  bool _saving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _statistics ??= context.read<AdminProvider>().studentStatistics(widget.student.uid);
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    if (!context.watch<AdminProvider>().isAdmin) {
      return Scaffold(body: Center(child: Text(loc.adminAccessDenied)));
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.student.profile.email)),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: loc.fullName),
              validator: (value) => value == null || value.trim().isEmpty ? loc.validationRequired : null,
              onChanged: (value) => _name = value.trim(),
            ),
            TextFormField(
              initialValue: _university,
              decoration: InputDecoration(labelText: loc.universitySchool),
              onChanged: (value) => _university = value.trim(),
            ),
            TextFormField(
              initialValue: _bio,
              decoration: InputDecoration(labelText: loc.bio),
              maxLines: 3,
              onChanged: (value) => _bio = value.trim(),
            ),
            TextFormField(
              initialValue: _studyLevel,
              decoration: InputDecoration(labelText: loc.studyLevel),
              onChanged: (value) => _studyLevel = value.trim(),
            ),
            TextFormField(
              initialValue: _specialty,
              decoration: InputDecoration(labelText: loc.specialty),
              onChanged: (value) => _specialty = value.trim(),
            ),
            FutureBuilder<AdminStatistics>(
              future: _statistics,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return TextButton(
                    onPressed: () => setState(() => _statistics = context.read<AdminProvider>().studentStatistics(widget.student.uid)),
                    child: Text(loc.adminOperationError('${snapshot.error}')),
                  );
                }
                final stats = snapshot.data!;
                return Column(
                  children: [
                    ListTile(title: Text(loc.adminAttempts), trailing: Text('${stats.attempts}')),
                    ListTile(title: Text(loc.adminAverage), trailing: Text(stats.average == null ? '--' : '${stats.average!.toStringAsFixed(1)}%')),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _saving ? null : () async {
                if (!_form.currentState!.validate()) return;
                setState(() => _saving = true);
                try {
                  await context.read<AdminProvider>().saveStudent(
                    AdminStudent(
                      uid: widget.student.uid,
                      profile: widget.student.profile.copyWith(
                        name: _name,
                        university: _university,
                        bio: _bio,
                        studyLevel: _studyLevel,
                        specialty: _specialty,
                      ),
                    ),
                  );
                  if (context.mounted) Navigator.pop(context);
                } on FirebaseException catch (error) {
                  if (context.mounted) showError(context, loc.adminOperationError(error.message ?? error.code));
                } on StateError catch (error) {
                  if (context.mounted) showError(context, loc.adminOperationError(error.message));
                } finally {
                  if (mounted) setState(() => _saving = false);
                }
              },
              child: Text(loc.saveChanges),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticsTab extends StatefulWidget {
  const _StatisticsTab();

  @override
  State<_StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<_StatisticsTab> {
  Future<AdminStatistics>? _statistics;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _statistics ??= context.read<AdminProvider>().statistics();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return FutureBuilder<AdminStatistics>(
      future: _statistics,
      builder: (context, snapshot) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (snapshot.connectionState != ConnectionState.done)
              const Center(child: CircularProgressIndicator())
            else if (snapshot.hasError)
              Text(loc.adminOperationError('${snapshot.error}'))
            else ...[
              ListTile(title: Text(loc.adminStudents), trailing: Text('${snapshot.data!.students}')),
              ListTile(title: Text(loc.adminAttempts), trailing: Text('${snapshot.data!.attempts}')),
              ListTile(title: Text(loc.adminAverage), trailing: Text(snapshot.data!.average == null ? '--' : '${snapshot.data!.average!.toStringAsFixed(1)}%')),
            ],
            TextButton(
              onPressed: () => setState(() => _statistics = context.read<AdminProvider>().statistics()),
              child: Text(loc.escoRetry),
            ),
          ],
        );
      },
    );
  }
}
