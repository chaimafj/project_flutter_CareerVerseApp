import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../providers/app_state.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../services/notification_service.dart';
import '../widgets/form_fields.dart';

const _languageNames = {'fr': 'Français', 'en': 'English', 'ar': 'العربية'};

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<bool> _confirm(BuildContext context, String title, String body) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.confirm),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(loc.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile.adaptive(
            secondary: const Icon(Icons.dark_mode_outlined),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (_) => themeProvider.toggleTheme(),
            title: Text(loc.theme),
            subtitle: Text(
              themeProvider.themeMode == ThemeMode.dark
                  ? loc.darkMode
                  : loc.lightMode,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(loc.language),
            subtitle: Wrap(
              spacing: 8,
              children: [
                for (final code in ['fr', 'en', 'ar'])
                  ChoiceChip(
                    key: Key('lang-$code'),
                    label: Text(_languageNames[code]!),
                    selected: localeProvider.locale.languageCode == code,
                    onSelected: (_) => localeProvider.setLocale(Locale(code)),
                  ),
              ],
            ),
          ),
          SwitchListTile.adaptive(
            key: const Key('push-switch'),
            secondary: const Icon(Icons.notifications_active_outlined),
            value: context.watch<NotificationService>().enabled,
            onChanged: context.read<NotificationService>().setEnabled,
            title: Text(loc.pushNotifications),
            subtitle: Text(loc.pushNotificationsSubtitle),
          ),
          ListTile(
            key: const Key('premium-tile'),
            leading: const Icon(
              Icons.workspace_premium_outlined,
              color: Color(0xFFE0A100),
            ),
            title: Text(loc.premium),
            subtitle: Builder(
              builder: (context) {
                final state = context.watch<AppState>();
                return Text(
                  state.isPremium
                      ? loc.premiumActiveUntil(
                          loc.shortDate(state.premiumUntil!),
                        )
                      : loc.premiumFree,
                );
              },
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/premium'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none),
            title: Text(loc.notifications),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/notifications'),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(loc.editProfile),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/edit-profile'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restart_alt, color: Colors.orange),
            title: Text(loc.resetProgress),
            subtitle: Text(loc.resetProgressSubtitle),
            onTap: () async {
              final state = context.read<AppState>();
              if (!await _confirm(
                context,
                loc.resetProgressTitle,
                loc.resetProgressMessage,
              )) {
                return;
              }
              await state.resetProgress();
              if (context.mounted) showInfo(context, loc.progressReset);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(loc.about),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'CareerVerse',
              applicationVersion: '1.0.0',
              applicationLegalese: loc.aboutText,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(loc.logout, style: const TextStyle(color: Colors.red)),
            onTap: () async {
              final navigator = Navigator.of(context);
              await context.read<AppState>().logout();
              navigator.pushNamedAndRemoveUntil('/welcome', (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
