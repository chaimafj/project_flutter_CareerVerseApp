import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

class AppValidators {
  static FormFieldValidator<String> name(AppLocalizations l) => (value) {
    if (value == null || value.trim().isEmpty) return l.validationRequired;
    if (value.trim().length < 2) return l.validationNameLength;
    return null;
  };

  static FormFieldValidator<String> email(AppLocalizations l) => (value) {
    if (value == null || value.trim().isEmpty) return l.validationRequired;
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return l.validationEmail;
    return null;
  };

  static FormFieldValidator<String> password(AppLocalizations l) => (value) {
    if (value == null || value.trim().isEmpty) return l.validationRequired;
    if (value.length < 6) return l.validationPasswordLength;
    return null;
  };
}
