import 'package:ai_setu/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/core/constants/colors.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.transparent,
        labelStyle: TextStyle(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
