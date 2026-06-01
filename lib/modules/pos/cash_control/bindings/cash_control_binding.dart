import 'package:get/get.dart';
import 'package:ai_setu/modules/pos/cash_control/controllers/cash_control_controller.dart';
import 'package:ai_setu/data/repositories/pos/cash_control_repository.dart';
import 'package:ai_setu/data/repositories/pos/cash_register_repository.dart';

class CashControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashControlRepository>(() => CashControlRepository());
    Get.lazyPut<CashRegisterRepository>(() => CashRegisterRepository());
    Get.lazyPut<CashControlController>(
      () => CashControlController(
        repository: Get.find<CashControlRepository>(),
        registerRepository: Get.find<CashRegisterRepository>(),
      ),
    );
  }
}
