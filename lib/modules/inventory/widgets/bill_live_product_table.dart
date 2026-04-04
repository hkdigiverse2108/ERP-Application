import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BillLiveProductTable extends StatelessWidget {
  BillLiveProductTable({super.key});
  final HomeController homeController = Get.put(HomeController());

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
              CommonTable<BillLiveProductModel>(
                items: [
                  BillLiveProductModel(
                    billofliveProductNo: '1',
                    billofliveProductDate: '2022-01-01',
                    action: 'Action',
                  ),
                  BillLiveProductModel(
                    billofliveProductNo: '2',
                    billofliveProductDate: '2022-01-02',
                    action: 'Action',
                  ),
                  BillLiveProductModel(
                    billofliveProductNo: '3',
                    billofliveProductDate: '2022-01-03',
                    action: 'Action',
                  ),
                  BillLiveProductModel(
                    billofliveProductNo: '4',
                    billofliveProductDate: '2022-01-04',
                    action: 'Action',
                  ),
                  BillLiveProductModel(
                    billofliveProductNo: '5',
                    billofliveProductDate: '2022-01-05',
                    action: 'Action',
                  ),
                  BillLiveProductModel(
                    billofliveProductNo: '6',
                    billofliveProductDate: '2022-01-06',
                    action: 'Action',
                  ),
                  BillLiveProductModel(
                    billofliveProductNo: '7',
                    billofliveProductDate: '2022-01-07',
                    action: 'Action',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Bill of Live Product No',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.billofliveProductNo,
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
                    title: 'Bill of Live Product Date',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.billofliveProductDate,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Action',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.action,
                      textAlign: TextAlign.right,
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
