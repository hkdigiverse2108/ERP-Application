import 'package:ai_setu/modules/pos/pos_payment/controllers/pos_payment_controller.dart';
import 'package:get/get.dart';

class PosPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosPaymentController>(() => PosPaymentController());
  }
}
