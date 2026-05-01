import 'package:ai_setu/modules/purchase/purchase_debit_note/controllers/purchase_debit_note_add_edit_controller.dart';
import 'package:get/get.dart';

class PurchaseDebitNoteAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseDebitNoteAddEditController>(
      () => PurchaseDebitNoteAddEditController(),
    );
  }
}
