import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/bank_cash/bank_model.dart';
import 'package:ai_setu/modules/bank_cash/bank/controllers/bank_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankTable extends StatelessWidget {
  BankTable({super.key});

  final controller = BankController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        context.isDarkMode;
        if (controller.isLodding.value && controller.banks.isEmpty) {
          return const TableShimmer();
        }

        return BorderContainer(
          child: Column(
            children: [
              CommonTable<BankModel>(
                isLoading: controller.isLodding.value,
                items: controller.banks,
                columns: [
                  TableColumn(
                    title: 'Bank Name',
                    width: 160,
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
                    title: 'Account Holder',
                    width: 200,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.accountHolderName,
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Account Number',
                    width: 160,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.bankAccountNumber,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'IFSC Code',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.ifscCode, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Balance',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.openingBalance.creditBalance}',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Address',
                    width: 250,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "${item.addressLine1} ${item.addressLine2}".trim(),
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy?.fullName ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                onEditItem: (item) {
                  Get.toNamed(Routes.addUpdateBank, arguments: item);
                },
                onRowTap: (item) =>
                    Get.toNamed(Routes.bankDetails, arguments: item),
                onPageChanged: (page) => controller.goToPage(page),
                pageSize: controller.limit.value,
              ),
            ],
          ),
        );
      }),
    );
  }
}
