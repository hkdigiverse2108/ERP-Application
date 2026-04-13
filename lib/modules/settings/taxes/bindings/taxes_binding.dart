import 'package:ai_setu/modules/settings/taxes/controllers/taxes_controller.dart';
import 'package:get/get.dart';

class TaxesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaxesController>(() => TaxesController());
  }
}
