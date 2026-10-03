import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('fr'),
    Locale('en'),
    Locale('ar'),
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  final Locale locale;

  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String, Map<String, String>> _strings = {
    'fr': {
      'appName': 'CareerVerse',
      'welcomeBack': 'Bon retour',
      'signIn': 'Connexion',
      'createAccount': 'Créer un compte',
      'email': 'Email',
      'password': 'Mot de passe',
      'rememberMe': 'Se souvenir de moi',
      'continueWithGoogle': 'Continuer avec Google',
      'home': 'Accueil',
      'explore': 'Explorer',
      'simulations': 'Simulations',
      'recommendations': 'Recommandations',
      'profile': 'Profil',
      'settings': 'Paramètres',
      'notifications': 'Notifications',
      'popularCareers': 'Métiers populaires',
      'aiRecommendations': 'Recommandations IA',
      'startSimulation': 'Démarrer la simulation',
      'emptyState': 'Aucune donnée pour le moment.',
      'theme': 'Thème',
      'language': 'Langue',
      'logout': 'Déconnexion',
      'results': 'Résultats',
      'continueBtn': 'Continuer',
      'score': 'Score',
      'recommendedCareer': 'Métier recommandé',
      'yourProfile': 'Votre profil',
      'profileInfo': 'Informations profil',
      'interests': 'Centres d’intérêt',
      'searchCareers': 'Rechercher un métier',
      'categories': 'Catégories',
      'advancedTools': 'Outils avancés',
      'premium': 'Premium',
      'about': 'À propos',
      'darkMode': 'Mode sombre',
      'lightMode': 'Mode clair',
    },
    'en': {
      'appName': 'CareerVerse',
      'welcomeBack': 'Welcome back',
      'signIn': 'Sign in',
      'createAccount': 'Create account',
      'email': 'Email',
      'password': 'Password',
      'rememberMe': 'Remember me',
      'continueWithGoogle': 'Continue with Google',
      'home': 'Home',
      'explore': 'Explore',
      'simulations': 'Simulations',
      'recommendations': 'Recommendations',
      'profile': 'Profile',
      'settings': 'Settings',
      'notifications': 'Notifications',
      'popularCareers': 'Popular careers',
      'aiRecommendations': 'AI recommendations',
      'startSimulation': 'Start simulation',
      'emptyState': 'No data available yet.',
      'theme': 'Theme',
      'language': 'Language',
      'logout': 'Log out',
      'results': 'Results',
      'continueBtn': 'Continue',
      'score': 'Score',
      'recommendedCareer': 'Recommended career',
      'yourProfile': 'Your profile',
      'profileInfo': 'Profile information',
      'interests': 'Interests',
      'searchCareers': 'Search a career',
      'categories': 'Categories',
      'advancedTools': 'Advanced tools',
      'premium': 'Premium',
      'about': 'About',
      'darkMode': 'Dark mode',
      'lightMode': 'Light mode',
    },
    'ar': {
      'appName': 'CareerVerse',
      'welcomeBack': 'مرحبًا بعودتك',
      'signIn': 'تسجيل الدخول',
      'createAccount': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'rememberMe': 'تذكرني',
      'continueWithGoogle': 'المتابعة مع Google',
      'home': 'الرئيسية',
      'explore': 'استكشاف',
      'simulations': 'المحاكيات',
      'recommendations': 'التوصيات',
      'profile': 'الملف الشخصي',
      'settings': 'الإعدادات',
      'notifications': 'الإشعارات',
      'popularCareers': 'المهن الشائعة',
      'aiRecommendations': 'توصيات الذكاء الاصطناعي',
      'startSimulation': 'ابدأ المحاكاة',
      'emptyState': 'لا توجد بيانات حتى الآن.',
      'theme': 'المظهر',
      'language': 'اللغة',
      'logout': 'تسجيل الخروج',
      'results': 'النتائج',
      'continueBtn': 'متابعة',
      'score': 'النتيجة',
      'recommendedCareer': 'المهنة الموصى بها',
      'yourProfile': 'ملفك الشخصي',
      'profileInfo': 'معلومات الملف',
      'interests': 'الاهتمامات',
      'searchCareers': 'ابحث عن مهنة',
      'categories': 'الفئات',
      'advancedTools': 'أدوات متقدمة',
      'premium': 'بريميوم',
      'about': 'حول',
      'darkMode': 'الوضع الداكن',
      'lightMode': 'الوضع الفاتح',
    },
  };

  String get appName => _value('appName');
  String get welcomeBack => _value('welcomeBack');
  String get signIn => _value('signIn');
  String get createAccount => _value('createAccount');
  String get email => _value('email');
  String get password => _value('password');
  String get rememberMe => _value('rememberMe');
  String get continueWithGoogle => _value('continueWithGoogle');
  String get home => _value('home');
  String get explore => _value('explore');
  String get simulations => _value('simulations');
  String get recommendations => _value('recommendations');
  String get profile => _value('profile');
  String get settings => _value('settings');
  String get notifications => _value('notifications');
  String get popularCareers => _value('popularCareers');
  String get aiRecommendations => _value('aiRecommendations');
  String get startSimulation => _value('startSimulation');
  String get emptyState => _value('emptyState');
  String get theme => _value('theme');
  String get language => _value('language');
  String get logout => _value('logout');
  String get results => _value('results');
  String get continueBtn => _value('continueBtn');
  String get score => _value('score');
  String get recommendedCareer => _value('recommendedCareer');
  String get yourProfile => _value('yourProfile');
  String get profileInfo => _value('profileInfo');
  String get interests => _value('interests');
  String get searchCareers => _value('searchCareers');
  String get categories => _value('categories');
  String get advancedTools => _value('advancedTools');
  String get premium => _value('premium');
  String get about => _value('about');
  String get darkMode => _value('darkMode');
  String get lightMode => _value('lightMode');

  String _value(String key) =>
      _strings[locale.languageCode]?[key] ?? _strings['en']?[key] ?? key;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any(
    (supported) => supported.languageCode == locale.languageCode,
  );

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
