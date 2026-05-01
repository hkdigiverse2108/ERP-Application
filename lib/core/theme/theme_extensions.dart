import 'package:flutter/material.dart';
import 'package:ai_setu/core/constants/colors.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color sectionSell;
  final Color sectionSellPurchase;
  final Color sectionPaid;
  final Color sectionProfit;
  final Color border;
  final Color surface;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color error;
  final Color success;
  final Color warning;
  final Color info;

  /// Alias for textPrimary to resolve compilation errors in some views.
  Color get text => textPrimary;

  const AppColorsExtension({
    required this.primary,
    required this.sectionSell,
    required this.sectionSellPurchase,
    required this.sectionPaid,
    required this.sectionProfit,
    required this.border,
    required this.surface,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? sectionSell,
    Color? sectionSellPurchase,
    Color? sectionPaid,
    Color? sectionProfit,
    Color? border,
    Color? surface,
    Color? background,
    Color? textPrimary,
    Color? textSecondary,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      sectionSell: sectionSell ?? this.sectionSell,
      sectionSellPurchase: sectionSellPurchase ?? this.sectionSellPurchase,
      sectionPaid: sectionPaid ?? this.sectionPaid,
      sectionProfit: sectionProfit ?? this.sectionProfit,
      border: border ?? this.border,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      sectionSell: Color.lerp(sectionSell, other.sectionSell, t)!,
      sectionSellPurchase: Color.lerp(
        sectionSellPurchase,
        other.sectionSellPurchase,
        t,
      )!,
      sectionPaid: Color.lerp(sectionPaid, other.sectionPaid, t)!,
      sectionProfit: Color.lerp(sectionProfit, other.sectionProfit, t)!,
      border: Color.lerp(border, other.border, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }

  static const light = AppColorsExtension(
    primary: AppColors.primaryLight,
    sectionSell: AppColors.lightSectionSell,
    sectionSellPurchase: AppColors.lightSectionSellPurchase,
    sectionPaid: AppColors.lightSectionPaid,
    sectionProfit: AppColors.lightSectionProfit,
    border: AppColors.lightBorder,
    surface: AppColors.lightSurface,
    background: AppColors.lightBackground,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    error: AppColors.error,
    success: AppColors.success,
    warning: AppColors.warning,
    info: AppColors.info,
  );

  static const dark = AppColorsExtension(
    primary: AppColors.primaryDark,
    sectionSell: AppColors.darkSectionSell,
    sectionSellPurchase: AppColors.darkSectionSellPurchase,
    sectionPaid: AppColors.darkSectionPaid,
    sectionProfit: AppColors.darkSectionProfit,
    border: AppColors.darkBorder,
    surface: AppColors.darkSurface,
    background: AppColors.darkBackground,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    error: AppColors.error,
    success: AppColors.success,
    warning: AppColors.warning,
    info: AppColors.info,
  );
}
