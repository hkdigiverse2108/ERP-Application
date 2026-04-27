import 'package:ai_setu/modules/bank_cash/bank_transaction/controllers/bank_transaction_add_edit_controller.dart';
import 'package:get/get.dart';

class BankTransactionAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankTransactionAddEditController>(
      () => BankTransactionAddEditController(),
    );
  }
}
