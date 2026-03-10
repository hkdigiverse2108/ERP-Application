import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final show = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
