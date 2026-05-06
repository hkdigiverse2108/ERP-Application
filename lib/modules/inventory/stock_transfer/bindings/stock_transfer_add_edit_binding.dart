import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_add_edit_controller.dart';
import 'package:get/get.dart';

class StockTransferAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockTransferAddEditController>(
      () => StockTransferAddEditController(),
    );
  }
}
