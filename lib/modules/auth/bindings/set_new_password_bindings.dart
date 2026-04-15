import 'package:ai_setu/modules/auth/controllers/set_new_password_controller.dart';
import 'package:get/instance_manager.dart';

class SetNewPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetNewPasswordController>(() => SetNewPasswordController());
  }
}
