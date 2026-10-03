import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/data/courses.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/screens/learning_path_screen.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_sync_test.dart' show FakeCloudAuth, MemoryCloudStore;
import 'widget_test.dart' show buildApp, tapKey, useTallScreen;

void main() {
  late SharedPreferences prefs;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  test('every lab has a course in English, French and Arabic', () {
    final labIds = [
      for (final career in careers) ...career.labs.map((lab) => lab.id),
    ];
    expect(labIds, hasLength(27));
    for (final id in labIds) {
      final en = coursesByLanguage['en']![id]!;
      for (final translated in [
        coursesByLanguage['fr']![id]!,
        coursesByLanguage['ar']![id]!,
      ]) {
        expect(translated.labId, id);
        expect(translated.sections.length, en.sections.length, reason: id);
        expect(translated.takeaways.length, en.takeaways.length, reason: id);
        for (var i = 0; i < en.sections.length; i++) {
          expect(
            translated.sections[i].points.length,
            en.sections[i].points.length,
            reason: '$id section $i',
          );
          expect(translated.sections[i].body, isNotEmpty);
        }
      }
      expect(allCourseExamples[id], hasLength(en.sections.length), reason: id);
    }
  });

  test('courseFor follows the catalog language with examples', () {
    addTearDown(() => setCatalogLanguage('en'));
    setCatalogLanguage('fr');
    final course = courseFor('cloud-1')!;
    expect(course.intro, coursesByLanguage['fr']!['cloud-1']!.intro);
    expect(course.sections.any((s) => s.example != null), isTrue);
    expect(course.minutes, greaterThanOrEqualTo(3));
    setCatalogLanguage('ar');
    expect(
      courseFor('cloud-1')!.intro,
      coursesByLanguage['ar']!['cloud-1']!.intro,
    );
    expect(courseFor('unknown'), isNull);
  });

  test('completed courses persist offline, sync and reset', () async {
    final store = MemoryLocalStore();
    final accounts = <String, String>{};
    final cloud = MemoryCloudStore();
    AppState device(LocalStore s) =>
        AppState(prefs, s, auth: FakeCloudAuth(accounts), cloud: cloud);

    final phone = device(store);
    await phone.register(name: 'Sara', email: 'sara@x.com', password: 'p');
    expect(phone.isCourseCompleted('cloud-1'), isFalse);
    await phone.completeCourse('cloud-1');
    expect(phone.completedCourses(careers.first), 1);
    expect(cloud.docs['uid-sara@x.com/courses']!.keys, ['cloud-1']);

    // Same device after a restart (offline copy).
    final reopened = device(store);
    await reopened.login('sara@x.com', 'p');
    expect(reopened.isCourseCompleted('cloud-1'), isTrue);

    // Another device restores it from the cloud.
    final tablet = device(MemoryLocalStore());
    await tablet.login('sara@x.com', 'p');
    expect(tablet.isCourseCompleted('cloud-1'), isTrue);

    await tablet.resetProgress();
    expect(tablet.isCourseCompleted('cloud-1'), isFalse);
    expect(cloud.docs['uid-sara@x.com/courses'], isEmpty);
  });

  testWidgets('learning path: read the course, then start the lab', (
    tester,
  ) async {
    useTallScreen(tester);
    final state = AppState(prefs, MemoryLocalStore());
    await state.register(name: 'Sara', email: 'sara@x.com', password: 'p');
    await tester.pumpWidget(buildApp(prefs, state));
    await tester.pumpAndSettle();

    Navigator.of(tester.element(find.byType(Scaffold).first))
        .pushNamed('/learning-path', arguments: 'cloud');
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('course-cloud-1')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('path-cta')),
      300,
      scrollable: find
          .descendant(
            of: find.byType(LearningPathScreen),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    expect(find.text('Read the course: Deploy a scalable web app'), findsOne);

    await tapKey(tester, 'path-cta');
    final course = courseFor('cloud-1')!;
    expect(find.text('Lesson 1/${course.sections.length}'), findsOneWidget);
    expect(find.text(course.sections.first.title), findsOneWidget);
    expect(find.text('Key points'), findsOneWidget);

    for (var i = 1; i < course.sections.length; i++) {
      await tapKey(tester, 'course-next');
      expect(find.text(course.sections[i].title), findsWidgets);
    }
    await tapKey(tester, 'course-next');
    expect(find.text('Key takeaways'), findsOneWidget);
    expect(find.text(course.takeaways.first), findsOneWidget);

    await tapKey(tester, 'finish-start-lab');
    expect(state.isCourseCompleted('cloud-1'), isTrue);
    expect(find.text('Question 1 of 4'), findsOneWidget);
  });
}
