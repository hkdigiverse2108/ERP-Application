import 'package:ai_setu/modules/accounting/debit/controllers/debit_add_edit_controller.dart';
import 'package:get/get.dart';

class DebitAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebitAddEditController>(() => DebitAddEditController());
  }
}
