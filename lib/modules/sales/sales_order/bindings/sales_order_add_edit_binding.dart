import 'package:get/get.dart';
import '../controllers/sales_order_add_edit_controller.dart';

class SalesOrderAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesOrderAddEditController>(
      () => SalesOrderAddEditController(),
    );
  }
}
