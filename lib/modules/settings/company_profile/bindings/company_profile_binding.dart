import 'package:ai_setu/modules/settings/company_profile/controllers/company_profile_controller.dart';
import 'package:get/get.dart';

class CompanyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyProfileController>(() => CompanyProfileController());
  }
}
