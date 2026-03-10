import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.signIn);
    });
  }
}
