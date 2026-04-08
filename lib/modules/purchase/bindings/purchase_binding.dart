import 'package:get/get.dart';
import 'package:ai_setu/modules/purchase/controllers/purchase_controller.dart';

class PurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseController());
  }
}
