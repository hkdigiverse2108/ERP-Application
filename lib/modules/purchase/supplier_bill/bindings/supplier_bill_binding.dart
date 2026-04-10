import 'package:ai_setu/modules/purchase/supplier_bill/controllers/supplier_bill_controller.dart';
import 'package:get/get.dart';

class SupplierBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupplierBillController());
  }
}
