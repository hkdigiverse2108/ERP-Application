import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/bank_cash/bank_model.dart';
import 'package:ai_setu/modules/bank_cash/controllers/bank_cash_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BankTable extends StatelessWidget {
  BankTable({super.key});

  final bankCashController = Get.find<BankCashController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (bankCashController.isLoading.value &&
            bankCashController.bankCashList.isEmpty) {
          return const TableShimmer();
        }
        ThemeService().isDarkMode;
        final items = bankCashController.bankCashList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: bankCashController.selectedDateRange.value,
                onChanged: (range) {
                  bankCashController.selectedDateRange.value = range;
                  bankCashController.currentPage.value = 1; // Reset page
                  bankCashController.bankCashList;
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<BankDatum>(
                items: items
                    .skip((bankCashController.currentPage.value - 1) * 5)
                    .take(5)
                    .toList(),
                columns: [
                  TableColumn(
                    title: 'Bank Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
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
                    title: 'Account Holder Name',
                    width: 200,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.accountHolderName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'IFSC Code',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.ifscCode, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Balance',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "${item.openingBalance?.creditBalance ?? 0}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Account Number',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.bankAccountNumber,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Address',
                    width: 250,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Row(
                      children: [
                        Text(
                          item.addressLine1 ?? '',
                          style: TextHelper.bodySmall,
                        ),
                        Text(
                          item.addressLine2 ?? '',
                          style: TextHelper.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  TableColumn(
                    title: 'Created By',
                    width: 200,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName ?? '',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: bankCashController.currentPage.value,
                totalPages: (items.length / 5).ceil(),
                totalItems: items.length,
                pageSize: 5,
                onPageChanged: (page) =>
                    bankCashController.currentPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
