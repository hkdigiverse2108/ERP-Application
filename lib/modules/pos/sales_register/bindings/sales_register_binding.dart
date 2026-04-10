import 'package:ai_setu/modules/pos/sales_register/controllers/sales_register_controller.dart';
import 'package:get/get.dart';

class SalesRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesRegisterController());
  }
}
