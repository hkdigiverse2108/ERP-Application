import 'package:ai_setu/modules/settings/additional_charge/controllers/additional_charge_controller.dart';
import 'package:get/get.dart';

class AdditionalChargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditionalChargeController>(() => AdditionalChargeController());
  }
}
