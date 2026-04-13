import 'package:ai_setu/modules/settings/payment_terms/controllers/payment_terms_controller.dart';
import 'package:get/get.dart';

class PaymentTermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentTermsController>(() => PaymentTermsController());
  }
}
