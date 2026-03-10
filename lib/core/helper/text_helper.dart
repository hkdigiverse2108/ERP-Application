import 'package:flutter/material.dart';
import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/services/theme_service.dart';

class TextHelper {
  static bool get _isDark => ThemeService().isDarkMode;
  static Color get _primaryTextColor =>
      _isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
  static Color get _secondaryTextColor =>
      _isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

  // Headings
  static TextStyle get h1 => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: _primaryTextColor,
  );
  static TextStyle get h2 => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: _primaryTextColor,
  );
  static TextStyle get h3 => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _primaryTextColor,
  );
  static TextStyle get h4 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: _primaryTextColor,
  );

  // Body
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: _primaryTextColor,
  );
  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: _primaryTextColor,
  );
  static TextStyle get bodySmall => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: _primaryTextColor,
  );
  static TextStyle get bodyBold => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: _primaryTextColor,
  );

  // Other Styles
  static TextStyle get caption => TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: _secondaryTextColor,
  );
  static TextStyle get label =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey);
  static TextStyle get error => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
  );
  static TextStyle get button =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);

  // Context-aware methods for dynamic theme updates
  static TextStyle h1Style(BuildContext context) =>
      h1.copyWith(color: Theme.of(context).colorScheme.onSurface);
  static TextStyle h2Style(BuildContext context) =>
      h2.copyWith(color: Theme.of(context).colorScheme.onSurface);
  static TextStyle h3Style(BuildContext context) =>
      h3.copyWith(color: Theme.of(context).colorScheme.onSurface);
  static TextStyle h4Style(BuildContext context) =>
      h4.copyWith(color: Theme.of(context).colorScheme.onSurface);
  static TextStyle bodyLargeStyle(BuildContext context) =>
      bodyLarge.copyWith(color: Theme.of(context).colorScheme.onSurface);
  static TextStyle bodyMediumStyle(BuildContext context) =>
      bodyMedium.copyWith(color: Theme.of(context).colorScheme.onSurface);
  static TextStyle bodySmallStyle(BuildContext context) =>
      bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface);
  static TextStyle bodyBoldStyle(BuildContext context) =>
      bodyBold.copyWith(color: Theme.of(context).colorScheme.onSurface);
}
