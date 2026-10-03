import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/catalog.dart';
import 'l10n/app_localizations.dart';
import 'providers/app_state.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/career_lab_detail_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learning_path_screen.dart';
import 'screens/login_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/recommendations_screen.dart';
import 'screens/register_screen.dart';
import 'screens/results_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/simulation_screen.dart';
import 'screens/welcome_screen.dart';
import 'utils/app_theme.dart';

class CareerVerseApp extends StatelessWidget {
  const CareerVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loggedIn = context.read<AppState>().isLoggedIn;
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        // Career content (titles, labs, questions) follows the app language.
        setCatalogLanguage(localeProvider.locale.languageCode);
        return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context).appName,
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          locale: localeProvider.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          initialRoute: loggedIn ? '/home' : '/welcome',
          routes: {
            '/welcome': (context) => const WelcomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreen(),
            '/career': (context) => const CareerLabDetailScreen(),
            '/simulation': (context) => const SimulationScreen(),
            '/results': (context) => const ResultsScreen(),
            '/learning-path': (context) => const LearningPathScreen(),
            '/recommendations': (context) => const RecommendationsScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/notifications': (context) => const NotificationsScreen(),
            '/edit-profile': (context) => const EditProfileScreen(),
          },
        );
      },
    );
  }
}
