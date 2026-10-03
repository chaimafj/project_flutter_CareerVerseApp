import 'package:careerverseapp/app.dart';
import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/providers/locale_provider.dart';
import 'package:careerverseapp/providers/theme_provider.dart';
import 'package:careerverseapp/services/ad_service.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:careerverseapp/services/notification_service.dart';
import 'package:careerverseapp/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> tapKey(WidgetTester tester, String key) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> answerLab(WidgetTester tester, String labId) async {
  for (final question in findLab(labId)!.$2.questions) {
    for (final option in question.correct) {
      await tapKey(tester, 'option-$option');
    }
    await tapKey(tester, 'sim-action'); // Check answer
    expect(find.text('Correct!'), findsOneWidget);
    await tapKey(tester, 'sim-action'); // Next question / Finish lab
  }
}

Widget buildApp(
  SharedPreferences prefs,
  AppState appState, {
  PaymentService payments = const UnavailablePaymentService(),
}) => MultiProvider(
  providers: [
    Provider.value(value: AdService(enabled: false)),
    Provider<PaymentService>.value(value: payments),
    ChangeNotifierProvider(
      create: (_) => NotificationService(
        prefs,
        navigatorKey: appNavigatorKey,
        supported: false,
      ),
    ),
    ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
    ChangeNotifierProvider(create: (_) => LocaleProvider(prefs)),
    ChangeNotifierProvider.value(value: appState),
  ],
  child: const CareerVerseApp(),
);

void useTallScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 2.625;
  addTearDown(tester.view.reset);
}

void main() {
  late LocalStore store;
  setUp(() => store = MemoryLocalStore());

  testWidgets('register, run a real lab, see results and open next lab', (
    tester,
  ) async {
    useTallScreen(tester);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final appState = AppState(prefs, store);

    await tester.pumpWidget(buildApp(prefs, appState));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Create your account'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('register-name')), 'Chaima F');
    await tester.enterText(
      find.byKey(const Key('register-email')),
      'chaima@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('register-password')),
      'secret123',
    );
    await tester.enterText(
      find.byKey(const Key('register-confirm')),
      'secret123',
    );
    await tapKey(tester, 'register-terms');
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    expect(find.text('Hello, Chaima 👋'), findsOneWidget);

    // Start the first lab from the "Up next" card.
    await tapKey(tester, 'continue-card');
    expect(find.text('Deploy a scalable web app'), findsOneWidget);
    expect(find.text('Question 1 of 4'), findsOneWidget);

    // A wrong answer is reported as such.
    await tapKey(tester, 'option-2');
    await tapKey(tester, 'sim-action');
    expect(find.text('Not quite'), findsOneWidget);
    await tapKey(tester, 'sim-action');
    expect(find.text('Question 2 of 4'), findsOneWidget);

    final rest = findLab('cloud-1')!.$2.questions.skip(1);
    for (final question in rest) {
      for (final option in question.correct) {
        await tapKey(tester, 'option-$option');
      }
      await tapKey(tester, 'sim-action');
      await tapKey(tester, 'sim-action');
    }

    expect(find.text('Lab Completed!'), findsOneWidget);
    expect(find.byKey(const Key('lottie-success')), findsOneWidget);
    expect(find.text('3/4'), findsOneWidget);
    expect(appState.results.single.correct, 3);
    expect(appState.unreadCount, 2);

    // Next Lab opens the following lab of the same career.
    await tapKey(tester, 'next-lab');
    expect(find.text('Secure access with IAM'), findsOneWidget);
    await answerLab(tester, 'cloud-2');
    expect(find.text('4/4'), findsOneWidget);
    expect(appState.completedLabs(careers.first), 2);
  });

  testWidgets('profile can be edited', (tester) async {
    useTallScreen(tester);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final appState = AppState(prefs, store);
    await appState.register(
      name: 'Old Name',
      email: 'user@example.com',
      password: 'secret123',
    );

    await tester.pumpWidget(buildApp(prefs, appState));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();
    await tapKey(tester, 'edit-profile');

    await tester.enterText(find.byKey(const Key('edit-name')), 'New Name');
    await tester.enterText(find.byKey(const Key('edit-university')), 'ESPRIT');
    await tapKey(tester, 'interest-Security');
    await tapKey(tester, 'save-profile');

    expect(find.byKey(const Key('profile-name')), findsOneWidget);
    expect(find.text('New Name'), findsWidgets);
    expect(appState.profile.university, 'ESPRIT');
    expect(appState.profile.interests, ['Security']);
  });
}
