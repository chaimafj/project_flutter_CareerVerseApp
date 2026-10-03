import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/models/payment_transaction.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:careerverseapp/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_sync_test.dart' show FakeCloudAuth, MemoryCloudStore;
import 'widget_test.dart' show buildApp, tapKey, useTallScreen;

/// Stripe stand-in: succeeds (test card 4242) unless [error] is set.
class FakePaymentService implements PaymentService {
  FakePaymentService({this.error});

  PaymentError? error;
  int calls = 0;

  @override
  bool get isConfigured => true;

  @override
  Future<PaymentReceipt> pay({
    required PremiumPlan plan,
    required String uid,
    required String email,
    ThemeMode style = ThemeMode.system,
  }) async {
    calls++;
    final failure = error;
    if (failure != null) throw PaymentException(failure, 'Card declined');
    return PaymentReceipt(
      id: 'pi_test_$calls',
      amountCents: plan.amountCents,
      currency: plan.currency,
      status: 'succeeded',
      cardBrand: 'visa',
      cardLast4: '4242',
    );
  }
}

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  final advanced = careers.first.labs.firstWhere((lab) => lab.isPremium);
  final beginner = careers.first.labs.first;

  Future<AppState> registered(LocalStore store) async {
    final state = AppState(prefs, store);
    await state.register(
      name: 'Chaima',
      email: 'chaima@example.com',
      password: 'secret123',
    );
    return state;
  }

  test('advanced labs are locked until Premium is bought', () async {
    final store = MemoryLocalStore();
    final state = await registered(store);
    expect(state.isPremium, isFalse);
    expect(state.isLabLocked(advanced), isTrue);
    expect(state.isLabLocked(beginner), isFalse);

    final payments = FakePaymentService();
    final first = await state.buyPremium(payments);
    expect(state.isPremium, isTrue);
    expect(state.isLabLocked(advanced), isFalse);
    expect(first.id, 'pi_test_1');
    expect(first.cardLast4, '4242');
    expect(
      first.premiumUntil.difference(DateTime.now()).inDays,
      PremiumPlan.monthly.days - 1,
    );
    expect(state.notifications.first.read, isFalse);

    // A second payment extends the current period.
    final second = await state.buyPremium(payments);
    expect(
      second.premiumUntil.difference(first.premiumUntil).inDays,
      PremiumPlan.monthly.days,
    );

    // Stored offline: still Premium after a restart and after a reset.
    final restarted = AppState(prefs, store);
    expect(restarted.transactions, hasLength(2));
    expect(restarted.isPremium, isTrue);
    await restarted.resetProgress();
    expect(restarted.isPremium, isTrue);
  });

  test('failed or cancelled payments grant nothing', () async {
    final state = await registered(MemoryLocalStore());
    final payments = FakePaymentService(error: PaymentError.cancelled);
    await expectLater(
      state.buyPremium(payments),
      throwsA(isA<PaymentException>()),
    );
    payments.error = PaymentError.failed;
    await expectLater(
      state.buyPremium(payments),
      throwsA(
        isA<PaymentException>().having(
          (e) => e.message,
          'message',
          'Card declined',
        ),
      ),
    );
    expect(state.transactions, isEmpty);
    expect(state.isLabLocked(advanced), isTrue);
  });

  test('expired Premium locks advanced labs again', () async {
    final store = MemoryLocalStore();
    await registered(store);
    final old = PaymentTransaction(
      id: 'pi_old',
      plan: PremiumPlan.monthly.id,
      amountCents: 499,
      currency: 'eur',
      status: 'succeeded',
      createdAt: DateTime.now().subtract(const Duration(days: 40)),
      premiumUntil: DateTime.now().subtract(const Duration(days: 10)),
    );
    await store.write(LocalStore.transactions, 'chaima@example.com', [
      old.toJson(),
    ]);
    final restarted = AppState(prefs, store);
    expect(restarted.premiumUntil, isNotNull);
    expect(restarted.isPremium, isFalse);
    expect(restarted.isLabLocked(advanced), isTrue);
  });

  test(
    'Premium is saved in Firestore and restored on another device',
    () async {
      final accounts = <String, String>{};
      final cloud = MemoryCloudStore();
      final phone = AppState(
        prefs,
        MemoryLocalStore(),
        auth: FakeCloudAuth(accounts),
        cloud: cloud,
      );
      await phone.register(
        name: 'Chaima',
        email: 'chaima@example.com',
        password: 'secret123',
      );
      await phone.buyPremium(FakePaymentService());
      final saved = cloud.docs['uid-chaima@example.com/transactions']!;
      expect(saved.keys, ['pi_test_1']);
      expect(saved['pi_test_1']!['amountCents'], 499);
      expect(saved['pi_test_1']!['testMode'], isTrue);

      final tablet = AppState(
        prefs,
        MemoryLocalStore(),
        auth: FakeCloudAuth(accounts),
        cloud: cloud,
      );
      expect(await tablet.login('chaima@example.com', 'secret123'), isNull);
      expect(tablet.isPremium, isTrue);
      expect(tablet.transactions.single.id, 'pi_test_1');
    },
  );

  test('Stripe service only accepts test keys on mobile', () async {
    final live = StripePaymentService(
      publishableKey: 'pk_live_123',
      secretKey: 'sk_live_123',
    );
    expect(live.isConfigured, isFalse);
    await expectLater(
      live.pay(plan: PremiumPlan.monthly, uid: 'u', email: 'e@example.com'),
      throwsA(
        isA<PaymentException>().having(
          (e) => e.error,
          'error',
          PaymentError.notConfigured,
        ),
      ),
    );
  });

  testWidgets('locked lab opens the paywall, paying starts the lab', (
    tester,
  ) async {
    useTallScreen(tester);
    final state = await registered(MemoryLocalStore());
    final payments = FakePaymentService();
    await tester.pumpWidget(buildApp(prefs, state, payments: payments));
    await tester.pumpAndSettle();

    tester
        .state<NavigatorState>(find.byType(Navigator).first)
        .pushNamed('/simulation', arguments: advanced.id);
    await tester.pumpAndSettle();
    expect(find.text('Premium lab'), findsOneWidget);
    expect(find.byKey(const Key('option-0')), findsNothing);

    await tapKey(tester, 'unlock-premium');
    expect(find.text('CareerVerse Premium'), findsOneWidget);
    expect(find.text('Free plan'), findsOneWidget);
    expect(find.text('No transactions yet.'), findsOneWidget);

    await tapKey(tester, 'premium-buy');
    expect(payments.calls, 1);
    expect(state.isPremium, isTrue);
    // Back on the lab, which now starts.
    expect(find.text(advanced.title), findsWidgets);
    expect(find.byKey(const Key('option-0')), findsOneWidget);
  });

  testWidgets('premium screen shows the error and history', (tester) async {
    useTallScreen(tester);
    final state = await registered(MemoryLocalStore());
    final payments = FakePaymentService(error: PaymentError.failed);
    await tester.pumpWidget(buildApp(prefs, state, payments: payments));
    await tester.pumpAndSettle();
    tester
        .state<NavigatorState>(find.byType(Navigator).first)
        .pushNamed('/premium');
    await tester.pumpAndSettle();

    await tapKey(tester, 'premium-buy');
    expect(find.text('Payment failed: Card declined'), findsOneWidget);
    expect(state.transactions, isEmpty);

    payments.error = null;
    await state.buyPremium(payments);
    await tester.pumpAndSettle();
    expect(find.textContaining('Premium active until'), findsWidgets);
    expect(find.textContaining('visa •••• 4242'), findsOneWidget);
  });
}
