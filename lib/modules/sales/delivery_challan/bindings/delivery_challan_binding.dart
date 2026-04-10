import 'package:ai_setu/modules/sales/delivery_challan/controllers/delivery_challan_controller.dart';
import 'package:get/get.dart';

class DeliveryChallanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryChallanController());
  }
}
