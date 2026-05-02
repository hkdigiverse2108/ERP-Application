import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/modules/settings/taxes/controllers/taxes_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:intl/intl.dart';

class TaxTable extends StatelessWidget {
  const TaxTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TaxesController.instance;

    // Get current user role for authorization
    final userData = StorageService.instance.read<Map<String, dynamic>>(
      StorageKeys.userData,
    );
    final currentUserType = userData?['userType'] ?? 'admin';

    bool isAuthorized(TaxItemModel item) {
      // If item was created by super-admin, only super-admin can modify it
      if (item.createdBy?.userType == 'super-admin') {
        return currentUserType == 'super-admin';
      }
      return true;
    }

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.taxes.isEmpty) {
          return const TableShimmer();
        }
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) =>
                    controller.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<TaxItemModel>(
                isLoading: controller.isLoading.value,
                rowPadding: 5.0,
                items: controller.taxes,
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                onPageChanged: (page) => controller.goToPage(page),
                onEditItem: (item) {
                  AppSnackbar.info("Edit Tax: ${item.name}");
                },
                onRemoveItem: (item) {
                  AppSnackbar.warning("Delete Tax: ${item.name}");
                },
                canEdit: isAuthorized,
                canDelete: isAuthorized,
                columns: [
                  TableColumn(
                    title: "Name",
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.name,
                      style: TextHelper.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: "Percentage (%)",
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      "${item.percentage}%",
                      style: TextHelper.bodyMedium,
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
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      (item.createdBy?.userType == 'super-admin')
                          ? 'System Generated'
                          : item.createdBy?.fullName ?? 'System',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: "Created Date",
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.createdAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
