import 'dart:convert';

import 'package:careerverseapp/app.dart';
import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/data/courses.dart';
import 'package:careerverseapp/data/managed_catalog.dart';
import 'package:careerverseapp/models/lab_result.dart';
import 'package:careerverseapp/models/managed_career.dart';
import 'package:careerverseapp/providers/admin_provider.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/screens/admin_screen.dart';
import 'package:careerverseapp/screens/admin_career_editor.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:careerverseapp/services/firestore_service.dart';
import 'package:careerverseapp/widgets/admin_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget_test.dart' show buildApp, useTallScreen;
import 'firebase_sync_test.dart' show FakeCloudAuth, MemoryCloudStore;

class DeletedStudentCloud extends MemoryCloudStore {
  @override
  Future<CloudSnapshot?> load(String uid) async => const CloudSnapshot(deleted: true);
}

class MemoryAdmin extends AdminProvider {
  MemoryAdmin(super.prefs);

  bool authorized = true;
  ManagedCareer? saved;
  String? deletedCareer;

  @override
  bool get isAdmin => authorized;

  void revoke() {
    authorized = false;
    notifyListeners();
  }

  @override
  Future<List<AdminStudent>> students() async => [];

  @override
  Future<AdminStatistics> statistics() async =>
      const AdminStatistics(students: 0, attempts: 0, average: null);

  @override
  Future<void> saveCareer(ManagedCareer career) async {
    if (!authorized) throw StateError('Access denied');
    saved = career;
  }

  @override
  Future<void> deleteCareer(String id) async {
    if (!authorized) throw StateError('Access denied');
    deletedCareer = id;
  }
}

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    setCatalogLanguage('en');
    managedCareers.clear();
    deletedCareerIds.clear();
    deletedLabIds.clear();
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });
  tearDown(() {
    managedCareers.clear();
    deletedCareerIds.clear();
    deletedLabIds.clear();
    setCatalogLanguage('en');
  });

  test('permanent deletion removes built-ins and cached courses and prunes progress', () async {
    final store = MemoryLocalStore();
    final state = AppState(prefs, store);
    await state.register(name: 'Test', email: 'test@example.test', password: 'secret123');
    final career = careerById('flutter')!;
    final lab = career.labs.first;
    await state.recordResult(career: career, lab: lab, answers: const [], durationSeconds: 1);
    await state.completeCourse(lab.id);
    expect(courseFor(lab.id), isNotNull);
    await prefs.setString('managed_career_catalog_v1', jsonEncode([
      {'id': 'flutter', 'deleted': true, 'labIds': career.labs.map((l) => l.id).toList()},
    ]));
    final provider = AdminProvider(prefs, onCatalogChanged: state.catalogChanged);
    expect(careerById('flutter'), isNull);
    expect(findLab(lab.id), isNull);
    expect(courseFor(lab.id), isNull);
    expect(state.results, isEmpty);
    expect(state.isCourseCompleted(lab.id), isFalse);
    expect(state.notifications.any((n) => n.data['labId'] == lab.id), isFalse);
    await expectLater(state.recordResult(
      career: career, lab: lab, answers: const [], durationSeconds: 1,
    ), throwsStateError);
    provider.dispose();
    state.dispose();
  });

  test('career cleanup targets all linked records without deleting unrelated data', () {
    for (final record in [
      {'careerId': 'angular'},
      {'labId': 'angular-1'},
      {'data': {'labId': 'angular-1'}},
      {'data': {'topCareerId': 'angular'}},
      {'resultId': 'result-1'},
    ]) {
      expect(AdminProvider.referencesCareer(record, 'angular', {'angular-1'}, {'result-1'}), isTrue);
    }
    expect(AdminProvider.referencesCareer({'careerId': 'java', 'labId': 'java-1'},
      'angular', {'angular-1'}, {'result-1'}), isFalse);
  });

  test('deleted Firestore student cannot restore local data on sign-in', () async {
    final store = MemoryLocalStore();
    await store.write(LocalStore.profiles, 'test@example.test', {'name': 'Test',
      'email': 'test@example.test', 'createdAt': DateTime.now().toIso8601String()});
    final auth = FakeCloudAuth({'test@example.test': 'secret123'});
    final cloud = DeletedStudentCloud();
    final state = AppState(prefs, store, auth: auth, cloud: cloud);
    expect(await state.login('test@example.test', 'secret123'), AuthError.noAccount);
    expect(state.isLoggedIn, isFalse);
    expect(auth.currentUser, isNull);
    expect(store.read(LocalStore.profiles, 'test@example.test'), isNull);
    expect(cloud.users, isEmpty);
    state.dispose();
  });

  testWidgets('permanent career deletion requires confirmation and supports cancellation', (tester) async {
    useTallScreen(tester);
    final state = AppState(prefs, MemoryLocalStore());
    final admin = MemoryAdmin(prefs);
    await tester.pumpWidget(buildApp(prefs, state, admin: admin));
    await tester.pumpAndSettle();
    appNavigatorKey.currentState!.pushNamed('/admin');
    await tester.pumpAndSettle();
    final button = find.byKey(const ValueKey('delete-career-cloud'));
    await tester.ensureVisible(button);
    await tester.tap(find.descendant(of: button, matching: find.byType(IconButton)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(admin.deletedCareer, isNull);
    await tester.tap(find.descendant(of: button, matching: find.byType(IconButton)));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete permanently'));
    await tester.pumpAndSettle();
    expect(admin.deletedCareer, 'cloud');
  });

  test(
    'every built-in career can be edited with all courses and translations',
    () {
      for (final career in careers) {
        final document = editableCareer(career.id);
        final decoded = ManagedCareer.fromJson(document);
        expect(decoded.career('en').labs.length, career.labs.length);
        for (final language in ['en', 'fr', 'ar']) {
          for (final lab in decoded.career(language).labs) {
            expect(decoded.course(language, lab.id).sections, isNotEmpty);
          }
        }
      }
    },
  );

  test('English-only careers provide labs and courses in every app language', () {
    final data = editableCareer('flutter');
    final english = data['variants']['en'];
    data['variants'] = {'en': english};
    final managed = ManagedCareer.fromJson(data);
    expect(managed.toJson()['variants'], hasLength(1));
    managedCareers['flutter'] = managed;
    for (final language in ['en', 'fr', 'ar']) {
      setCatalogLanguage(language);
      final career = careerById('flutter')!;
      expect(career.title, english['title']);
      expect(career.labs.first.title, english['labs'][0]['title']);
      expect(courseFor(career.labs.first.id)!.intro,
          english['courses'][career.labs.first.id]['intro']);
    }
    data['variants'] = {'fr': english};
    expect(() => ManagedCareer.fromJson(data), throwsFormatException);
  });

  testWidgets('publishing requires English only and keeps English validation', (tester) async {
    useTallScreen(tester);
    final state = AppState(prefs, MemoryLocalStore());
    final admin = MemoryAdmin(prefs);
    final data = editableCareer('flutter');
    data['variants'] = {'en': data['variants']['en']};
    await tester.pumpWidget(buildApp(prefs, state, admin: admin));
    await tester.pumpAndSettle();
    appNavigatorKey.currentState!.push(MaterialPageRoute<void>(
      builder: (_) => AdminCareerEditor(initial: data),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Content in English'), findsOneWidget);
    final title = find.widgetWithText(TextFormField, 'Flutter Mobile Developer');
    await tester.enterText(title, '');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('admin-publish')));
    await tester.pumpAndSettle();
    expect(admin.saved, isNull);
    expect(find.text('Operation failed: Required text is missing'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'Title').first, 'Angular Developer');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('admin-publish')));
    await tester.pumpAndSettle();
    expect(admin.saved!.variants.keys, ['en']);
    expect(admin.saved!.career('ar').title, 'Angular Developer');
    expect(admin.saved!.course('fr', 'flutter-1').sections, isNotEmpty);
  });

  test(
    'rejects bad answer keys, mismatched translations and duplicate labs',
    () {
      for (final mutate in <void Function(Map<String, dynamic>)>[
        (data) =>
            data['variants']['en']['labs'][0]['questions'][0]['correct'] = [99],
        (data) =>
            data['variants']['fr']['labs'][0]['questions'][0]['correct'] = [],
        (data) => data['variants']['en']['labs'][1]['id'] =
            data['variants']['en']['labs'][0]['id'],
        (data) => data['variants']['en']['labs'][0]['secondsPerQuestion'] = 0,
        (data) => data['variants']['en']['labs'][0]['correctnessWeight'] = 2,
        (data) => data['variants']['en']['labs'][0]['passMark'] = 101,
        (data) => data['variants']['en']['courses'].clear(),
      ]) {
        final data = editableCareer('flutter');
        mutate(data);
        expect(() => ManagedCareer.fromJson(data), throwsFormatException);
      }
    },
  );

  test(
    'published content updates career, course and language used by students',
    () {
      final data = editableCareer('flutter');
      data['variants']['en']['title'] = 'Published Flutter';
      data['variants']['fr']['title'] = 'Flutter publié';
      final labId = careerById('flutter')!.labs.first.id;
      data['variants']['en']['courses'][labId]['intro'] =
          'New course explanation';
      managedCareers['flutter'] = ManagedCareer.fromJson(data);
      expect(careerById('flutter')!.title, 'Published Flutter');
      expect(courseFor(labId)!.intro, 'New course explanation');
      setCatalogLanguage('fr');
      expect(careerById('flutter')!.title, 'Flutter publié');
    },
  );

  test(
    'archiving excludes discovery and matches but preserves historic labs',
    () async {
      final state = AppState(prefs, MemoryLocalStore());
      await state.register(
        name: 'Test',
        email: 'student@example.test',
        password: 'secret123',
      );
      final data = editableCareer('flutter')..['archived'] = true;
      managedCareers['flutter'] = ManagedCareer.fromJson(data);
      expect(activeCareers.any((career) => career.id == 'flutter'), isFalse);
      expect(
        state.matches.any((match) => match.career.id == 'flutter'),
        isFalse,
      );
      final career = careerById('flutter')!;
      final lab = career.labs.first;
      expect(findLab(lab.id), isNotNull);
      expect(state.matchForCareer(career).career.id, 'flutter');
      expect(state.nextLab(lab.id)?.$1.id, isNot('flutter'));
      state.dispose();
    },
  );

  test(
    'assessment criteria affect scoring and are saved with each result',
    () async {
      final state = AppState(prefs, MemoryLocalStore());
      await state.register(
        name: 'Test',
        email: 'student@example.test',
        password: 'secret123',
      );
      final data = editableCareer('flutter');
      for (final language in ['en', 'fr', 'ar']) {
        final lab = data['variants'][language]['labs'][0];
        lab['secondsPerQuestion'] = 10;
        lab['correctnessWeight'] = 1.0;
        lab['passMark'] = 95;
      }
      managedCareers['flutter'] = ManagedCareer.fromJson(data);
      final career = careerById('flutter')!;
      final result = await state.recordResult(
        career: career,
        lab: career.labs.first,
        answers: const [],
        durationSeconds: 1,
      );
      expect(result.overall, 0);
      expect(result.passed, isFalse);
      expect(result.expectedSeconds, career.labs.first.questions.length * 10);
      managedCareers.clear();
      final restored = LabResult.fromJson(result.toJson());
      expect(restored.overall, 0);
      expect(restored.passMark, 95);
      expect(restored.correctnessWeight, 1);
      state.dispose();
    },
  );

  test(
    'all careers can be archived without breaking result recording',
    () async {
      for (final career in careers) {
        final data = editableCareer(career.id)..['archived'] = true;
        managedCareers[career.id] = ManagedCareer.fromJson(data);
      }
      final state = AppState(prefs, MemoryLocalStore());
      final career = careerById('flutter')!;
      expect(state.matches, isEmpty);
      await state.register(
        name: 'Test',
        email: 'student@example.test',
        password: 'secret123',
      );
      final result = await state.recordResult(
        career: career,
        lab: career.labs.first,
        answers: const [],
        durationSeconds: 1,
      );
      expect(state.resultById(result.id), isNotNull);
      expect(state.nextLab(career.labs.first.id), isNull);
      state.dispose();
    },
  );

  test('local account cannot perform administrator writes', () async {
    final admin = AdminProvider(prefs);
    expect(admin.isAdmin, isFalse);
    await expectLater(admin.students(), throwsStateError);
    await expectLater(
      admin.saveCareer(ManagedCareer.fromJson(editableCareer('flutter'))),
      throwsStateError,
    );
    admin.dispose();
  });

  test(
    'validated cached content restores offline without granting a role',
    () async {
      final data = editableCareer('flutter');
      data['variants']['en']['title'] = 'Offline managed Flutter';
      await prefs.setString('managed_career_catalog_v1', jsonEncode([data]));
      var updates = 0;
      final admin = AdminProvider(prefs, onCatalogChanged: () => updates++);
      expect(careerById('flutter')!.title, 'Offline managed Flutter');
      expect(updates, 1);
      expect(admin.isAdmin, isFalse);
      admin.dispose();
    },
  );

  test('new careers and their courses enter the shared student catalogue', () {
    final data = editableCareer('flutter');
    data['id'] = 'new-mobile';
    for (final language in ['en', 'fr', 'ar']) {
      final variant = data['variants'][language];
      final courses = <String, dynamic>{};
      for (var index = 0; index < (variant['labs'] as List).length; index++) {
        final lab = variant['labs'][index];
        final oldId = lab['id'];
        final newId = 'new-mobile-${index + 1}';
        courses[newId] = variant['courses'][oldId];
        lab['id'] = newId;
      }
      variant['courses'] = courses;
    }
    managedCareers['new-mobile'] = ManagedCareer.fromJson(data);
    expect(activeCareers.length, 10);
    expect(findLab('new-mobile-1')!.$1.id, 'new-mobile');
    expect(courseFor('new-mobile-1'), isNotNull);
    final state = AppState(prefs, MemoryLocalStore());
    expect(
      state.matches.any((match) => match.career.id == 'new-mobile'),
      isTrue,
    );
    state.dispose();
  });

  test('statistics use Firestore score fields and distinguish empty data', () {
    final stats = AdminStatistics.fromRecords([
      {'score': 80},
      {'score': 60},
      {'score': 40},
    ], students: 2);
    expect(stats.average, 60);
    expect(stats.attempts, 3);
    expect(stats.students, 2);
    expect(AdminStatistics.fromRecords([], students: 0).average, isNull);
    expect(
      () => AdminStatistics.fromRecords([
        {'score': 101},
      ], students: 1),
      throwsFormatException,
    );
  });

  testWidgets('admin route is protected for an ordinary user', (tester) async {
    useTallScreen(tester);
    final state = AppState(prefs, MemoryLocalStore());
    await tester.pumpWidget(buildApp(prefs, state));
    await tester.pumpAndSettle();
    appNavigatorKey.currentState!.pushNamed('/admin');
    await tester.pumpAndSettle();
    expect(find.text('Administrator access is required.'), findsOneWidget);
    expect(find.byKey(const Key('admin-add-career')), findsNothing);
  });

  testWidgets('admin edits translated content and publishes validated career', (
    tester,
  ) async {
    useTallScreen(tester);
    final state = AppState(prefs, MemoryLocalStore());
    final admin = MemoryAdmin(prefs);
    await tester.pumpWidget(buildApp(prefs, state, admin: admin));
    await tester.pumpAndSettle();
    appNavigatorKey.currentState!.pushNamed('/admin');
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Flutter Mobile Developer'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Flutter Mobile Developer'));
    await tester.pumpAndSettle();
    final title = find.widgetWithText(
      TextFormField,
      'Flutter Mobile Developer',
    );
    await tester.enterText(title, 'Flutter managed by admin');
    final publish = find.byKey(const Key('admin-publish'));
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.tap(publish);
    await tester.pumpAndSettle();
    expect(admin.saved!.career('en').title, 'Flutter managed by admin');
    expect(admin.saved!.career('fr').title, isNotEmpty);
  });

  testWidgets('role revocation closes the admin editor access', (tester) async {
    useTallScreen(tester);
    final state = AppState(prefs, MemoryLocalStore());
    final admin = MemoryAdmin(prefs);
    await tester.pumpWidget(buildApp(prefs, state, admin: admin));
    await tester.pumpAndSettle();
    appNavigatorKey.currentState!.pushNamed('/admin');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('admin-add-career')));
    await tester.pumpAndSettle();
    admin.revoke();
    await tester.pumpAndSettle();
    expect(find.text('Administrator access is required.'), findsOneWidget);
    expect(find.byKey(const Key('admin-publish')), findsNothing);
  });

  testWidgets('admin dashboard supports narrow Arabic dark mode and all tabs', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 760);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await prefs.setString('locale', 'ar');
    await prefs.setString('theme_mode', 'dark');
    final state = AppState(prefs, MemoryLocalStore());
    final admin = MemoryAdmin(prefs);
    await tester.pumpWidget(buildApp(prefs, state, admin: admin));
    await tester.pumpAndSettle();
    appNavigatorKey.currentState!.pushNamed('/admin');
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final context = tester.element(find.byType(AdminScreen));
    expect(Directionality.of(context), TextDirection.rtl);
    expect(Theme.of(context).brightness, Brightness.dark);
    expect(find.byType(AdminMetric), findsNWidgets(2));
    await tester.tap(find.text('الطلاب'));
    await tester.pumpAndSettle();
    expect(find.text('لا توجد ملفات طلاب بعد.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('الإحصاءات'));
    await tester.pumpAndSettle();
    expect(find.byType(AdminMetric), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });

  testWidgets('English-only editor preserves edits and expands labs', (
    tester,
  ) async {
    useTallScreen(tester);
    final state = AppState(prefs, MemoryLocalStore());
    final admin = MemoryAdmin(prefs);
    await tester.pumpWidget(buildApp(prefs, state, admin: admin));
    await tester.pumpAndSettle();
    appNavigatorKey.currentState!.pushNamed('/admin');
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Flutter Mobile Developer'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Flutter Mobile Developer'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Flutter Mobile Developer'),
      'Preserved title',
    );
    expect(find.byType(SegmentedButton<String>), findsNothing);
    expect(find.text('Content in English'), findsOneWidget);
    expect(
      find.widgetWithText(TextFormField, 'Preserved title'),
      findsOneWidget,
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    final section = find.byKey(const ValueKey('en/flutter-1'));
    final scrollable = find
        .descendant(
          of: find.byKey(const Key('admin-career-form')),
          matching: find.byType(Scrollable),
        )
        .first;
    final position = tester.state<ScrollableState>(scrollable).position;
    position.jumpTo(position.maxScrollExtent);
    await tester.pumpAndSettle();
    expect(section, findsOneWidget);
    await tester.ensureVisible(section);
    await tester.tap(
      find.descendant(of: section, matching: find.text('Labs 1')),
    );
    await tester.pumpAndSettle();
    expect(tester.widget<ExpansionTile>(section).maintainState, isTrue);
    expect(
      find.widgetWithText(TextFormField, 'Simulation scenario'),
      findsWidgets,
    );
    expect(tester.takeException(), isNull);
  });
}
