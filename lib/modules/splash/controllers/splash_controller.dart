import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/services/storage_service.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _precacheImages();
    _navigateToNext();
  }

  void _precacheImages() {
    final context = Get.context;
    if (context != null) {
      precacheImage(const AssetImage(Images.splashBg), context);
      precacheImage(const AssetImage(Images.lightAisetuLogo), context);
    }
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 2), () {
      final isLoggedIn =
          StorageService().read<bool>(StorageKeys.isLoggedIn) ?? false;
      if (isLoggedIn) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.signIn);
      }
    });
  }
}
