import 'package:ai_setu/modules/bank_cash/controllers/bank_cash_controller.dart';
import 'package:get/get.dart';

class BankCashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankCashController>(() => BankCashController());
  }
}
