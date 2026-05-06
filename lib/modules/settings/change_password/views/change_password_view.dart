import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/settings/change_password/controllers/change_password_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/buttons/common_button.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/normal_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:ai_setu/core/helper/text_helper.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefAppBar(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuickAction(),
              Padding(
                padding: const EdgeInsets.all(Sizes.paddingM),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Sizes.paddingS),
                  decoration: BoxDecoration(
                    color: context.appColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                    border: Border.all(
                      color: context.appColors.primary.withValues(alpha: 0.1),
                    ),
                  ), 
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(Sizes.paddingM),
                        decoration: BoxDecoration(
                          color: context.appColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          PhosphorIconsFill.shieldCheck,
                          size: 40,
                          color: context.appColors.primary,
                        ),
                      ),
                      const Gap(Sizes.paddingM),
                      Text(
                        'Secure Your Account',
                        style: TextHelper.h3Style(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(Sizes.paddingS),
                      Text(
                        'A strong password helps keep your business data protected.',
                        textAlign: TextAlign.center,
                        style: TextHelper.bodySmallStyle(
                          context,
                        ).copyWith(color: context.appColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
                child: Obx(
                  () => NormalField(
                    controller: controller.oldPasswordController,
                    labelText: 'Current Password',
                    hintText: 'Enter current password',
                    obscureText: !controller.showOldPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showOldPassword.value
                            ? PhosphorIconsLight.eye
                            : PhosphorIconsLight.eyeSlash,
                      ),
                      onPressed: controller.toggleOldPassword,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const Gap(Sizes.paddingS),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
                child: Obx(
                  () => NormalField(
                    controller: controller.newPasswordController,
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                    obscureText: !controller.showNewPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showNewPassword.value
                            ? PhosphorIconsLight.eye
                            : PhosphorIconsLight.eyeSlash,
                      ),
                      onPressed: controller.toggleNewPassword,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter new password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const Gap(Sizes.paddingS),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
                child: Obx(
                  () => NormalField(
                    controller: controller.confirmPasswordController,
                    labelText: 'Confirm New Password',
                    hintText: 'Re-enter new password',
                    obscureText: !controller.showConfirmPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showConfirmPassword.value
                            ? PhosphorIconsLight.eye
                            : PhosphorIconsLight.eyeSlash,
                      ),
                      onPressed: controller.toggleConfirmPassword,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (value != controller.newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(Sizes.paddingM),
                child: Obx(
                  () => CommonButton(
                    onPressed: controller.changePassword,
                    isLoading: controller.isLoading.value,
                    text: 'UPDATE PASSWORD',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
