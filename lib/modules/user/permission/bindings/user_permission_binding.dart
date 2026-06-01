import 'package:ai_setu/modules/user/permission/controllers/user_permission_controller.dart';
import 'package:get/get.dart';

class UserPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPermissionController>(() => UserPermissionController());
  }
}
