import 'package:ai_setu/modules/auth/controllers/sign_in_controller.dart';
import 'package:get/instance_manager.dart';

class SignInBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
