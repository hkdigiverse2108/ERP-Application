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
                    controller: controller.email,
                    hintText: "Enter Your Email",
                  ),
                  Gap(18),
                  Obx(
                    () => NormalField(
                      labelFloating: true,
                      labelText: "Password",
                      controller: controller.password,
                      hintText: "Enter Your Password",
                      obscureText: !controller.show.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.show.value
                              ? PhosphorIconsBold.eyeClosed
                              : PhosphorIconsBold.eye,
                        ),
                        onPressed: () {
                          controller.show.value = !controller.show.value;
                        },
                      ),
                    ),
                  ),
                  Gap(20),
                  CommonButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.home);
                    },
                    text: Strings.login.toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
