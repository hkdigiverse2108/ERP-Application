import 'package:ai_setu/modules/purchase/purchase_order/controllers/purchase_order_add_edit_controller.dart';
import 'package:ai_setu/modules/purchase/purchase_order/controllers/purchase_order_controller.dart';
import 'package:get/get.dart';

class PurchaseOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseOrderController());
    Get.lazyPut(() => PurchaseOrderAddEditController());
  }
}
