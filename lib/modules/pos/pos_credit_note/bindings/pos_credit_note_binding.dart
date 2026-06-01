import 'package:ai_setu/modules/pos/pos_credit_note/controllers/pos_credit_note_controller.dart';
import 'package:get/get.dart';

class PosCreditNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosCreditNoteController>(() => PosCreditNoteController());
  }
}
