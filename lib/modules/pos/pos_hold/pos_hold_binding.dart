import 'package:get/get.dart';
import 'pos_hold_controller.dart';

class PosHoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosHoldController>(() => PosHoldController());
  }
}
