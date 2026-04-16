import 'package:ai_setu/shared/quick_action/controllers/quick_search_controller.dart';
import 'package:get/get.dart';

class QuickSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuickSearchController>(() => QuickSearchController());
  }
}
