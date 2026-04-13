import 'package:ai_setu/modules/settings/user_roles/controllers/user_roles_controller.dart';
import 'package:get/get.dart';

class UserRolesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRolesController>(() => UserRolesController());
  }
}
