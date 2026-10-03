import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/esco_occupation.dart';

class EscoApiException implements Exception {
  const EscoApiException(this.message);

  final String message;

  @override
  String toString() => 'EscoApiException: $message';
}

/// Search and retrieve multilingual occupations from the European
/// Commission's ESCO web service.
class EscoCareerService {
  EscoCareerService({this._client});

  static const _baseUrl = 'ec.europa.eu';
  static const _timeout = Duration(seconds: 12);
  final http.Client? _client;

  Future<EscoOccupationPage> search({
    required String query,
    required String languageCode,
    int limit = 10,
    int offset = 0,
  }) async {
    final uri = Uri.https(_baseUrl, '/esco/api/search', {
      'language': languageCode,
      'type': 'occupation',
      'text': query,
      'limit': '$limit',
      'offset': '$offset',
    });
    final response = await _get(uri);
    final embedded = response['_embedded'];
    if (embedded is! Map || embedded['results'] is! List) {
      throw const EscoApiException('ESCO returned an invalid search response.');
    }
    try {
      final occupations = [
        for (final result in embedded['results'] as List)
          if (result is Map)
            EscoOccupation.fromSearch(
              Map<String, dynamic>.from(result),
              languageCode: languageCode,
            ),
      ];
      return EscoOccupationPage(
        occupations: occupations,
        total: response['total'] is int ? response['total'] as int : occupations.length,
        offset: response['offset'] is int ? response['offset'] as int : offset,
        limit: response['limit'] is int ? response['limit'] as int : limit,
      );
    } on FormatException catch (error) {
      throw EscoApiException('ESCO returned invalid occupation data: $error');
    }
  }

  Future<EscoOccupation> details(EscoOccupation occupation) async {
    final uri = Uri.https(_baseUrl, '/esco/api/resource/occupation', {
      'uri': occupation.uri,
      'language': occupation.languageCode,
    });
    final response = await _get(uri);
    try {
      return EscoOccupation.withDetails(occupation, response);
    } on FormatException catch (error) {
      throw EscoApiException('ESCO returned invalid occupation data: $error');
    }
  }

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final http.Response response;
    try {
      final client = _client;
      response = await (client == null
              ? http.get(uri, headers: const {'Accept': 'application/json'})
              : client.get(uri, headers: const {'Accept': 'application/json'}))
          .timeout(_timeout);
    } on TimeoutException {
      throw const EscoApiException('The ESCO request timed out.');
    } on http.ClientException catch (error) {
      throw EscoApiException('Could not reach ESCO: $error');
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw EscoApiException('ESCO returned HTTP ${response.statusCode}.');
    }
    final dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException catch (error) {
      throw EscoApiException('ESCO returned invalid JSON: $error');
    }
    if (decoded is! Map) {
      throw const EscoApiException('ESCO returned an invalid JSON response.');
    }
    return Map<String, dynamic>.from(decoded);
  }
}
