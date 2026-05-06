import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/repositories/settings/role_repository.dart';
import 'package:ai_setu/modules/settings/user_roles/controllers/user_roles_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class UserRoleAddEditController extends GetxController {
  final _repo = RoleRepository();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final RxBool isActive = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final String? roleId = Get.arguments?['roleId'];
  final bool isEdit = Get.arguments?['isEdit'] ?? false;

  @override
  void onInit() {
    super.onInit();
    if (isEdit && roleId != null) {
      _fetchRoleById(roleId!);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  Future<void> _fetchRoleById(String id) async {
    try {
      isLoading.value = true;
      final role = await _repo.getRoleById(id);
      nameController.text = role.name;
      isActive.value = role.isActive;
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setIsActive(bool value) => isActive.value = value;

  Future<void> saveRole() async {
    if (!formKey.currentState!.validate()) return;

    if (isEdit) {
      await updateRole();
    } else {
      await createRole();
    }
  }

  Future<void> createRole() async {
    final Map<String, dynamic> data = {
      'name': nameController.text,
      'isActive': isActive.value,
    };

    try {
      isSaving.value = true;
      await _repo.createRole(data);
      _refreshAndBack();
      AppSnackbar.success("Role created successfully");
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateRole() async {
    if (roleId == null) return;
    final Map<String, dynamic> data = {
      'roleId': roleId,
      'name': nameController.text,
      'isActive': isActive.value,
    };

    try {
      isSaving.value = true;
      await _repo.updateRole(data);
      _refreshAndBack();
      AppSnackbar.success("Role updated successfully");
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (Get.isRegistered<UserRolesController>()) {
      UserRolesController.instance.refreshData();
    }
    Get.back();
  }
}
