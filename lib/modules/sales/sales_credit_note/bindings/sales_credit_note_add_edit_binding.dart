import 'package:ai_setu/modules/sales/sales_credit_note/controllers/sales_credit_note_add_edit_controller.dart';
import 'package:get/get.dart';

class SalesCreditNoteAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesCreditNoteAddEditController>(
      () => SalesCreditNoteAddEditController(),
    );
  }
}
