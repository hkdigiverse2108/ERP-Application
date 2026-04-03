import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/auth/controllers/sign_in_controller.dart';
import 'package:ai_setu/shared/widgets/buttons/common_button.dart';
import 'package:ai_setu/shared/widgets/text_fields/normal_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SignIn extends GetView<SignInController> {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
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
          ),

          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Text(Strings.login, style: TextHelper.h2),
                    Text(Strings.loginMsg, style: TextHelper.label),
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
                    Gap(18),
                    Obx(
                      () => NormalField(
                        labelFloating: true,
                        labelText: "Password",
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        hintText: "Enter Your Password",
                        obscureText: !controller.showPassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showPassword.value
                                ? PhosphorIconsBold.eyeClosed
                                : PhosphorIconsBold.eye,
                          ),
                          onPressed: () {
                            controller.togglePassword();
                          },
                        ),
                      ),
                    ),
                    Gap(20),
                    CommonButton(
                      onPressed: () {
                        controller.login();
                      },
                      text: Strings.login.toUpperCase(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
