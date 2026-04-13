import 'package:ai_setu/modules/settings/prefix/controllers/prefix_controller.dart';
import 'package:get/get.dart';

class PrefixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrefixController>(() => PrefixController());
  }
}
