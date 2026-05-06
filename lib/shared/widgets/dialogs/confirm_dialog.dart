import 'dart:ui';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final Color? confirmColor;
  final IconData? icon;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.confirmColor,
    this.icon,
  });

  static Future<void> show({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    Color? confirmColor,
    IconData? icon,
  }) async {
    await Get.dialog(
      ConfirmDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor: confirmColor,
        icon: icon,
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 340),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
              border: Border.all(color: colors.border.withValues(alpha: 0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: (confirmColor ?? colors.primary).withValues(
                      alpha: 0.1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon ?? PhosphorIconsLight.warning,
                    color: confirmColor ?? colors.primary,
                    size: 32,
                  ),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextHelper.h4Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(12),
                      Text(
                        message,
                        style: TextHelper.bodyMediumStyle(
                          context,
                        ).copyWith(color: colors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Gap(32),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: colors.border),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusM,
                              ),
                            ),
                          ),
                          child: Text(
                            cancelText,
                            style: TextHelper.bodyMediumStyle(context).copyWith(
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            Get.back();
                            onConfirm();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: confirmColor ?? colors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusM,
                              ),
                            ),
                          ),
                          child: Text(
                            confirmText,
                            style: TextHelper.bodyMediumStyle(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
