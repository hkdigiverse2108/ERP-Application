import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
import 'package:ai_setu/modules/bank_cash/controllers/bank_cash_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentTable extends StatelessWidget {
  PaymentTable({super.key});

  final bankCashController = Get.find<BankCashController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (bankCashController.isLoading.value &&
            bankCashController.paymentTermsList.isEmpty) {
          return const TableShimmer();
        }

        final items = bankCashController.paymentTermsList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: bankCashController.selectedDateRange.value,
                onChanged: (range) {
                  bankCashController.selectedDateRange.value = range;
                  bankCashController.currentPage.value = 1; // Reset page
                  bankCashController.fetchPaymentTerms();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<PosPaymentDatum>(
                items: items,
                columns: [
                  TableColumn(
                    title: 'Payment No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.paymentNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Party Name',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) {
                      final party = item.partyId;
                      if (party == null) return const Text("-");
                      return Text(
                        "${party.firstName} ${party.lastName}",
                        style: TextHelper.bodySmall,
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.createdAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Mode',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      paymentModeValues.reverse[item.paymentMode] ?? "-",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Type',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      paymentTypeValues.reverse[item.paymentType] ?? "-",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.amount.toStringAsFixed(2)}',
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      statusValues.reverse[item.status] ?? "-",
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
                  bankCashController.fetchPaymentTerms();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
