import 'package:ai_setu/modules/sales/invoice/controllers/invoice_add_edit_controller.dart';
import 'package:get/get.dart';

class InvoiceAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceAddEditController>(() => InvoiceAddEditController());
  }
}
