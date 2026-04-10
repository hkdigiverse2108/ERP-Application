import 'package:ai_setu/modules/accounting/debit/controllers/debit_controller.dart';
import 'package:get/get.dart';

class DebitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DebitController());
  }
}
