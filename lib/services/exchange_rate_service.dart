import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ExchangeRateException implements Exception {
  const ExchangeRateException(this.message);

  final String message;

  @override
  String toString() => 'ExchangeRateException: $message';
}

class ExchangeRates {
  const ExchangeRates({
    required this.base,
    required this.rates,
    required this.updatedAt,
  });

  final String base;
  final Map<String, double> rates;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
    'base': base,
    'rates': rates,
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory ExchangeRates.fromJson(Map<String, dynamic> json) {
    final rawRates = json['rates'];
    final updatedAt = DateTime.tryParse(json['updatedAt'] as String? ?? '');
    if (json['base'] != 'EUR' || rawRates is! Map || updatedAt == null) {
      throw const FormatException('Invalid saved exchange rates.');
    }
    return ExchangeRates(
      base: 'EUR',
      rates: {
        for (final entry in rawRates.entries)
          if (entry.value is num)
            entry.key.toString(): (entry.value as num).toDouble(),
      },
      updatedAt: updatedAt,
    );
  }
}

class ExchangeRateService {
  ExchangeRateService({this._client});

  final http.Client? _client;

  Future<ExchangeRates> fetchEuroRates() async {
    final uri = Uri.https('open.er-api.com', '/v6/latest/EUR');
    final http.Response response;
    try {
      final client = _client;
      response = await (client == null ? http.get(uri) : client.get(uri))
          .timeout(const Duration(seconds: 12));
    } on TimeoutException {
      throw const ExchangeRateException('Exchange-rate request timed out.');
    } on http.ClientException catch (error) {
      throw ExchangeRateException(
        'Could not reach exchange-rate service: $error',
      );
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ExchangeRateException(
        'Exchange-rate service returned HTTP ${response.statusCode}.',
      );
    }

    final dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException catch (error) {
      throw ExchangeRateException('Invalid exchange-rate response: $error');
    }
    if (decoded is! Map ||
        decoded['result'] != 'success' ||
        decoded['base_code'] != 'EUR' ||
        decoded['rates'] is! Map) {
      throw const ExchangeRateException(
        'Exchange-rate service returned invalid data.',
      );
    }
    final rawRates = decoded['rates'] as Map;
    DateTime updatedAt;
    try {
      final rawUpdatedAt = decoded['time_last_update_utc'] as String;
      final httpDate = rawUpdatedAt.replaceFirst(RegExp(r'\s+\+0000$'), ' GMT');
      updatedAt = HttpDate.parse(httpDate).toUtc();
    } on HttpException {
      updatedAt = DateTime.now().toUtc();
    } on TypeError {
      updatedAt = DateTime.now().toUtc();
    }
    return ExchangeRates(
      base: 'EUR',
      rates: {
        for (final entry in rawRates.entries)
          if (entry.value is num)
            entry.key.toString(): (entry.value as num).toDouble(),
      },
      updatedAt: updatedAt,
    );
  }
}
