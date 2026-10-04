import 'dart:convert';

import 'package:careerverseapp/l10n/app_localizations.dart';
import 'package:careerverseapp/models/user_profile.dart';
import 'package:careerverseapp/providers/salary_currency_provider.dart';
import 'package:careerverseapp/services/exchange_rate_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('exchange-rate service parses EUR currency rates', () async {
    final service = ExchangeRateService(
      client: MockClient((request) async {
        expect(request.url.host, 'open.er-api.com');
        expect(request.url.path, '/v6/latest/EUR');
        return http.Response(
          jsonEncode({
            'result': 'success',
            'base_code': 'EUR',
            'time_last_update_utc': 'Sat, 03 Oct 2026 00:02:32 +0000',
            'rates': {'TND': 3.364571, 'USD': 1.125175},
          }),
          200,
        );
      }),
    );

    final rates = await service.fetchEuroRates();
    expect(rates.base, 'EUR');
    expect(rates.rates['TND'], 3.364571);
    expect(rates.rates['USD'], 1.125175);
    expect(rates.updatedAt, DateTime.utc(2026, 10, 3, 0, 2, 32));
  });

  test('salary stays in EUR until a country is selected', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final loc = lookupAppLocalizations(const Locale('en'));
    final provider = SalaryCurrencyProvider(prefs, autoRefresh: false);
    const salary = '40k – 65k € / year';

    expect(provider.formatSalary(salary, null, loc, localeCode: 'en'), salary);
    expect(provider.formatSalary(salary, 'FR', loc, localeCode: 'en'), salary);
    expect(
      provider.formatSalary(salary, 'TN', loc, localeCode: 'en'),
      loc.exchangeRateUnavailable,
    );
  });

  test('converts to the selected currency and persists daily rates', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final service = ExchangeRateService(
      client: MockClient((_) async {
        return http.Response(
          jsonEncode({
            'result': 'success',
            'base_code': 'EUR',
            'time_last_update_utc': 'Sat, 03 Oct 2026 00:02:32 +0000',
            'rates': {'TND': 3.364571},
          }),
          200,
        );
      }),
    );
    final provider = SalaryCurrencyProvider(
      prefs,
      service: service,
      autoRefresh: false,
    );
    await provider.refresh();
    final loc = lookupAppLocalizations(const Locale('en'));
    final converted = provider.formatSalary(
      '40k – 65k € / year',
      'TN',
      loc,
      localeCode: 'en',
    );
    expect(converted, contains('DT'));
    expect(converted, contains('134,583'));
    expect(converted, contains('218,697'));
    expect(provider.hasLocalCurrency('TN'), isTrue);
    expect(provider.hasLocalCurrency('FR'), isFalse);

    final saved = prefs.getString('salary_exchange_rates_v1');
    expect(saved, isNotNull);
    expect(
      ExchangeRates.fromJson(jsonDecode(saved!) as Map<String, dynamic>)
          .rates['TND'],
      3.364571,
    );
  });

  test('country is persisted in profile JSON and copyWith can clear it', () {
    final profile = UserProfile(
      name: 'Sara',
      email: 'sara@example.com',
      countryCode: 'TN',
      createdAt: DateTime(2026),
    );
    final restored = UserProfile.fromJson(profile.toJson());
    expect(restored.countryCode, 'TN');
    expect(profile.copyWith(clearCountry: true).countryCode, isNull);
  });
}
