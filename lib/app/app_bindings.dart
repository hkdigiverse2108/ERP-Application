import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService.instance, permanent: true);
    Get.putAsync(() async => ApiService(), permanent: true);
  }
}
