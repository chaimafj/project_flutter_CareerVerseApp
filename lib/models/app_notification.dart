enum NotificationKind { welcome, labResult, premium, other }

/// In-app notification. The text is rendered in the current language from
/// [kind] and [data]; [title]/[body] are only used for [NotificationKind.other].
class AppNotification {
  const AppNotification({
    required this.id,
    required this.kind,
    required this.createdAt,
    this.data = const {},
    this.title = '',
    this.body = '',
    this.read = false,
    this.resultId,
  });

  final String id;
  final NotificationKind kind;
  final Map<String, dynamic> data;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool read;

  /// When set, tapping the notification opens the matching lab result.
  final String? resultId;

  AppNotification markRead() => AppNotification(
    id: id,
    kind: kind,
    data: data,
    title: title,
    body: body,
    createdAt: createdAt,
    read: true,
    resultId: resultId,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'kind': kind.name,
    'data': data,
    'title': title,
    'body': body,
    'createdAt': createdAt.toIso8601String(),
    'read': read,
    'resultId': resultId,
  };

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        id: json['id'] as String,
        kind: NotificationKind.values.firstWhere(
          (kind) => kind.name == json['kind'],
          orElse: () => NotificationKind.other,
        ),
        data: Map<String, dynamic>.from(json['data'] as Map? ?? const {}),
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        createdAt: DateTime.parse(json['createdAt'] as String),
        read: json['read'] as bool? ?? false,
        resultId: json['resultId'] as String?,
      );
}
