import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final show = false.obs;

  void login() {
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar("Error", "Please fill all the fields");
      return;
    }
    Get.toNamed("Home Page");
  }

  void showPassword() {
    show.toggle();
  }
}
