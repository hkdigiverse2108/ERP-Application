import 'package:ai_setu/modules/inventory/controllers/inventory_controller.dart';
import 'package:get/get.dart';

class InventoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(InventoryController());
  }
}
