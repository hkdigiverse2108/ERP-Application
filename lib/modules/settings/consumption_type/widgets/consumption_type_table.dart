import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/consumption_type/consumption_type_model.dart';
import 'package:ai_setu/modules/settings/consumption_type/controllers/consumption_type_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConsumptionTypeTable extends StatelessWidget {
  const ConsumptionTypeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ConsumptionTypeController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        context.isDarkMode;
        if (controller.isLoading.value && controller.types.isEmpty) {
          return const TableShimmer();
        }

        return BorderContainer(
          child: CommonTable<ConsumptionTypeModel>(
            isLoading: controller.isLoading.value,
            rowPadding: 5.0,
            items: controller.types,
            currentPage: controller.currentPage.value,
            totalPages: controller.totalPages.value,
            totalItems: controller.totalItems.value,
            onPageChanged: (page) => controller.goToPage(page),
            onEditItem: (item) {
              Get.toNamed(
                Routes.settingsConsumptionTypeAddEdit,
                arguments: {'isEdit': true, 'consumptionTypeId': item.id},
              );
            },
            onRemoveItem: (item) => controller.deleteConsumptionType(item.id),
            deleteTitle: "Delete Consumption Type",
            deleteMessage: (item) =>
                "Are you sure you want to delete '${item.name}'? This action cannot be undone.",
            canEdit: (item) => !item.isSystemGenerated,
            canDelete: (item) => !item.isSystemGenerated,
            columns: [
              TableColumn(
                title: "Name",
                width: 250,
                cellBuilder: (context, item, index) => Text(
                  item.name,
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TableColumn(
                title: "System",
                width: 100,
                cellBuilder: (context, item, index) => item.isSystemGenerated
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Yes",
                          style: TextHelper.bodySmall.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Text(
                        "No",
                        style: TextHelper.bodySmall.copyWith(
                          color: Colors.grey,
                        ),
                      ),
              ),
              TableColumn(
                title: "Created By",
                width: 180,
                cellBuilder: (context, item, index) => Text(
                  item.isSystemGenerated ? "System" : item.createdBy.fullName,
                  style: TextHelper.bodySmall,
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
