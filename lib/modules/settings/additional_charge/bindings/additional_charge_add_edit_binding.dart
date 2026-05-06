import 'package:ai_setu/modules/settings/additional_charge/controllers/additional_charge_add_edit_controller.dart';
import 'package:get/get.dart';

class AdditionalChargeAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditionalChargeAddEditController>(
      () => AdditionalChargeAddEditController(),
    );
  }
}
