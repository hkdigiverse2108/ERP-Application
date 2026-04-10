import 'package:ai_setu/modules/sales/sales_order/controllers/sales_order_controller.dart';
import 'package:get/get.dart';

class SalesOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesOrderController());
  }
}
