import 'package:ai_setu/modules/sales/delivery_challan/controllers/delivery_challan_add_edit_controller.dart';
import 'package:get/get.dart';

class DeliveryChallanAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryChallanAddEditController>(
      () => DeliveryChallanAddEditController(),
    );
  }
}
