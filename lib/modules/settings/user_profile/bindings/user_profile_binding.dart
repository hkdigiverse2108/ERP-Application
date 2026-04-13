import 'package:ai_setu/modules/settings/user_profile/controllers/user_profile_controller.dart';
import 'package:get/get.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}
