import 'package:ai_setu/modules/crm/discount/controllers/discount_controller.dart';
import 'package:get/get.dart';

class DiscountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscountController());
  }
}
