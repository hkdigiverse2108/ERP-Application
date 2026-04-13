import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/repositories/permission_repository.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService.instance, permanent: true);
    Get.put(ApiService(), permanent: true);
    Get.lazyPut(() => PermissionRepository(), fenix: true);
    Get.put(PermissionService(), permanent: true);
  }
}
