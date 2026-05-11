import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/pos/sales_register_model.dart';
import 'package:ai_setu/modules/pos/sales_register/controllers/sales_register_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesRegisterTable extends StatelessWidget {
  const SalesRegisterTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SalesRegisterController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.salesRegisters.isEmpty) {
          return const TableShimmer();
        }

        final items = controller.salesRegisters;
        if (items.isEmpty && !controller.isLoading.value) {
          return BorderContainer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(Sizes.paddingL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    const Gap(12),
                    Text(
                      "No Sales Registers Found",
                      style: TextHelper.bodyMedium.copyWith(color: Colors.grey),
                    ),
                    const Gap(16),
                    TextButton.icon(
                      onPressed: () => controller.getSalesRegisterData(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) => controller.updateDateRange(range),
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<SalesRegisterModel>(
                isLoading: controller.isLoading.value,
                items: controller.salesRegisters,
                route: Routes.posSalesRegister,
                columns: [
                  TableColumn(
                    title: 'Sales Man',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.salesManId?.fullName ?? "-",
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'From Date',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.createdAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'To Date',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.updatedAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.status,
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 110,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.createdAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                pageSize: controller.limit.value,
                onRowTap: (item) => Get.toNamed(
                  Routes.posSalesRegisterDetails,
                  arguments: item,
                ),
                onPageChanged: (page) => controller.goToPage(page),
              ),
            ],
          ),
        );
      }),
    );
  }
}
