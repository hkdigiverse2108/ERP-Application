import 'package:ai_setu/modules/announcement/controllers/announcement_controller.dart';
import 'package:get/get.dart';

class AnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnnouncementController>(() => AnnouncementController());
  }
}
