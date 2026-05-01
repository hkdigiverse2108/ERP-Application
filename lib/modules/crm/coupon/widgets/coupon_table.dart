import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/crm/coupon_model.dart';
import 'package:ai_setu/modules/crm/coupon/controllers/coupon_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CouponTable extends StatelessWidget {
  const CouponTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CouponController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.couponList.isEmpty) {
          return const TableShimmer();
        }

        // final items = controller.couponList;
        // if (items.isEmpty && !controller.isLoading.value) {
        //   return BorderContainer(
        //     child: Center(
        //       child: Padding(
        //         padding: EdgeInsets.all(Sizes.paddingL),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Icon(
        //               Icons.confirmation_number_outlined,
        //               size: 64,
        //               color: Colors.grey.withValues(alpha: 0.5),
        //             ),
        //             const Gap(12),
        //             Text(
        //               "No Coupons Found",
        //               style: TextHelper.bodyMedium.copyWith(color: Colors.grey),
        //             ),
        //             const Gap(16),
        //             TextButton.icon(
        //               onPressed: () => controller.getCouponData(),
        //               icon: const Icon(Icons.refresh),
        //               label: const Text("Retry"),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   );
        // }

        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) => controller.updateDateRange(range),
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<CouponModel>(
                isLoading: controller.isLoading.value,
                items: controller.couponList.toList(),
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
                    title: 'Value',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      "${item.redeemValue} (${item.redemptionType})",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Usage',
                    width: 110,
                    cellBuilder: (context, item, index) => Text(
                      "${item.usedCount} / ${item.usageLimit ?? '∞'}",
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
                        color:
                            (item.status == 'active'
                                    ? Colors.green
                                    : Colors.red)
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status.toUpperCase(),
                        style: TextHelper.bodySmall.copyWith(
                          color: item.status == 'active'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Created At',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.createdAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy?.fullName ?? "N/A",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                pageSize: controller.limit.value,
                onPageChanged: (page) => controller.goToPage(page),
                onRowTap: (item) =>
                    Get.toNamed(Routes.couponDetails, arguments: item),
                onEditItem: (item) async {
                  final res = await Get.toNamed(
                    Routes.addUpdateCoupon,
                    arguments: item,
                  );
                  if (res == true) controller.getCouponData();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
