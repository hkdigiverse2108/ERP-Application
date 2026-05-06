import 'package:ai_setu/modules/settings/payment_terms/controllers/payment_terms_add_edit_controller.dart';
import 'package:get/get.dart';

class PaymentTermsAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentTermsAddEditController>(
      () => PaymentTermsAddEditController(),
    );
  }
}
