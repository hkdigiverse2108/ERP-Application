import 'package:ai_setu/modules/crm/discount/controllers/discount_add_edit_controller.dart';
import 'package:get/get.dart';

class DiscountAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscountAddEditController>(() => DiscountAddEditController());
  }
}
