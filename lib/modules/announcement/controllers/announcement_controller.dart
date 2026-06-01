import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/data/model/announcement/announcement_model.dart';
import 'package:ai_setu/data/repositories/announcement/announcement_repository.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class AnnouncementController extends GetxController {
  final AnnouncementRepository _repository = AnnouncementRepository();

  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt announcementCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();
    // Watch for branch changes
    ever(BranchController.to.selectedBranch, (branch) {
      if (branch == null) return;
      fetchAnnouncements();
    });
  }

  Future<void> fetchAnnouncements() async {
    try {
      isLoading.value = true;
      final data = await _repository.getAnnouncements(
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      announcements.assignAll(data.announcementData);
      announcementCount.value = data.totalData;
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void refreshAnnouncements() => fetchAnnouncements();
}
