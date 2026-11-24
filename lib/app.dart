import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/catalog.dart';
import 'l10n/generated/app_localizations.dart';
import 'features/admin/admin_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/auth/welcome_screen.dart';
import 'features/learning/career_lab_detail_screen.dart';
import 'features/learning/chat_screen.dart';
import 'features/learning/course_screen.dart';
import 'features/learning/esco_career_detail_screen.dart';
import 'features/learning/home_screen.dart';
import 'features/learning/learning_path_screen.dart';
import 'features/learning/notifications_screen.dart';
import 'features/learning/premium_screen.dart';
import 'features/learning/recommendations_screen.dart';
import 'features/learning/results_screen.dart';
import 'features/learning/settings_screen.dart';
import 'features/learning/simulation_screen.dart';
import 'features/profile/edit_profile_screen.dart';
import 'providers/app_state.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'utils/app_theme.dart';

/// Used to open screens from notification taps.
final appNavigatorKey = GlobalKey<NavigatorState>();

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
          navigatorKey: appNavigatorKey,
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
            '/esco-career': (context) => const EscoCareerDetailScreen(),
            '/simulation': (context) => const SimulationScreen(),
            '/results': (context) => const ResultsScreen(),
            '/learning-path': (context) => const LearningPathScreen(),
            '/course': (context) => const CourseScreen(),
            '/recommendations': (context) => const RecommendationsScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/notifications': (context) => const NotificationsScreen(),
            '/edit-profile': (context) => const EditProfileScreen(),
            '/premium': (context) => const PremiumScreen(),
            '/chat': (context) => const ChatScreen(),
            '/admin': (context) => const AdminScreen(),
          },
        );
      },
    );
  }
}
