import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../models/payment_transaction.dart';

enum PaymentError { notConfigured, cancelled, network, failed }

class PaymentException implements Exception {
  const PaymentException(this.error, [this.message]);

  final PaymentError error;

  /// Message from Stripe (e.g. "Your card was declined."), if any.
  final String? message;

  @override
  String toString() => 'PaymentException($error, $message)';
}

/// Confirmed payment returned by [PaymentService.pay].
class PaymentReceipt {
  const PaymentReceipt({
    required this.id,
    required this.amountCents,
    required this.currency,
    required this.status,
    this.cardBrand,
    this.cardLast4,
  });

  final String id;
  final int amountCents;
  final String currency;
  final String status;
  final String? cardBrand;
  final String? cardLast4;
}

abstract class PaymentService {
  /// False when no Stripe test keys were provided or the platform has no
  /// Stripe SDK (desktop, web, tests).
  bool get isConfigured;

  /// Charges [plan]. Throws [PaymentException].
  Future<PaymentReceipt> pay({
    required PremiumPlan plan,
    required String uid,
    required String email,
    ThemeMode style = ThemeMode.system,
  });
}

class UnavailablePaymentService implements PaymentService {
  const UnavailablePaymentService();

  @override
  bool get isConfigured => false;

  @override
  Future<PaymentReceipt> pay({
    required PremiumPlan plan,
    required String uid,
    required String email,
    ThemeMode style = ThemeMode.system,
  }) async => throw const PaymentException(PaymentError.notConfigured);
}

/// Stripe **test mode** payment with the Payment Sheet.
///
/// Without a backend, the PaymentIntent is created from the app with the
/// test secret key given at build time (`--dart-define-from-file`). Only
/// `pk_test_` / `sk_test_` keys are accepted, so no real card can be charged.
/// A production app must create PaymentIntents on a server instead.
class StripePaymentService implements PaymentService {
  StripePaymentService({
    this.publishableKey = const String.fromEnvironment(
      'STRIPE_PUBLISHABLE_KEY',
    ),
    this.secretKey = const String.fromEnvironment('STRIPE_SECRET_KEY'),
    http.Client? client,
  }) : _client = client ?? http.Client();

  static const _api = 'https://api.stripe.com/v1';

  final String publishableKey;
  final String secretKey;
  final http.Client _client;
  Future<void>? _initialized;

  static bool get _supportedPlatform =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  bool get isConfigured =>
      _supportedPlatform &&
      publishableKey.startsWith('pk_test_') &&
      secretKey.startsWith('sk_test_');

  Future<void> _init() => _initialized ??= () async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }();

  @override
  Future<PaymentReceipt> pay({
    required PremiumPlan plan,
    required String uid,
    required String email,
    ThemeMode style = ThemeMode.system,
  }) async {
    if (!isConfigured) {
      throw const PaymentException(PaymentError.notConfigured);
    }
    await _init();
    final intent = await _request('POST', '/payment_intents', {
      'amount': '${plan.amountCents}',
      'currency': plan.currency,
      'description': 'CareerVerse Premium (${plan.days} days)',
      'automatic_payment_methods[enabled]': 'true',
      'metadata[uid]': uid,
      'metadata[email]': email,
      'metadata[plan]': plan.id,
    });
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: intent['client_secret'] as String,
          merchantDisplayName: 'CareerVerse',
          style: style,
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        throw const PaymentException(PaymentError.cancelled);
      }
      throw PaymentException(
        PaymentError.failed,
        e.error.localizedMessage ?? e.error.message,
      );
    }
    // Never trust the client flow alone: read the PaymentIntent back.
    final confirmed = await _request(
      'GET',
      '/payment_intents/${intent['id']}?expand[]=payment_method',
    );
    if (confirmed['status'] != 'succeeded') {
      throw PaymentException(PaymentError.failed, '${confirmed['status']}');
    }
    final method = confirmed['payment_method'];
    final card = method is Map ? method['card'] : null;
    return PaymentReceipt(
      id: confirmed['id'] as String,
      amountCents: (confirmed['amount'] as num).toInt(),
      currency: confirmed['currency'] as String,
      status: confirmed['status'] as String,
      cardBrand: card is Map ? card['brand'] as String? : null,
      cardLast4: card is Map ? card['last4'] as String? : null,
    );
  }

  Future<Map<String, dynamic>> _request(
    String method,
    String path, [
    Map<String, String>? body,
  ]) async {
    final uri = Uri.parse('$_api$path');
    final headers = {'Authorization': 'Bearer $secretKey'};
    final http.Response response;
    try {
      response =
          await (method == 'POST'
                  ? _client.post(uri, headers: headers, body: body)
                  : _client.get(uri, headers: headers))
              .timeout(const Duration(seconds: 20));
    } on SocketException {
      throw const PaymentException(PaymentError.network);
    } on TimeoutException {
      throw const PaymentException(PaymentError.network);
    } on http.ClientException {
      throw const PaymentException(PaymentError.network);
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 400) {
      final error = json['error'];
      throw PaymentException(
        PaymentError.failed,
        error is Map ? error['message'] as String? : null,
      );
    }
    return json;
  }
}
