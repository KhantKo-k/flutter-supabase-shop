import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF004CFF);

  static const Color secondary = Color(0xFFF2F5FE);

  // Text colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);
  
  static const Color background = Color(0xFFF9FAFB);

  static const Color success = Color(0xFF10B981); // Green
  static const Color error = Color(0xFFEF4444); // Red
  static const Color warning = Color(0xFFF59E0B); // Yellow
  static const Color info = Color(0xFF3B82F6);
}

extension ColorExtensions on BuildContext {
  // Now these will change automatically when the theme flips!
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get errorColor => Theme.of(this).colorScheme.error;
}