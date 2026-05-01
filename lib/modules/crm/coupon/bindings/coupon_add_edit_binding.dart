import 'package:ai_setu/modules/crm/coupon/controllers/coupon_add_edit_controller.dart';
import 'package:get/get.dart';

class CouponAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponAddEditController>(() => CouponAddEditController());
  }
}
