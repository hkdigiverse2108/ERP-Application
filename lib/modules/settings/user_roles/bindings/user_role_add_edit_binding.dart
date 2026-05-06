import 'package:ai_setu/modules/settings/user_roles/controllers/user_role_add_edit_controller.dart';
import 'package:get/get.dart';

class UserRoleAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRoleAddEditController>(() => UserRoleAddEditController());
  }
}
