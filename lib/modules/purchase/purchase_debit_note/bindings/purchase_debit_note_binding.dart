import 'package:ai_setu/modules/purchase/purchase_debit_note/controllers/purchase_debit_note_controller.dart';
import 'package:get/get.dart';

class PurchaseDebitNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseDebitNoteController());
  }
}
