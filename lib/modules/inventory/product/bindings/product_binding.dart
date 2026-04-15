import 'package:ai_setu/modules/inventory/product/controllers/add_item_controller.dart';
import 'package:ai_setu/modules/inventory/product/controllers/product_add_edit_controller.dart';
import 'package:ai_setu/modules/inventory/product/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ProductAddEditController());
    Get.lazyPut(() => AddItemController());
  }
}
