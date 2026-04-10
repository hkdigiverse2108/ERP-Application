import 'package:ai_setu/modules/sales/estimate/controllers/estimate_controller.dart';
import 'package:get/get.dart';

class EstimateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EstimateController());
  }
}
