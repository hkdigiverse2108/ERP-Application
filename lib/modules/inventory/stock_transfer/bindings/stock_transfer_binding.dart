import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_controller.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_details_controller.dart';
import 'package:get/get.dart';

class StockTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockTransferController>(() => StockTransferController());
    Get.lazyPut<StockTransferDetailsController>(() => StockTransferDetailsController());
  }
}
