/// Premium offer sold in the app (Stripe test mode).
class PremiumPlan {
  const PremiumPlan({
    required this.id,
    required this.amountCents,
    required this.currency,
    required this.days,
  });

  final String id;
  final int amountCents;
  final String currency;

  /// Premium access granted by one payment.
  final int days;

  static const monthly = PremiumPlan(
    id: 'premium_monthly',
    amountCents: 499,
    currency: 'eur',
    days: 30,
  );

  String get price {
    final value = (amountCents / 100).toStringAsFixed(2);
    return currency == 'eur' ? '$value €' : '$value ${currency.toUpperCase()}';
  }
}

/// A successful payment, stored offline (Hive) and in Firestore
/// (`users/{uid}/transactions/{id}`). Premium access is derived from these
/// records, so it follows the user on every device.
class PaymentTransaction {
  const PaymentTransaction({
    required this.id,
    required this.plan,
    required this.amountCents,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.premiumUntil,
    this.provider = 'stripe',
    this.cardBrand,
    this.cardLast4,
    this.testMode = true,
  });

  /// Stripe PaymentIntent id (`pi_...`).
  final String id;
  final String plan;
  final int amountCents;
  final String currency;
  final String status;
  final DateTime createdAt;
  final DateTime premiumUntil;
  final String provider;
  final String? cardBrand;
  final String? cardLast4;
  final bool testMode;

  String get price => PremiumPlan(
    id: plan,
    amountCents: amountCents,
    currency: currency,
    days: 0,
  ).price;

  Map<String, dynamic> toJson() => {
    'id': id,
    'plan': plan,
    'amountCents': amountCents,
    'currency': currency,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'premiumUntil': premiumUntil.toIso8601String(),
    'provider': provider,
    'cardBrand': cardBrand,
    'cardLast4': cardLast4,
    'testMode': testMode,
  };

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      PaymentTransaction(
        id: json['id'] as String,
        plan: json['plan'] as String? ?? PremiumPlan.monthly.id,
        amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
        currency: json['currency'] as String? ?? 'eur',
        status: json['status'] as String? ?? 'succeeded',
        createdAt: DateTime.parse(json['createdAt'] as String),
        premiumUntil: DateTime.parse(json['premiumUntil'] as String),
        provider: json['provider'] as String? ?? 'stripe',
        cardBrand: json['cardBrand'] as String?,
        cardLast4: json['cardLast4'] as String?,
        testMode: json['testMode'] as bool? ?? true,
      );
}
