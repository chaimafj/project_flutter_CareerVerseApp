import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/l10n/content_ar.dart';
import 'package:careerverseapp/l10n/content_fr.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget_test.dart' show buildApp, tapKey, useTallScreen;

/// Every translatable English string of the catalog.
Set<String> englishContent() {
  setCatalogLanguage('en');
  final strings = <String>{...allInterests, ...studyLevels};
  String record(String s) {
    strings.add(s);
    return s;
  }

  for (final career in careers) {
    career.translate(record);
    for (final lab in career.labs) {
      strings.add(lab.level);
      strings.addAll(lab.skills);
    }
  }
  return strings;
}

void main() {
  late LocalStore store;
  setUp(() => store = MemoryLocalStore());
  tearDown(() => setCatalogLanguage('en'));

  test('all career content is translated in French and Arabic', () {
    final content = englishContent();
    expect(content.where((s) => !contentFr.containsKey(s)), isEmpty);
    expect(content.where((s) => !contentAr.containsKey(s)), isEmpty);
  });

  test('catalog follows the selected language', () {
    setCatalogLanguage('en');
    final english = careers.first;
    setCatalogLanguage('fr');
    expect(careers.first.id, english.id);
    expect(careers.first.title, contentFr[english.title]);
    expect(
      careers.first.labs.first.questions.first.prompt,
      contentFr[english.labs.first.questions.first.prompt],
    );
    setCatalogLanguage('ar');
    expect(careers.first.title, contentAr[english.title]);
  });

  testWidgets('app is displayed in French', (tester) async {
    useTallScreen(tester);
    SharedPreferences.setMockInitialValues({'locale': 'fr'});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(buildApp(prefs, AppState(prefs, store)));
    await tester.pumpAndSettle();

    expect(find.text('Commencer'), findsOneWidget);
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();
    expect(find.text('Créez votre compte'), findsOneWidget);
  });

  testWidgets('home screen shows translated careers in French', (tester) async {
    useTallScreen(tester);
    SharedPreferences.setMockInitialValues({'locale': 'fr'});
    final prefs = await SharedPreferences.getInstance();
    final state = AppState(prefs, store);
    await state.register(name: 'Chaima', email: 'c@c.com', password: '123456');

    await tester.pumpWidget(buildApp(prefs, state));
    await tester.pumpAndSettle();

    expect(find.text('Bonjour, Chaima 👋'), findsOneWidget);
    expect(find.text('Accueil'), findsOneWidget);
    expect(find.textContaining(careers.first.title), findsWidgets);
  });

  testWidgets('Arabic uses right-to-left layout', (tester) async {
    useTallScreen(tester);
    SharedPreferences.setMockInitialValues({'locale': 'ar'});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(buildApp(prefs, AppState(prefs, store)));
    await tester.pumpAndSettle();

    final button = find.text('ابدأ الآن');
    expect(button, findsOneWidget);
    expect(Directionality.of(tester.element(button)), TextDirection.rtl);
  });

  testWidgets('a full lab and every screen render in Arabic', (tester) async {
    useTallScreen(tester);
    SharedPreferences.setMockInitialValues({'locale': 'ar'});
    final prefs = await SharedPreferences.getInstance();
    final state = AppState(prefs, store);
    await state.register(name: 'Chaima', email: 'a@a.com', password: '123456');
    await state.updateProfile(
      state.profile.copyWith(interests: ['Security', 'Cloud']),
    );

    await tester.pumpWidget(buildApp(prefs, state));
    await tester.pumpAndSettle();
    expect(find.text('مرحبًا، Chaima 👋'), findsOneWidget);

    await tapKey(tester, 'continue-card');
    expect(find.text('السؤال 1 من 4'), findsOneWidget);
    for (final question in findLab('cloud-1')!.$2.questions) {
      for (final option in question.correct) {
        await tapKey(tester, 'option-$option');
      }
      await tapKey(tester, 'sim-action');
      expect(find.text('صحيح!'), findsOneWidget);
      await tapKey(tester, 'sim-action');
    }
    expect(find.text('اكتمل المختبر!'), findsOneWidget);

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    for (final route in [
      '/recommendations',
      '/notifications',
      '/settings',
      '/edit-profile',
    ]) {
      navigator.pushNamed(route);
      await tester.pumpAndSettle();
    }
    navigator.popUntil((route) => route.isFirst);
    await tester.pumpAndSettle();
    for (final tab in ['المختبرات', 'استكشاف', 'التقدّم', 'الملف الشخصي']) {
      await tester.tap(find.text(tab).last);
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });
}
