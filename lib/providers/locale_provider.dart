import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  LocaleProvider(this._prefs) {
    final saved = _prefs.getString('locale') ?? 'en';
    _locale = _supportedLocales.contains(saved)
        ? Locale(saved)
        : const Locale('en');
  }

  final SharedPreferences _prefs;
  Locale _locale = const Locale('en');

  static const List<String> _supportedLocales = ['fr', 'en', 'ar'];

  Locale get locale => _locale;

  List<String> get supportedLocales => _supportedLocales;

  Future<void> setLocale(Locale value) async {
    if (!_supportedLocales.contains(value.languageCode)) {
      return;
    }
    _locale = value;
    await _prefs.setString('locale', value.languageCode);
    notifyListeners();
  }
}
