import 'package:ai_setu/modules/crm/loyalty/controllers/loyalty_controller.dart';
import 'package:get/get.dart';

class LoyaltyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoyaltyController());
  }
}
