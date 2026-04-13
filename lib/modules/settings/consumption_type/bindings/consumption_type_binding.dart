import 'package:ai_setu/modules/settings/consumption_type/controllers/consumption_type_controller.dart';
import 'package:get/get.dart';

class ConsumptionTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsumptionTypeController>(() => ConsumptionTypeController());
  }
}
