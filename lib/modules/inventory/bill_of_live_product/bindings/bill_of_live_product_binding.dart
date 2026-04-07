import 'package:ai_setu/modules/inventory/bill_of_live_product/controllers/bill_of_live_product_controller.dart';
import 'package:get/get.dart';

class BillOfLiveProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillOfLiveProductController>(() => BillOfLiveProductController());
  }
}
