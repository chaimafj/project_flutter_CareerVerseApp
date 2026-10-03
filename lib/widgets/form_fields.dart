import 'package:flutter/material.dart';

import 'career_ui.dart';

InputDecoration careerInputDecoration({
  required String label,
  String? hint,
  IconData? icon,
  Widget? suffix,
}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: icon == null
        ? null
        : Icon(icon, color: const Color(0xFF526B99), size: 20),
    suffixIcon: suffix,
    filled: true,
    fillColor: Colors.white,
    labelStyle: const TextStyle(color: mutedInk, fontSize: 13),
    hintStyle: const TextStyle(color: Color(0xFFAAB6CB), fontSize: 12),
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: Color(0xFFDDE7F8), width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: blue, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
    ),
  );
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFE5484D),
        behavior: SnackBarBehavior.floating,
      ),
    );
}

void showInfo(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
}
