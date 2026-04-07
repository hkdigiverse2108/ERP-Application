import 'package:ai_setu/modules/inventory/stock/controllers/stock_controller.dart';
import 'package:get/get.dart';

class StockBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockController>(() => StockController());
  }
}