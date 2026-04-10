import 'package:ai_setu/modules/bank_cash/receipt/controllers/receipt_controller.dart';
import 'package:get/get.dart';

class ReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReceiptController());
  }
}
