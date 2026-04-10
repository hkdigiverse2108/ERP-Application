import 'package:ai_setu/modules/sales/invoice/controllers/invoice_controller.dart';
import 'package:get/get.dart';

class InvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoiceController());
  }
}
