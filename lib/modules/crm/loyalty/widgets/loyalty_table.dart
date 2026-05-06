import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/crm/loyalty_model.dart';
import 'package:ai_setu/modules/crm/loyalty/controllers/loyalty_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoyaltyTable extends StatelessWidget {
  const LoyaltyTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoyaltyController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.loyaltyList.isEmpty) {
          return const TableShimmer();
        }

        final items = controller.loyaltyList;
        if (items.isEmpty && !controller.isLoading.value) {
          return BorderContainer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(Sizes.paddingL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.loyalty_outlined,
                      size: 64,
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    const Gap(12),
                    Text(
                      "No Loyalty Programs Found",
                      style: TextHelper.bodyMedium.copyWith(color: Colors.grey),
                    ),
                    const Gap(16),
                    TextButton.icon(
                      onPressed: () => controller.getLoyaltyData(),
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
              CommonTable<LoyaltyModel>(
                isLoading: controller.isLoading.value,
                items: controller.loyaltyList.toList(),
                columns: [
                  TableColumn(
                    title: 'Name',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.name,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Points',
                    width: 110,
                    cellBuilder: (context, item, index) => Text(
                      "${item.redemptionPoints} pts",
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Value',
                    width: 110,
                    cellBuilder: (context, item, index) => Text(
                      "${item.discountValue} (${item.typeDisplayName})",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Usage',
                    width: 110,
                    cellBuilder: (context, item, index) => Text(
                      "${item.usedCount} / ${item.usageLimit}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 110,
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
                        item.isActive ? 'ACTIVE' : 'INACTIVE',
                        style: TextHelper.bodySmall.copyWith(
                          color: item.isActive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Expiry',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.campaignExpiryDate),
                      style: TextHelper.bodySmall.copyWith(
                        color: item.campaignExpiryDate.isBefore(DateTime.now())
                            ? Colors.red
                            : null,
                      ),
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                pageSize: controller.limit.value,
                onPageChanged: (page) => controller.goToPage(page),
                onRowTap: (item) => Get.toNamed(Routes.loyaltyDetails, arguments: item),
                onEditItem: (item) async {
                  final res = await Get.toNamed(
                    Routes.addUpdateLoyalty,
                    arguments: item,
                  );
                  if (res == true) controller.getLoyaltyData();
                },
                onRemoveItem: (item) => controller.deleteLoyalty(item.id),
              ),
            ],
          ),
        );
      }),
    );
  }
}
