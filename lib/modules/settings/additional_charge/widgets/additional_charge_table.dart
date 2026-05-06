import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/modules/settings/additional_charge/controllers/additional_charge_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdditionalChargeTable extends StatelessWidget {
  const AdditionalChargeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AdditionalChargeController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        context.isDarkMode;
        if (controller.isLoading.value && controller.charges.isEmpty) {
          return const TableShimmer();
        }

        return BorderContainer(
          child: CommonTable<AdditionalChargeModel>(
            isLoading: controller.isLoading.value,
            rowPadding: 5.0,
            items: controller.charges,
            currentPage: controller.currentPage.value,
            totalPages: controller.totalPages.value,
            totalItems: controller.totalItems.value,
            onPageChanged: (page) => controller.goToPage(page),
            onEditItem: (item) {
              Get.toNamed(
                Routes.settingsAdditionalChargeAddEdit,
                arguments: {'isEdit': true, 'chargeId': item.id},
              );
            },
            onRemoveItem: (item) => controller.deleteCharge(item.id),
            deleteTitle: "Delete Additional Charge",
            deleteMessage: (item) =>
                "Are you sure you want to delete '${item.name}'? This action cannot be undone.",
            // Note: Omitting delete button and authorization as per recent pattern in Prefix/PaymentTerms
            columns: [
              TableColumn(
                title: "Name",
                width: 180,
                cellBuilder: (context, item, index) => Text(
                  item.name,
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TableColumn(
                title: "Type",
                width: 100,
                cellBuilder: (context, item, index) => Text(
                  item.type.capitalizeFirst ?? item.type,
                  style: TextHelper.bodyMedium,
                ),
              ),
              TableColumn(
                title: "Value",
                width: 100,
                cellBuilder: (context, item, index) => Text(
                  item.defaultValue.toString(),
                  style: TextHelper.bodyMedium,
                ),
              ),
              TableColumn(
                title: "Tax",
                width: 150,
                cellBuilder: (context, item, index) =>
                    Text(item.taxId.name, style: TextHelper.bodySmall),
              ),
              TableColumn(
                title: "Tax Inc",
                width: 80,
                cellBuilder: (context, item, index) => Icon(
                  item.isTaxIncluding
                      ? Icons.check_circle
                      : Icons.cancel_outlined,
                  size: 18,
                  color: item.isTaxIncluding ? Colors.green : Colors.grey,
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
