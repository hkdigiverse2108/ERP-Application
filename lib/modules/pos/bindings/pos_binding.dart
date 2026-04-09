import 'package:ai_setu/modules/pos/controllers/pos_controller.dart';
import 'package:get/get.dart';

class PosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PosController());
  }
}
