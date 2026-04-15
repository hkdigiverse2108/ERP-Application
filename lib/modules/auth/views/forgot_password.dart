import 'package:ai_setu/app/app_routes.dart';

import 'package:ai_setu/core/constants/images.dart';

import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/auth/controllers/forget_password_controller.dart';
import 'package:ai_setu/shared/widgets/buttons/common_button.dart';
import 'package:ai_setu/shared/widgets/text_fields/normal_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ForgotPassword extends GetView<ForgetPasswordController> {
  const ForgotPassword({super.key});

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
                key: controller.forgetPasswordFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Text(Strings.forgotPassword, style: TextHelper.h2),
                    Text(Strings.forgotPasswordMsg, style: TextHelper.label),
                    Gap(18),
                    NormalField(
                      labelFloating: true,
                      labelText: "Email ID",
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      hintText: "Enter Your Email",
                    ),
                    Gap(20),
                    Obx(
                      () => CommonButton(
                        onPressed: () {
                          controller.forgotPassword();
                        },
                        isLoading: controller.isLoading.value,
                        text: "SEND",
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
