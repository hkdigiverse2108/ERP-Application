import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/material_consumption_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MaterialConsumptionTable extends StatelessWidget {
  MaterialConsumptionTable({super.key});

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
              CommonTable<MaterialConsumptionModel>(
                items: [
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                  MaterialConsumptionModel(
                    branch: 'Branch 1',
                    mcNo: 'MC001',
                    type: 'Type 1',
                    date: '2022-01-01',
                    totalqty: '10',
                    totalAmount: '100',
                    action: 'Edit',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Branch',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.branch ?? '',
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
                    title: 'MC No',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.mcNo ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Type',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.type ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.date ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Total Qty',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.totalqty ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Total Amount',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.totalAmount ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Remark',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.remark ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Action',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.action ?? '',
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
    ;
  }
}
