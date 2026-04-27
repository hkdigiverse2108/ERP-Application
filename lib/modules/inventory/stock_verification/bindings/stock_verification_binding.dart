import 'package:ai_setu/modules/inventory/stock_verification/controllers/stock_verification_add_edit_controller.dart';
import 'package:ai_setu/modules/inventory/stock_verification/controllers/stock_verification_controller.dart';
import 'package:get/get.dart';

class StockVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockVerificationController>(
      () => StockVerificationController(),
    );
    Get.lazyPut<StockVerificationAddEditController>(
      () => StockVerificationAddEditController(),
    );
  }
}
