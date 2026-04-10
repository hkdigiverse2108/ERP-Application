import 'package:ai_setu/modules/pos/credit_note/controllers/credit_note_controller.dart';
import 'package:get/get.dart';

class CreditNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreditNoteController());
  }
}
