import 'package:ai_setu/modules/settings/consumption_type/controllers/consumption_type_add_edit_controller.dart';
import 'package:get/get.dart';

class ConsumptionTypeAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsumptionTypeAddEditController());
  }
}
