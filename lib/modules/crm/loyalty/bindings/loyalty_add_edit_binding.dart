import 'package:ai_setu/modules/crm/loyalty/controllers/loyalty_add_edit_controller.dart';
import 'package:get/get.dart';

class LoyaltyAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoyaltyAddEditController>(() => LoyaltyAddEditController());
  }
}
