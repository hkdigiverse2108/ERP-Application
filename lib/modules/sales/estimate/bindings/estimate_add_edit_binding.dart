import 'package:ai_setu/modules/sales/estimate/controllers/estimate_add_edit_controller.dart';
import 'package:get/get.dart';

class EstimateAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EstimateAddEditController>(() => EstimateAddEditController());
  }
}
