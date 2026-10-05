import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF14A38B);
  static const primaryDark = Color(0xFF0B6E5F);
  static const expense = Color(0xFFE5533D);
  static const warning = Color(0xFFF59E0B);
  static const background = Color(0xFFF5F8F7);
  static const textDark = Color(0xFF1B2B34);
  static const textMuted = Color(0xFF6B7C85);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.background,
      );
}