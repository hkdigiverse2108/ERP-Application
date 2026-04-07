import 'package:ai_setu/modules/accounting/controllers/accounting_controller.dart';
import 'package:get/get.dart';

class AccountingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountingController>(() => AccountingController());
  }
}
