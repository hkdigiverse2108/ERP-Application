import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/modules/splash/views/splash.dart';
import 'package:ai_setu/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const Splash(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const Scaffold(body: Center(child: Text("Home"))),
    ),
  ];
}
