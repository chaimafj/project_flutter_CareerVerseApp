import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../models/chat_message.dart';
import '../providers/app_state.dart';
import '../providers/chat_provider.dart';
import '../widgets/career_ui.dart';

/// Chat with the career assistant (Gemini, or offline answers).
/// An optional question can be passed as the route argument.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _input = TextEditingController();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final state = context.read<AppState>();
    if (!state.isLoggedIn) return;
    context.read<ChatProvider>().open(state.profile.email);
    final question = ModalRoute.of(context)?.settings.arguments;
    if (question is String && question.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _send(question));
    }
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  Future<void> _send([String? text]) async {
    final question = text ?? _input.text;
    if (question.trim().isEmpty) return;
    _input.clear();
    await context.read<ChatProvider>().send(
      question,
      state: context.read<AppState>(),
      loc: context.l10n,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatProvider>();
    final state = context.watch<AppState>();
    final loc = context.l10n;
    final messages = chat.messages;
    final suggestions = [
      loc.chatSuggestRecommend,
      loc.chatSuggestNext,
      loc.chatSuggestProgress,
      loc.chatSuggestCareer,
    ];

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFEDE8FF),
              child: Icon(Icons.smart_toy_outlined, color: purple, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.chatTitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ink,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    chat.usesAi ? loc.chatModeAi : loc.chatModeLocal,
                    key: const Key('chat-mode'),
                    style: const TextStyle(color: mutedInk, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          if (messages.isNotEmpty)
            IconButton(
              key: const Key('chat-clear'),
              tooltip: loc.chatClear,
              onPressed: chat.isTyping ? null : chat.clear,
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              key: const Key('chat-list'),
              reverse: true,
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 8),
              children: [
                if (chat.isTyping) _TypingBubble(label: loc.chatThinking),
                for (final message in messages.reversed)
                  _MessageBubble(message: message),
                _MessageBubble(
                  message: ChatMessage(
                    role: ChatRole.assistant,
                    text: loc.chatWelcome(
                      state.isLoggedIn ? state.profile.firstName : '',
                    ),
                    createdAt: DateTime.now(),
                  ),
                ),
              ],
            ),
          ),
          if (messages.isEmpty)
            SizedBox(
              height: 48,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    for (final (index, suggestion) in suggestions.indexed)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: ActionChip(
                          key: Key('chat-suggestion-$index'),
                          label: Text(suggestion),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFFDCD3FF)),
                          labelStyle: const TextStyle(
                            color: purple,
                            fontWeight: FontWeight.w600,
                          ),
                          onPressed: chat.isTyping
                              ? null
                              : () => _send(suggestion),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          SafeArea(
            top: false,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('chat-input'),
                      controller: _input,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: loc.chatHint,
                        filled: true,
                        fillColor: canvas,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton.filled(
                    key: const Key('chat-send'),
                    tooltip: loc.chatSend,
                    style: IconButton.styleFrom(backgroundColor: purple),
                    onPressed: chat.isTyping ? null : _send,
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    final user = message.isUser;
    const radius = Radius.circular(18);
    return Align(
      alignment: user
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.82,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: user
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: user
                      ? const LinearGradient(colors: [purple, blue])
                      : null,
                  color: user ? null : Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: radius,
                    topEnd: radius,
                    bottomStart: user ? radius : const Radius.circular(4),
                    bottomEnd: user ? const Radius.circular(4) : radius,
                  ),
                  boxShadow: user
                      ? null
                      : const [
                          BoxShadow(color: Color(0x0F122650), blurRadius: 8),
                        ],
                ),
                child: SelectableText(
                  message.text,
                  textDirection: _directionOf(message.text),
                  style: TextStyle(
                    color: user ? Colors.white : ink,
                    fontSize: 14.5,
                    height: 1.4,
                  ),
                ),
              ),
              if (message.fromAi || message.fallback)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 6, right: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        message.fromAi ? Icons.auto_awesome : Icons.wifi_off,
                        size: 12,
                        color: mutedInk,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          message.fromAi
                              ? loc.chatModeAi
                              : loc.chatFallbackNotice,
                          style: const TextStyle(color: mutedInk, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              if (message.actions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final action in message.actions)
                        ActionChip(
                          avatar: const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: purple,
                          ),
                          label: Text(action.label),
                          backgroundColor: const Color(0xFFF3F0FF),
                          side: BorderSide.none,
                          labelStyle: const TextStyle(
                            color: purple,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                          onPressed: () => Navigator.of(
                            context,
                          ).pushNamed(action.route, arguments: action.argument),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        key: const Key('chat-typing'),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2, color: purple),
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: mutedInk)),
          ],
        ),
      ),
    );
  }
}

final _rtlChar = RegExp('[\u0590-\u08FF]');
final _ltrChar = RegExp('[A-Za-z\u00C0-\u024F]');

/// Direction of a message from its first strong character, so English
/// answers stay readable in the Arabic UI (and vice versa).
TextDirection _directionOf(String text) {
  final rtl = text.indexOf(_rtlChar);
  final ltr = text.indexOf(_ltrChar);
  if (rtl < 0) return TextDirection.ltr;
  if (ltr < 0 || rtl < ltr) return TextDirection.rtl;
  return TextDirection.ltr;
}
