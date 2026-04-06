import 'package:ai_setu/modules/sales/controllers/sales_controller.dart';
import 'package:get/get.dart';

class SalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesController());
  }
}
