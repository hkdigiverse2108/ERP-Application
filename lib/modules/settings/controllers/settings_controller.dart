import 'package:ai_setu/data/model/settings_model.dart';
import 'package:ai_setu/data/repositories/settings/settings_repository.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final SettingsRepository _repository = Get.find<SettingsRepository>();

  final Rxn<SettingsModel> settings = Rxn<SettingsModel>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSettings();
  }

  Future<void> fetchSettings() async {
    try {
      isLoading.value = true;
      final result = await _repository.getAllSettings();
      settings.value = result;
    } catch (e) {
      Get.log("Error fetching settings: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
