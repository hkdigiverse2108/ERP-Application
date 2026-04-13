import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccessDeniedPage extends StatelessWidget {
  const AccessDeniedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Sizes.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsFill.warningCircle,
                  size: 80,
                  color: Colors.red.shade400,
                ),
              ),
              const Gap(32),
              Text(
                "Access Denied",
                style: TextHelper.h2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textPrimary,
                ),
              ),
              const Gap(16),
              Text(
                "You do not have permission to view this page.\nPlease contact your administrator if you believe this is an error.",
                textAlign: TextAlign.center,
                style: TextHelper.bodyMedium.copyWith(
                  color: context.appColors.textSecondary,
                ),
              ),
              const Gap(48),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(Routes.signIn),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text("Return to Login"),
                ),
              ),
              const Gap(16),
              TextButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(PhosphorIconsLight.arrowLeft),
                label: const Text("Go Back"),
                style: TextButton.styleFrom(
                  foregroundColor: context.appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
