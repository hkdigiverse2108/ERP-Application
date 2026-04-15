import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/auth/controllers/verification_controller.dart';
import 'package:ai_setu/shared/widgets/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class Verification extends GetView<VerificationController> {
  final String email;
  const Verification({super.key, this.email = ''});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: TextHelper.h2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

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
                key: controller.otpKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Text(Strings.verification, style: TextHelper.h2),
                    Text(Strings.verificationMsg, style: TextHelper.label),
                    Gap(24),
                    Center(
                      child: Pinput(
                        length: 6,
                        controller: controller.otpController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Please enter 6-digit OTP";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(24),
                    Obx(
                      () => CommonButton(
                        onPressed: () {
                          controller.verifyOtp();
                        },
                        isLoading: controller.isLoading.value,
                        text: Strings.conform.toUpperCase(),
                      ),
                    ),
                    Gap(20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          controller.resendOtp();
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextHelper.bodyBold.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
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
