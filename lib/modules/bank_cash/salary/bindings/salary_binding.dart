import 'package:ai_setu/modules/bank_cash/salary/controllers/salary_controller.dart';
import 'package:get/get.dart';

class SalaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalaryController());
  }
}
