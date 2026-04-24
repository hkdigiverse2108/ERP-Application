import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/role/role_model.dart';
import 'package:ai_setu/modules/settings/user_roles/controllers/user_roles_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserRolesTable extends StatelessWidget {
  const UserRolesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserRolesController.instance;

    // Get current user role for authorization
    final userData = StorageService.instance.read<Map<String, dynamic>>(
      StorageKeys.userData,
    );
    final currentUserType = userData?['userType'] ?? 'admin';

    bool isAuthorized(RoleModel item) {
      if (item.createdBy?.userType == 'super-admin') {
        return currentUserType == 'super-admin';
      }
      return true;
    }

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.roles.isEmpty) {
          return const TableShimmer();
        }
        ThemeService().isDarkMode;
        return BorderContainer(
          child: CommonTable<RoleModel>(
            isLoading: controller.isLoading.value,
            rowPadding: 5.0,
            items: controller.roles,
            currentPage: controller.currentPage.value,
            totalPages: controller.totalPages.value,
            totalItems: controller.totalItems.value,
            onPageChanged: (page) => controller.goToPage(page),
            onEditItem: (item) {
              Get.snackbar("Edit", "Edit Role: ${item.name}");
            },
            onRemoveItem: (item) {
              Get.snackbar("Delete", "Delete Role: ${item.name}");
            },
            canEdit: isAuthorized,
            canDelete: isAuthorized,
            columns: [
              TableColumn(
                title: "Role Name",
                width: 200,
                cellBuilder: (context, item, index) => Text(
                  item.name,
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TableColumn(
                title: "Status",
                width: 100,
                cellBuilder: (context, item, index) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (item.isActive ? Colors.green : Colors.red)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.isActive ? "Active" : "Inactive",
                    style: TextHelper.bodySmall.copyWith(
                      color: item.isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TableColumn(
                title: "Created By",
                width: 180,
                cellBuilder: (context, item, index) => Text(
                  (item.createdBy?.userType == 'super-admin')
                      ? 'System Generated'
                      : item.createdBy?.fullName ?? 'Unknown',
                  style: TextHelper.bodySmall,
                ),
              ),
              TableColumn(
                title: "Created Date",
                width: 150,
                cellBuilder: (context, item, index) => Text(
                  DateFormat('dd MMM yyyy').format(item.createdAt),
                  style: TextHelper.bodySmall,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
