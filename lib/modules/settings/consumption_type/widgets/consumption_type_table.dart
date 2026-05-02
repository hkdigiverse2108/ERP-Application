import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/consumption_type/consumption_type_model.dart';
import 'package:ai_setu/modules/settings/consumption_type/controllers/consumption_type_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
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
              AppSnackbar.info("Edit Consumption Type: ${item.name}");
            },
            // Note: Omitting delete button and authorization as per recent pattern
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
                title: "Default",
                width: 100,
                cellBuilder: (context, item, index) => item.isDefault
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: Text(
                          "Default",
                          style: TextHelper.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
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
