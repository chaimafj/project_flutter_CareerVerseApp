import 'package:flutter/widgets.dart';

import '../data/catalog.dart';
import '../models/app_notification.dart';
import '../providers/app_state.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension AppLocalizationsX on AppLocalizations {
  String authError(AuthError error) => switch (error) {
    AuthError.emailTaken => errorEmailTaken,
    AuthError.noAccount => errorNoAccount,
    AuthError.wrongPassword => errorWrongPassword,
  };

  String notificationTitle(AppNotification n) => switch (n.kind) {
    NotificationKind.welcome => notifWelcomeTitle,
    NotificationKind.labResult => notifResultTitle,
    NotificationKind.other => n.title,
  };

  String notificationBody(AppNotification n) {
    switch (n.kind) {
      case NotificationKind.welcome:
        return notifWelcomeBody;
      case NotificationKind.labResult:
        final lab = findLab(n.data['labId'] as String? ?? '')?.$2;
        final top = careerById(n.data['topCareerId'] as String? ?? '');
        final score = n.data['score'] as int? ?? 0;
        final body = notifResultBody(
          lab?.title ?? '',
          score,
          top?.title ?? '',
          n.data['topScore'] as int? ?? 0,
        );
        return n.data['improved'] == true ? '$body $notifNewBest' : body;
      case NotificationKind.other:
        return n.body;
    }
  }

  /// Human-readable explanation of a career match.
  String matchReason(CareerMatch match) {
    final parts = <String>[];
    final performance = match.performance;
    if (performance != null) {
      parts.add(
        reasonScored(performance, match.labsDone, match.career.labs.length),
      );
      final skill = match.strongestSkill;
      if (skill != null) parts.add(reasonStrongest(tc(skill)));
    } else {
      parts.add(reasonNotTested);
    }
    if (match.sharedInterests.isNotEmpty) {
      parts.add(reasonInterests(match.sharedInterests.map(tc).join(', ')));
    }
    return parts.join(' ');
  }

  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return timeJustNow;
    if (diff.inHours < 1) return timeMinutesAgo(diff.inMinutes);
    if (diff.inDays < 1) return timeHoursAgo(diff.inHours);
    if (diff.inDays < 7) return timeDaysAgo(diff.inDays);
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
