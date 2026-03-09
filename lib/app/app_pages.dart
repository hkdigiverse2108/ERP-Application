import 'package:ai_setu/modules/splash/bindings/splash_bindings.dart';
import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/modules/splash/views/splash.dart';
import 'package:flutter/material.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const Splash(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const Scaffold(body: Center(child: Text("Home"))),
    ),
  ];
}
