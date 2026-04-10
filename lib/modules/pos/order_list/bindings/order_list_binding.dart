import 'package:ai_setu/modules/pos/order_list/controllers/order_list_controller.dart';
import 'package:get/get.dart';

class OrderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderListController());
  }
}
