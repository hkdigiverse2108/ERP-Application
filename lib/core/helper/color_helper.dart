import 'package:flutter/material.dart';
import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/services/theme_service.dart';

class ColorHelper {
  /// Returns a color based on a condition, defaulting to theme-aware colors
  /// This is useful for those who don't want to deal with Theme.of(context) directly
  static Color getConditionColor({
    bool isSuccess = false,
    bool isWarning = false,
    bool isError = false,
    Color? defaultColor,
  }) {
    if (isSuccess) return AppColors.success;
    if (isWarning) return AppColors.warning;
    if (isError) return AppColors.error;

    return defaultColor ??
        (ThemeService().isDarkMode
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary);
  }

  /// Helper for status colors
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'completed':
      case 'success':
        return AppColors.success;
      case 'pending':
      case 'warning':
        return AppColors.warning;
      case 'inactive':
      case 'failed':
      case 'error':
        return AppColors.error;
      default:
        return ThemeService().isDarkMode
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary;
    }
  }

  /// Get a primary color that works well for both themes
  static Color get primary => AppColors.primary;
}
