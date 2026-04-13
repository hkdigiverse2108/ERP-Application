import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/prefix/prefix_model.dart';
import 'package:ai_setu/modules/settings/prefix/controllers/prefix_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrefixTable extends StatelessWidget {
  const PrefixTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PrefixController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.prefixes.isEmpty) {
          return const TableShimmer();
        }
        context.isDarkMode;
        return BorderContainer(
          child: CommonTable<PrefixModel>(
            isLoading: controller.isLoading.value,
            rowPadding: 5.0,
            items: controller.prefixes,
            currentPage: controller.currentPage.value,
            totalPages: controller.totalPages.value,
            totalItems: controller.totalItems.value,
            onPageChanged: (page) => controller.goToPage(page),
            onEditItem: (item) {
              Get.snackbar("Edit", "Edit Prefix for ${item.prefixType}");
            },
            columns: [
              TableColumn(
                title: "Module",
                width: 150,
                cellBuilder: (context, item, index) => Text(
                  item.prefixType.capitalizeFirst ?? item.prefixType,
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TableColumn(
                title: "Prefix",
                width: 120,
                cellBuilder: (context, item, index) =>
                    Text(item.prefix, style: TextHelper.bodyMedium),
              ),
              TableColumn(
                title: "Sequence",
                width: 100,
                cellBuilder: (context, item, index) => Text(
                  item.sequenceNumber.toString(),
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
