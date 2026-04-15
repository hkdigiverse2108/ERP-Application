import 'package:ai_setu/modules/auth/controllers/verification_controller.dart';
import 'package:get/instance_manager.dart';

class VerificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(() => VerificationController());
  }
}
