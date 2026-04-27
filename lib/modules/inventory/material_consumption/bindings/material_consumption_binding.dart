import 'package:ai_setu/modules/inventory/material_consumption/controllers/material_consumption_add_edit_controller.dart';
import 'package:ai_setu/modules/inventory/material_consumption/controllers/material_consumption_controller.dart';
import 'package:get/get.dart';

class MaterialConsumptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterialConsumptionController>(() => MaterialConsumptionController());
    Get.lazyPut<MaterialConsumptionAddEditController>(() => MaterialConsumptionAddEditController());
  }
}
