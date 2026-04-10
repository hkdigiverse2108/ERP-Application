import 'package:ai_setu/modules/bank_cash/bank/controllers/bank_controller.dart';
import 'package:get/get.dart';

class BankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankController());
  }
}
