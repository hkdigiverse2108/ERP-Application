import 'package:ai_setu/modules/sales/sales_credit_note/controllers/sales_credit_note_controller.dart';
import 'package:get/get.dart';

class SalesCreditNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesCreditNoteController());
  }
}
