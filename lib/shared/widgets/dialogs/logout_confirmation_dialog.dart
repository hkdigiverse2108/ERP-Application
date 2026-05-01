import 'dart:ui';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  /// Entry point for the logout dialog.
  static Future<void> show() async {
    await Get.dialog(
      const LogoutConfirmationDialog(),
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                const Gap(32),

                // ── Official Logo ──
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  height: 45,
                  child: Image.asset(
                    isDark ? Images.lightAisetuLogo : Images.darkAisetuLogo,
                    fit: BoxFit.contain,
                  ),
                ),

                const Gap(24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        'Logout',
                        style: TextHelper.h3Style(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(12),
                      Text(
                        'Are you sure you want to log out?',
                        style: TextHelper.bodyMediumStyle(
                          context,
                        ).copyWith(color: colors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const Gap(32),

                // ── Action Buttons ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            Get.back();
                          },
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
                            'Cancel',
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
                            AuthRepository().logout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
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
                            'Logout',
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

