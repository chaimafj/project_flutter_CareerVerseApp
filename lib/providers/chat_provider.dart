import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../models/chat_message.dart';
import '../services/career_assistant.dart';
import '../services/chat_service.dart';
import 'app_state.dart';

/// Conversation with the career assistant, kept on the device per user.
///
/// Questions go to Gemini when a key is configured; otherwise (or when the
/// request fails) the offline [LocalAssistant] answers.
class ChatProvider extends ChangeNotifier {
  ChatProvider(this._prefs, {this.service = const UnavailableChatService()});

  static const maxStored = 60;

  final SharedPreferences _prefs;
  final ChatService service;
  String? _owner;
  List<ChatMessage> _messages = [];
  bool _typing = false;

  bool get usesAi => service.isConfigured;
  bool get isTyping => _typing;
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  String _key(String owner) => 'chat_${owner.toLowerCase()}';

  /// Loads the conversation of [owner] (the user email).
  void open(String owner) {
    if (_owner == owner) return;
    _owner = owner;
    final raw = _prefs.getString(_key(owner));
    _messages = [];
    if (raw != null) {
      try {
        _messages = [
          for (final item in jsonDecode(raw) as List)
            ChatMessage.fromJson(Map<String, dynamic>.from(item as Map)),
        ];
      } on FormatException {
        _messages = [];
      }
    }
    _typing = false;
  }

  Future<void> _save() async {
    final owner = _owner;
    if (owner == null) return;
    final kept = _messages.length > maxStored
        ? _messages.sublist(_messages.length - maxStored)
        : _messages;
    await _prefs.setString(
      _key(owner),
      jsonEncode([for (final message in kept) message.toJson()]),
    );
  }

  Future<void> send(
    String text, {
    required AppState state,
    required AppLocalizations loc,
  }) async {
    final question = text.trim();
    if (question.isEmpty || _typing || !state.isLoggedIn) return;
    open(state.profile.email);
    _messages.add(
      ChatMessage(
        role: ChatRole.user,
        text: question,
        createdAt: DateTime.now(),
      ),
    );
    _typing = true;
    notifyListeners();
    await _save();

    final assistant = LocalAssistant(state, loc);
    ChatMessage answer;
    if (service.isConfigured) {
      try {
        final reply = await service.reply(
          systemPrompt: assistant.systemPrompt(loc.localeName),
          history: _history(),
        );
        answer = ChatMessage(
          role: ChatRole.assistant,
          text: _plain(reply),
          createdAt: DateTime.now(),
          fromAi: true,
          actions: assistant.actionsFor(reply),
        );
      } on ChatException catch (e) {
        debugPrint('Gemini failed, offline answer: $e');
        answer = _local(assistant, question, fallback: true);
      }
    } else {
      answer = _local(assistant, question);
    }
    _messages.add(answer);
    _typing = false;
    notifyListeners();
    await _save();
  }

  ChatMessage _local(
    LocalAssistant assistant,
    String question, {
    bool fallback = false,
  }) {
    final local = assistant.answer(question);
    return ChatMessage(
      role: ChatRole.assistant,
      text: local.text,
      createdAt: DateTime.now(),
      fallback: fallback,
      actions: local.actions,
    );
  }

  /// Gemini expects the conversation to start with a user turn.
  List<ChatMessage> _history() {
    final start = _messages.indexWhere((message) => message.isUser);
    return start < 0 ? const [] : _messages.sublist(start);
  }

  /// Removes the Markdown that Gemini may still produce.
  static String _plain(String text) => text
      .replaceAllMapped(RegExp(r'\*\*(.+?)\*\*'), (m) => m[1]!)
      .replaceAllMapped(RegExp(r'^#{1,6}\s*', multiLine: true), (_) => '')
      .replaceAllMapped(RegExp(r'^\s*[*•·]\s+', multiLine: true), (_) => '- ')
      .trim();

  Future<void> clear() async {
    _messages = [];
    notifyListeners();
    await _save();
  }
}
