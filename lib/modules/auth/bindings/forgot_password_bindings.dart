import 'package:ai_setu/modules/auth/controllers/forget_password_controller.dart';
import 'package:get/instance_manager.dart';

class ForgotPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
  }
}
