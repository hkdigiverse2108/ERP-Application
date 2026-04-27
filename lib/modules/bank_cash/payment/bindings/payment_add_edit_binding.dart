import 'package:ai_setu/modules/bank_cash/payment/controllers/payment_add_edit_controller.dart';
import 'package:get/get.dart';

class PaymentAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentAddEditController>(() => PaymentAddEditController());
  }
}
