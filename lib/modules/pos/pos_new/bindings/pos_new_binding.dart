import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:get/get.dart';

class PosNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosNewController>(() => PosNewController());
  }
}
