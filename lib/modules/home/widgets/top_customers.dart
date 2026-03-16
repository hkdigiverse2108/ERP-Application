import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/customers_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class TopCustomers extends StatelessWidget {
  TopCustomers({super.key});

  final homeController = Get.find<HomeController>();

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
              CommonTable<CustomersModel>(
                items: [
                  CustomersModel(
                    customerName: 'Jhone',
                    noofBill: '10',
                    salesValue: '1000',
                  ),
                  CustomersModel(
                    customerName: 'Jhone',
                    noofBill: '10',
                    salesValue: '1000',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Customer Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.customerName ?? '',
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
                    cellBuilder: (context, item, index) =>
                        Text(item.noofBill ?? '', style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Sales Value',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.salesValue ?? '',
                      style: TextHelper.bodySmall,
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
