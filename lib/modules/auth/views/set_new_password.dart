import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/images.dart';

import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/auth/controllers/set_new_password_controller.dart';
import 'package:ai_setu/shared/widgets/buttons/common_button.dart';
import 'package:ai_setu/shared/widgets/text_fields/normal_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SetNewPassword extends GetView<SetNewPasswordController> {
  final String email;
  const SetNewPassword({super.key, this.email = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.splashBg),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Image.asset(Images.lightAisetuLogo),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Text(Strings.setNewPassword, style: TextHelper.h2),
                    Text(
                      "Create a new password for your account",
                      style: TextHelper.label,
                    ),
                    Gap(18),
                    Obx(
                      () => NormalField(
                        labelFloating: true,
                        labelText: Strings.password,
                        controller: controller.newPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        hintText: "Enter new password",
                        obscureText: !controller.showNewPassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showNewPassword.value
                                ? PhosphorIconsBold.eyeClosed
                                : PhosphorIconsBold.eye,
                          ),
                          onPressed: () {
                            controller.toggleShowNewPassword();
                          },
                        ),
                      ),
                    ),
                    Gap(18),
                    Obx(
                      () => NormalField(
                        labelFloating: true,
                        labelText: Strings.confirmPassword,
                        controller: controller.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (value != controller.newPasswordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        hintText: "Re-enter new password",
                        obscureText: !controller.showConfirmPassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showConfirmPassword.value
                                ? PhosphorIconsBold.eyeClosed
                                : PhosphorIconsBold.eye,
                          ),
                          onPressed: () {
                            controller.toggleShowConfirmPassword();
                          },
                        ),
                      ),
                    ),
                    Gap(20),
                    Obx(
                      () => CommonButton(
                        onPressed: () {
                          controller.saveAndLogin();
                        },
                        isLoading: controller.isLoading.value,
                        text: Strings.saveAndLogin.toUpperCase(),
                      ),
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Strings.tryLogin, style: TextHelper.bodySmall),
                        TextButton(
                          onPressed: () => Get.offAllNamed(Routes.signIn),
                          child: Text(
                            Strings.loginNow,
                            style: TextHelper.bodySmall.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
