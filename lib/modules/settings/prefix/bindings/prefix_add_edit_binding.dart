import 'package:ai_setu/modules/settings/prefix/controllers/prefix_add_edit_controller.dart';
import 'package:get/get.dart';

class PrefixAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrefixAddEditController>(() => PrefixAddEditController());
  }
}
