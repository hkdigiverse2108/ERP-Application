import 'package:ai_setu/modules/bank_cash/expense/controllers/expense_add_edit_controller.dart';
import 'package:get/get.dart';

class ExpenseAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseAddEditController>(() => ExpenseAddEditController());
  }
}
