import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:ai_setu/data/repositories/branch_repository.dart';
import 'package:get/get.dart';
import 'dart:developer';

class BranchController extends GetxController {
  static BranchController get to => Get.find();

  final _branchRepo = BranchRepository();
  final _storage = StorageService.instance;

  final availableBranches = <BranchDropdownModel>[].obs;
  final selectedBranch = Rxn<BranchDropdownModel>();
  final isLoading = false.obs;
  final _isMainBranch = false.obs;

  bool get isMainBranch => _isMainBranch.value;

  @override
  void onInit() {
    super.onInit();
    _isMainBranch.value = _storage.read<bool>(StorageKeys.isMainBranch) ?? false;
    if (isMainBranch) {
      fetchBranches();
    } else {
      // If employee, they might not need to fetch all branches,
      // but we should still set their current branch if possible.
      _loadSavedBranch();
    }
  }

  Future<void> fetchBranches() async {
    try {
      isLoading.value = true;
      final branches = await _branchRepo.getBranchesDropdown();
      availableBranches.assignAll(branches);

      _loadSavedBranch();
    } catch (e) {
      log("Error fetching branches: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _loadSavedBranch() {
    final savedId = _storage.read<String>('selected_branch_id');
    if (savedId != null && availableBranches.isNotEmpty) {
      selectedBranch.value = availableBranches.firstWhereOrNull(
        (b) => b.id == savedId,
      );
    }

    // Default to first if none saved or not found
    if (selectedBranch.value == null && availableBranches.isNotEmpty) {
      selectedBranch.value = availableBranches.first;
    }
  }

  void selectBranch(BranchDropdownModel? branch) {
    selectedBranch.value = branch;
    if (branch != null) {
      _storage.write('selected_branch_id', branch.id);
    } else {
      _storage.remove('selected_branch_id');
    }

    // Trigger data refresh across the app if needed
    // You might want to use an event bus or simply refresh the current controller
    _refreshCurrentData();
  }

  void _refreshCurrentData() {
    // Logic to refresh data in the current view
    // This could be a callback or a global event
  }
}
