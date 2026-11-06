import 'package:flutter/material.dart';

import '../models/post.dart';

class AppColors {
  static const primary = Color(0xFF2859E8);
  static const background = Color(0xFFF5F7FB);
  static const card = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF172033);
  static const textSecondary = Color(0xFF788397);
  static const border = Color(0xFFE8ECF2);
  static const searchFill = Color(0xFFEDF0F6);
  static const pillInactive = Color(0xFFE9EDF4);
  static const danger = Color(0xFFD64545);
}

class CategoryStyle {
  final String label;
  final IconData icon;
  final Color color;
  final Color background;

  const CategoryStyle({
    required this.label,
    required this.icon,
    required this.color,
    required this.background,
  });

  static CategoryStyle of(PostCategory category) {
    return switch (category) {
      PostCategory.akademik => const CategoryStyle(
          label: 'Akademik',
          icon: Icons.school_outlined,
          color: Color(0xFF2859E8),
          background: Color(0xFFE8EEFD),
        ),
      PostCategory.event => const CategoryStyle(
          label: 'Event',
          icon: Icons.campaign_outlined,
          color: Color(0xFFD9730D),
          background: Color(0xFFFFF1E3),
        ),
      PostCategory.umum => const CategoryStyle(
          label: 'Umum',
          icon: Icons.info_outline_rounded,
          color: Color(0xFF0F8F6E),
          background: Color(0xFFE3F5EF),
        ),
    };
  }
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.background,
    );

    OutlineInputBorder outline(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        border: outline(AppColors.border),
        enabledBorder: outline(AppColors.border),
        focusedBorder: outline(AppColors.primary, 1.5),
        errorBorder: outline(AppColors.danger),
        focusedErrorBorder: outline(AppColors.danger, 1.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 50),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
    );
  }
}