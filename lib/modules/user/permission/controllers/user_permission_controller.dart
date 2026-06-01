import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/permission_model.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/user/permission_repository.dart';
import 'package:get/get.dart';

class UserPermissionController extends GetxController {
  final _repo = PermissionRepository();
  
  final RxList<PermissionModel> permissions = <PermissionModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxString searchQuery = "".obs;
  
  UserModel? user;

  List<PermissionModel> get filteredPermissions {
    if (searchQuery.isEmpty) return permissions;
    return permissions.where((p) {
      final query = searchQuery.toLowerCase();
      return p.displayName.toLowerCase().contains(query) ||
             p.tabName.toLowerCase().contains(query) ||
             p.parentName.toLowerCase().contains(query);
    }).toList();
  }

  Map<String, List<PermissionModel>> get groupedPermissions {
    final Map<String, List<PermissionModel>> groups = {};
    for (var p in filteredPermissions) {
      final key = p.parentName.isEmpty ? "General" : p.parentName;
      if (!groups.containsKey(key)) {
        groups[key] = [];
      }
      groups[key]!.add(p);
    }
    return groups;
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is UserModel) {
      user = Get.arguments as UserModel;
      fetchPermissions();
    }
  }

  Future<void> fetchPermissions() async {
    if (user == null) return;
    try {
      isLoading.value = true;
      final result = await _repo.getPermissionsByUserId(user!.id);
      permissions.assignAll(result);
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void togglePermission(String id, String type, bool value) {
    final index = permissions.indexWhere((p) => p.id == id);
    if (index == -1) return;
    
    final permission = permissions[index];
    final updatedPermission = PermissionModel(
      id: permission.id,
      tabName: permission.tabName,
      displayName: permission.displayName,
      tabUrl: permission.tabUrl,
      view: type == 'view' ? value : permission.view,
      add: type == 'add' ? value : permission.add,
      edit: type == 'edit' ? value : permission.edit,
      delete: type == 'delete' ? value : permission.delete,
      number: permission.number,
      children: permission.children,
      parentName: permission.parentName,
    );
    
    permissions[index] = updatedPermission;
  }

  void toggleAll(String type, bool value) {
    for (int i = 0; i < permissions.length; i++) {
      final permission = permissions[i];
      permissions[i] = PermissionModel(
        id: permission.id,
        tabName: permission.tabName,
        displayName: permission.displayName,
        tabUrl: permission.tabUrl,
        view: type == 'view' ? value : permission.view,
        add: type == 'add' ? value : permission.add,
        edit: type == 'edit' ? value : permission.edit,
        delete: type == 'delete' ? value : permission.delete,
        number: permission.number,
        children: permission.children,
        parentName: permission.parentName,
      );
    }
  }

  Future<void> savePermissions() async {
    if (user == null) return;
    try {
      isSaving.value = true;
      await _repo.updatePermissions(user!.id, permissions);
      AppSnackbar.success("Permissions updated successfully");
      
      // Adding a small delay to ensure the user sees the success message before closing
      Future.delayed(const Duration(milliseconds: 500), () {
        if (Get.isRegistered<UserPermissionController>()) {
          Get.back();
        }
      });
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }
}
