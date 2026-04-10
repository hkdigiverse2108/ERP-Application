import 'package:ai_setu/modules/bank_cash/payment/controllers/payment_controller.dart';
import 'package:get/get.dart';

class ReceiptController extends PaymentController {
  static ReceiptController get instance => Get.find();

  ReceiptController() : super(voucherType: null);
}
