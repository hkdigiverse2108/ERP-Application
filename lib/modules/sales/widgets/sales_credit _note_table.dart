import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/bank_cash/bank_transaction_model.dart';
import 'package:ai_setu/modules/bank_cash/controllers/bank_cash_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesCreditNoteTable extends StatelessWidget {
  SalesCreditNoteTable({super.key});

  final bankCashController = Get.find<BankCashController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (bankCashController.isLoading.value &&
            bankCashController.bankCashTransactionList.isEmpty) {
          return const TableShimmer();
        }

        final items = bankCashController.bankCashTransactionList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: bankCashController.selectedDateRange.value,
                onChanged: (range) {
                  bankCashController.selectedDateRange.value = range;
                  bankCashController.currentPage.value = 1;
                  bankCashController.fetchBankCashTransaction();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<BankTransactionModel>(
                items: items,
                columns: [
                  TableColumn(
                    title: 'Voucher No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.voucherNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Transaction Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(item.transactionDate ?? DateTime.now()),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Transaction Type',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.transactionType ?? "-",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'From Account',
                    width: 180,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.fromAccount?.name ?? "-",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'To Account',
                    width: 180,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.toAccount?.name ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.amount}",
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy?.fullName ?? "-",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: bankCashController.currentPage.value,
                totalPages: bankCashController.totalPages.value,
                totalItems: bankCashController.totalItems.value,
                pageSize: 10,
                onPageChanged: (page) {
                  bankCashController.currentPage.value = page;
                  bankCashController.fetchBankCashTransaction();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
