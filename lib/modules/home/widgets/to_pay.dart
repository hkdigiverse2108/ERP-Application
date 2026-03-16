import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/payable_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class ToPay extends StatelessWidget {
  ToPay({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: homeController.selectedDateRange.value,
                onChanged: (range) =>
                    homeController.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<PayableModel>(
                items: [
                  PayableModel(
                    vendorName: 'Electronics',
                    date: '2022-01-01',
                    noOfBills: '1234567890',
                    pendingAmount: '2500',
                  ),
                  PayableModel(
                    vendorName: 'Clothing',
                    date: '2022-01-01',
                    noOfBills: '1234567890',
                    pendingAmount: '2500',
                  ),
                  PayableModel(
                    vendorName: 'Books',
                    date: '2022-01-01',
                    noOfBills: '1234567890',
                    pendingAmount: '2500',
                  ),
                  PayableModel(
                    vendorName: 'Toys',
                    date: '2022-01-01',
                    noOfBills: '1234567890',
                    pendingAmount: '2500',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Supplier Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.vendorName ?? '',
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
                    title: 'Date',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.date ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Bill No',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.noOfBills ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Pending Amount',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.pendingAmount}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                currentPage: homeController.currentPage.value,
                totalPages: 5,
                totalItems: 43,
                onPageChanged: (page) =>
                    homeController.currentPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
