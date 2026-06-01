import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:ai_setu/data/repositories/settings/branch_repository.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:convert';

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
    _isMainBranch.value =
        _storage.read<bool>(StorageKeys.isMainBranch) ?? false;
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

  Future<void> onUserLogin() async {
    _isMainBranch.value =
        _storage.read<bool>(StorageKeys.isMainBranch) ?? false;
    if (isMainBranch) {
      await fetchBranches();
    } else {
      availableBranches.clear();
      _loadSavedBranch();
    }
  }

  void clearData() {
    availableBranches.clear();
    selectedBranch.value = null;
    _isMainBranch.value = false;
    _storage.remove(StorageKeys.isMainBranch);
    _storage.remove('selected_branch_id');
  }

  void _loadSavedBranch() {
    if (isMainBranch) {
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
    } else {
      // Non-main branch user: they only have access to their assigned branch.
      final rawData = _storage.read(StorageKeys.userData);
      Map<String, dynamic>? userData;
      if (rawData is Map) {
        userData = Map<String, dynamic>.from(rawData);
      } else if (rawData is String && rawData.isNotEmpty) {
        try {
          userData = Map<String, dynamic>.from(jsonDecode(rawData) as Map);
        } catch (_) {}
      }
      final branchData = userData?['branchId'];
      if (branchData != null) {
        final branchId = branchData['_id'] ?? branchData['id'];
        final branchName = branchData['name'];
        if (branchId != null) {
          final branch = BranchDropdownModel(
            id: branchId,
            name: branchName ?? '',
          );
          availableBranches.assignAll([branch]);
          selectedBranch.value = branch;
          return;
        }
      }
      availableBranches.clear();
      selectedBranch.value = null;
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
