import 'package:ai_setu/modules/user/controllers/update_user_controller.dart';
import 'package:ai_setu/modules/user/controllers/user_controller.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<UpdateUserController>(() => UpdateUserController());
  }
}
