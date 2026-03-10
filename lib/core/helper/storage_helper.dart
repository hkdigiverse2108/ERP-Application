import 'package:ai_setu/core/services/storage_service.dart';

class StorageHelper {
  String? get token => StorageService().read(StorageKeys.accessToken);

  set token(String? value) =>
      StorageService().write(StorageKeys.accessToken, value);

  Future<void> saveUser() async {}
}
