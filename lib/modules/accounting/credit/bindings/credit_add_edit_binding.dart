import 'package:ai_setu/modules/accounting/credit/controllers/credit_add_edit_controller.dart';
import 'package:get/get.dart';

class CreditAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditAddEditController>(() => CreditAddEditController());
  }
}
