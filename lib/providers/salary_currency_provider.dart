import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/salary_countries.dart';
import '../l10n/app_localizations.dart';
import '../services/exchange_rate_service.dart';

class SalaryCurrencyProvider extends ChangeNotifier {
  SalaryCurrencyProvider(
    this._prefs, {
    ExchangeRateService? service,
    bool autoRefresh = true,
  }) : _service = service ?? ExchangeRateService() {
    if (autoRefresh) unawaited(_initialize());
  }

  static const _cacheKey = 'salary_exchange_rates_v1';
  static const _refreshAfter = Duration(hours: 24);

  final SharedPreferences _prefs;
  final ExchangeRateService _service;
  ExchangeRates? _exchangeRates;
  ExchangeRateException? _error;
  bool _isRefreshing = false;

  bool get isRefreshing => _isRefreshing;
  ExchangeRateException? get error => _error;
  DateTime? get updatedAt => _exchangeRates?.updatedAt;

  Future<void> _initialize() async {
    final cached = _prefs.getString(_cacheKey);
    if (cached != null) {
      try {
        _exchangeRates = ExchangeRates.fromJson(
          jsonDecode(cached) as Map<String, dynamic>,
        );
      } on FormatException catch (error) {
        debugPrint('Ignoring invalid cached exchange rates: $error');
      } on TypeError catch (error) {
        debugPrint('Ignoring invalid cached exchange rates: $error');
      }
    }
    notifyListeners();
    final cachedAt = _exchangeRates?.updatedAt;
    if (cachedAt == null ||
        DateTime.now().toUtc().difference(cachedAt) >= _refreshAfter) {
      await refresh();
    }
  }

  Future<void> refresh() async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    _error = null;
    notifyListeners();
    try {
      final rates = await _service.fetchEuroRates();
      _exchangeRates = rates;
      await _prefs.setString(_cacheKey, jsonEncode(rates.toJson()));
    } on ExchangeRateException catch (error) {
      _error = error;
      debugPrint('Could not refresh salary exchange rates: $error');
    } finally {
      _isRefreshing = false;
      notifyListeners();
    }
  }

  String formatSalary(
    String euroSalary,
    String? countryCode,
    AppLocalizations loc, {
    required String localeCode,
  }) {
    final country = salaryCountryByCode(countryCode);
    if (country == null || country.currencyCode == 'EUR') return euroSalary;
    final rate = _exchangeRates?.rates[country.currencyCode];
    if (rate == null) {
      return _isRefreshing
          ? loc.exchangeRateLoading
          : loc.exchangeRateUnavailable;
    }

    final match = RegExp(
      r'(\d+(?:\.\d+)?)k\s*[–-]\s*(\d+(?:\.\d+)?)k',
      caseSensitive: false,
    ).firstMatch(euroSalary);
    if (match == null) return loc.exchangeRateUnavailable;
    final low = double.parse(match.group(1)!) * 1000 * rate;
    final high = double.parse(match.group(2)!) * 1000 * rate;
    final formatter = NumberFormat.decimalPattern(localeCode);
    return loc.salaryRange(
      formatter.format(low.round()),
      formatter.format(high.round()),
      country.currencySymbol,
      loc.salaryPerYear,
    );
  }

  String salaryLabel(String? countryCode, AppLocalizations loc) {
    final country = salaryCountryByCode(countryCode);
    if (country == null) return loc.salaryFrance;
    return country.currencyCode == 'EUR'
        ? loc.salaryFrance
        : loc.salaryConverted(country.name(loc));
  }

  bool hasLocalCurrency(String? countryCode) {
    final country = salaryCountryByCode(countryCode);
    return country != null && country.currencyCode != 'EUR';
  }
}
