import 'dart:convert';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/images.dart';

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

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    final isLoggedIn =
        StorageService.instance.read<bool>(StorageKeys.isLoggedIn) ?? false;

    if (isLoggedIn) {
      final rawData = StorageService.instance.read(StorageKeys.userData);
      Map<String, dynamic>? userData;

      if (rawData is Map<String, dynamic>) {
        userData = rawData;
      } else if (rawData is String) {
        try {
          userData = Map<String, dynamic>.from(
            jsonDecode(rawData) as Map,
          );
        } catch (e) {
          Log.e("Failed to decode userData string", e);
        }
      }

      if (userData != null) {
        try {
          final user = UserModel.fromMap(userData);
          await PermissionService.to.fetchPermissions(user.id);
          Get.offAllNamed(PermissionService.to.defaultRoute);
        } catch (e) {
          Get.offAllNamed(Routes.signIn);
        }
      } else {
        Get.offAllNamed(Routes.signIn);
      }
    } else {
      Get.offAllNamed(Routes.signIn);
    }
  }
}
