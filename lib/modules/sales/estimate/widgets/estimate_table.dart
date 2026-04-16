import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/modules/sales/estimate/controllers/estimate_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EstimateTable extends StatelessWidget {
  EstimateTable({super.key});

  final controller = EstimateController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        // Accessing isDarkMode to ensure Obx tracks theme changes
        context.isDarkMode;

        if (controller.isLodding.value && controller.estimates.isEmpty) {
          return const TableShimmer();
        }

        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) => controller.updateDateRange(range),
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<EstimateModel>(
                isLoading: controller.isLodding.value,
                items: controller.estimates,
                onRowTap: (item) =>
                    Get.toNamed(Routes.estimateDetails, arguments: item),
                columns: [
                  TableColumn(
                    title: 'Estimate No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.estimateNo ?? "",
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(item.date ?? DateTime.now()),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Due Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(item.dueDate ?? DateTime.now()),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Customer',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) {
                      final customer = item.customerId;
                      return Text(
                        "${customer?.firstName ?? ""} ${customer?.lastName ?? ""}",
                        style: TextHelper.bodySmall,
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) {
                      final netAmount =
                          item.transactionSummary?.netAmount ?? 0.0;
                      return Text(
                        '₹${netAmount.toStringAsFixed(2)}',
                        style: TextHelper.bodySmall.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status ?? "",
                        style: TextHelper.bodySmall.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy?.fullName ?? "",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                pageSize: controller.limit.value,
                onPageChanged: (page) => controller.goToPage(page),
              ),
            ],
          ),
        );
      }),
    );
  }
}
