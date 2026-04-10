import 'package:ai_setu/modules/accounting/credit/controllers/credit_controller.dart';
import 'package:get/get.dart';

class CreditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreditController());
  }
}
