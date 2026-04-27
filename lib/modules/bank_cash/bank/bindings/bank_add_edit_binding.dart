import 'package:ai_setu/modules/bank_cash/bank/controllers/bank_add_edit_controller.dart';
import 'package:get/get.dart';

class BankAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankAddEditController());
  }
}
