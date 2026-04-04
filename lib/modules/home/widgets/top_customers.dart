import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/dashboard/top_customer_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TopCustomers extends StatelessWidget {
  TopCustomers({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (homeController.topCustomersLoading.value &&
            homeController.topCustomers.isEmpty) {
          return const TableShimmer();
        }
        ThemeService().isDarkMode;
        final items = homeController.topCustomers;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: homeController.selectedDateRange.value,
                onChanged: (range) {
                  homeController.selectedDateRange.value = range;
                  homeController.topCustomersPage.value = 1; // Reset page
                  homeController.getTopCustomers();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<TopCustomerModel>(
                items: items
                    .skip((homeController.topCustomersPage.value - 1) * 5)
                    .take(5)
                    .toList(),
                columns: [
                  TableColumn(
                    title: 'Customer Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.customerId.name,
                          style: TextHelper.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  TableColumn(
                    title: 'No of Bill',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.noOfBill.toString(),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sales Value',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.salesValue.toStringAsFixed(2)}',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: homeController.topCustomersPage.value,
                totalPages: (items.length / 5).ceil(),
                totalItems: items.length,
                pageSize: 5,
                onPageChanged: (page) =>
                    homeController.topCustomersPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
