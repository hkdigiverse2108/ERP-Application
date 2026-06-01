import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/services/showcase_service.dart';
import 'package:ai_setu/data/repositories/user/permission_repository.dart';
import 'package:ai_setu/data/repositories/settings/settings_repository.dart';
import 'package:ai_setu/modules/announcement/controllers/announcement_controller.dart';
import 'package:ai_setu/modules/settings/controllers/settings_controller.dart';
import 'package:ai_setu/modules/settings/user_profile/controllers/user_profile_controller.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService.instance, permanent: true);
    Get.put(ShowcaseService(), permanent: true);
    Get.put(ApiService(), permanent: true);
    Get.put(BranchController(), permanent: true);
    Get.lazyPut(() => PermissionRepository(), fenix: true);
    Get.put(PermissionService(), permanent: true);
    Get.put(FinancialYearController(), permanent: true);
    Get.lazyPut(() => SettingsRepository(), fenix: true);

    // Global UI Controllers (needed for AppBar)
    Get.lazyPut(() => UserProfileController(), fenix: true);
    Get.lazyPut(() => AnnouncementController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}
