import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_localizations.dart';
import '../widgets/form_fields.dart';

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
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
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
                    label: Text(code.toUpperCase()),
                    selected: localeProvider.locale.languageCode == code,
                    onSelected: (_) => localeProvider.setLocale(Locale(code)),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none),
            title: Text(loc.notifications),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/notifications'),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Edit profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/edit-profile'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restart_alt, color: Colors.orange),
            title: const Text('Reset my progress'),
            subtitle: const Text('Delete all lab results and history'),
            onTap: () async {
              final state = context.read<AppState>();
              if (!await _confirm(
                context,
                'Reset progress?',
                'All your lab results and recommendations will be deleted.',
              )) {
                return;
              }
              await state.resetProgress();
              if (context.mounted) showInfo(context, 'Progress reset');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(loc.about),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'CareerVerse',
              applicationVersion: '1.0.0',
              applicationLegalese:
                  'Discover careers through hands-on simulations.',
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
