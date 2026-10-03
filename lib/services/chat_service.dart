import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/chat_message.dart';

class ChatException implements Exception {
  const ChatException(this.message);

  final String message;

  @override
  String toString() => 'ChatException: $message';
}

/// Remote AI model used by the assistant.
abstract class ChatService {
  bool get isConfigured;

  /// Returns the answer to the last message of [history].
  Future<String> reply({
    required String systemPrompt,
    required List<ChatMessage> history,
  });
}

class UnavailableChatService implements ChatService {
  const UnavailableChatService();

  @override
  bool get isConfigured => false;

  @override
  Future<String> reply({
    required String systemPrompt,
    required List<ChatMessage> history,
  }) async => throw const ChatException('not configured');
}

/// Google Gemini through the `generateContent` REST API.
///
/// The key is given at build time (`GEMINI_API_KEY` in the
/// `--dart-define-from-file` JSON). Without it, the app uses the offline
/// assistant only.
class GeminiChatService implements ChatService {
  GeminiChatService({
    this.apiKey = const String.fromEnvironment('GEMINI_API_KEY'),
    this.model = const String.fromEnvironment(
      'GEMINI_MODEL',
      defaultValue: 'gemini-2.5-flash',
    ),
    http.Client? client,
  }) : _client = client ?? http.Client();

  static const _api = 'https://generativelanguage.googleapis.com/v1beta';

  /// Only the most recent turns are sent to keep requests small.
  static const maxTurns = 12;

  final String apiKey;
  final String model;
  final http.Client _client;

  @override
  bool get isConfigured => apiKey.trim().isNotEmpty;

  @override
  Future<String> reply({
    required String systemPrompt,
    required List<ChatMessage> history,
  }) async {
    if (!isConfigured) throw const ChatException('not configured');
    final turns = history.length > maxTurns
        ? history.sublist(history.length - maxTurns)
        : history;
    final body = jsonEncode({
      'system_instruction': {
        'parts': [
          {'text': systemPrompt},
        ],
      },
      'contents': [
        for (final message in turns)
          {
            'role': message.isUser ? 'user' : 'model',
            'parts': [
              {'text': message.text},
            ],
          },
      ],
      'generationConfig': {'temperature': 0.6, 'maxOutputTokens': 1024},
    });
    final http.Response response;
    try {
      response = await _client
          .post(
            Uri.parse('$_api/models/$model:generateContent'),
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': apiKey,
            },
            body: body,
          )
          .timeout(const Duration(seconds: 30));
    } on SocketException {
      throw const ChatException('network');
    } on TimeoutException {
      throw const ChatException('timeout');
    } on http.ClientException {
      throw const ChatException('network');
    }
    final Object? json;
    try {
      json = jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw ChatException('invalid response (${response.statusCode})');
    }
    if (response.statusCode >= 400 || json is! Map) {
      final error = json is Map ? json['error'] : null;
      throw ChatException(
        error is Map ? '${error['message']}' : 'HTTP ${response.statusCode}',
      );
    }
    final candidates = json['candidates'];
    final content = candidates is List && candidates.isNotEmpty
        ? (candidates.first as Map)['content']
        : null;
    final parts = content is Map ? content['parts'] : null;
    final text = parts is List
        ? parts
              .whereType<Map>()
              .map((part) => part['text'])
              .whereType<String>()
              .join()
              .trim()
        : '';
    if (text.isEmpty) throw const ChatException('empty answer');
    return text;
  }
}
