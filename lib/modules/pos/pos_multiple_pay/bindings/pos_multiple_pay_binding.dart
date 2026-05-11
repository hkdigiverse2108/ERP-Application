import 'package:ai_setu/modules/pos/pos_multiple_pay/controllers/pos_multiple_pay_controller.dart';
import 'package:get/get.dart';

class PosMultiplePayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosMultiplePayController>(() => PosMultiplePayController());
  }
}
