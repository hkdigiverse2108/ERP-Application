import 'package:ai_setu/modules/bank_cash/bank_transaction/controllers/bank_transaction_controller.dart';
import 'package:get/get.dart';

class BankTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankTransactionController());
  }
}
