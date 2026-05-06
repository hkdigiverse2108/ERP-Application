import 'package:ai_setu/modules/settings/taxes/controllers/tax_add_edit_controller.dart';
import 'package:get/get.dart';

class TaxAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaxAddEditController>(() => TaxAddEditController());
  }
}
