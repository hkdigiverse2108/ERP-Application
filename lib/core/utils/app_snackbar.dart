import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum SnackbarType { success, error, warning, info }

class AppSnackbar {
  AppSnackbar._();

  static void success(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      title: title ?? 'Success',
      message: message,
      type: SnackbarType.success,
      position: position,
      duration: duration,
    );
  }

  static void error(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      title: title ?? 'Error',
      message: message,
      type: SnackbarType.error,
      position: position,
      duration: duration,
    );
  }

  static void warning(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      title: title ?? 'Warning',
      message: message,
      type: SnackbarType.warning,
      position: position,
      duration: duration,
    );
  }

  static void info(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      title: title ?? 'Info',
      message: message,
      type: SnackbarType.info,
      position: position,
      duration: duration,
    );
  }

  static void showInfinite(
    String message, {
    String? title,
    SnackbarType type = SnackbarType.error,
  }) {
    _show(
      title: title ?? 'Notification',
      message: message,
      type: type,
      duration: const Duration(days: 1), // Practically infinite
    );
  }

  // ─── Actions ─────────────────────────────────────────────────────────────

  static void showAction(
    String message, {
    required String actionLabel,
    required VoidCallback onAction,
    String title = 'Notification',
    SnackbarType type = SnackbarType.info,
    SnackPosition position = SnackPosition.TOP,
  }) {
    _show(
      title: title,
      message: message,
      type: type,
      position: position,
      mainButton: TextButton(
        onPressed: () {
          onAction();
          if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
        },
        child: Text(
          actionLabel,
          style: TextStyle(
            color: _SnackbarConfig.from(type).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ─── Core ────────────────────────────────────────────────────────────────

  static void _show({
    required String title,
    required String message,
    required SnackbarType type,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
    Widget? mainButton,
  }) {
    // Dismiss any existing snackbar before showing a new one
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    final config = _SnackbarConfig.from(type);

    Get.snackbar(
      title,
      message,

      // Layout
      snackPosition: position,
      margin: EdgeInsets.all(Sizes.paddingM),
      padding: EdgeInsets.all(Sizes.paddingM),
      borderRadius: Sizes.borderRadiusM,
      duration: duration,

      // Colors
      backgroundColor: config.backgroundColor,
      colorText: config.textColor,

      // Left accent border (subtle)
      borderColor: config.accentColor,
      borderWidth: 0,

      // Action
      mainButton: mainButton is TextButton ? mainButton : null,

      // Icon Design (Simplified)
      icon: Icon(config.icon, color: config.accentColor, size: 24),

      // Text Styles (Aligned with app)
      titleText: Text(
        title,
        style: TextHelper.bodyBold.copyWith(color: config.textColor),
      ),
      messageText: Text(
        message,
        style: TextHelper.bodyMedium.copyWith(color: config.subtextColor),
      ),

      // Dismiss behavior
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,

      // Standard Shadow
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

// ─── Config ──────────────────────────────────────────────────────────────────

class _SnackbarConfig {
  final Color backgroundColor;
  final Color accentColor;
  final Color textColor;
  final Color subtextColor;
  final IconData icon;

  const _SnackbarConfig({
    required this.backgroundColor,
    required this.accentColor,
    required this.textColor,
    required this.subtextColor,
    required this.icon,
  });

  factory _SnackbarConfig.from(SnackbarType type) {
    final isDark = Get.isDarkMode;

    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final textSecondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    switch (type) {
      case SnackbarType.success:
        return _SnackbarConfig(
          backgroundColor: surface,
          accentColor: AppColors.success,
          textColor: textPrimary,
          subtextColor: textSecondary,
          icon: PhosphorIconsFill.checkCircle,
        );
      case SnackbarType.error:
        return _SnackbarConfig(
          backgroundColor: surface,
          accentColor: AppColors.error,
          textColor: textPrimary,
          subtextColor: textSecondary,
          icon: PhosphorIconsFill.xCircle,
        );
      case SnackbarType.warning:
        return _SnackbarConfig(
          backgroundColor: surface,
          accentColor: AppColors.warning,
          textColor: textPrimary,
          subtextColor: textSecondary,
          icon: PhosphorIconsFill.warning,
        );
      case SnackbarType.info:
        return _SnackbarConfig(
          backgroundColor: surface,
          accentColor: AppColors.info,
          textColor: textPrimary,
          subtextColor: textSecondary,
          icon: PhosphorIconsFill.info,
        );
    }
  }
}
