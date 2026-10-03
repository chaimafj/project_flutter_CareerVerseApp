/// A button shown under an assistant answer that opens a screen.
class ChatAction {
  const ChatAction({required this.label, required this.route, this.argument});

  final String label;
  final String route;
  final String? argument;

  Map<String, dynamic> toJson() => {
    'label': label,
    'route': route,
    'argument': argument,
  };

  factory ChatAction.fromJson(Map<String, dynamic> json) => ChatAction(
    label: json['label'] as String,
    route: json['route'] as String,
    argument: json['argument'] as String?,
  );
}

enum ChatRole { user, assistant }

class ChatMessage {
  const ChatMessage({
    required this.role,
    required this.text,
    required this.createdAt,
    this.fromAi = false,
    this.fallback = false,
    this.actions = const [],
  });

  final ChatRole role;
  final String text;
  final DateTime createdAt;

  /// Answer written by Gemini (otherwise by the offline assistant).
  final bool fromAi;

  /// Gemini was configured but failed, so the offline assistant answered.
  final bool fallback;
  final List<ChatAction> actions;

  bool get isUser => role == ChatRole.user;

  Map<String, dynamic> toJson() => {
    'role': role.name,
    'text': text,
    'createdAt': createdAt.toIso8601String(),
    'fromAi': fromAi,
    'fallback': fallback,
    'actions': [for (final action in actions) action.toJson()],
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    role: json['role'] == 'user' ? ChatRole.user : ChatRole.assistant,
    text: json['text'] as String? ?? '',
    createdAt:
        DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    fromAi: json['fromAi'] as bool? ?? false,
    fallback: json['fallback'] as bool? ?? false,
    actions: [
      for (final action in json['actions'] as List? ?? const [])
        ChatAction.fromJson(Map<String, dynamic>.from(action as Map)),
    ],
  );
}
