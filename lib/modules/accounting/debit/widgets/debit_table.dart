import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/accounting/debit_note_model.dart';
import 'package:ai_setu/modules/accounting/debit/controllers/debit_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DebitTable extends StatelessWidget {
  DebitTable({super.key});

  final controller = DebitController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLodding.value && controller.debitNotes.isEmpty) {
          return const TableShimmer();
        }

        return BorderContainer(
          child: Column(
            children: [
              CommonTable<DebitNoteModel>(
                isLoading: controller.isLodding.value,
                items: controller.debitNotes,
                columns: [
                  TableColumn(
                    title: 'Voucher No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.voucherNumber,
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
                      DateFormat('dd MMM yyyy').format(item.date),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Person Name',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.personName,
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Account',
                    width: 180,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.bankAccountId.name,
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.amount}',
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                onRowTap: (item) =>
                    Get.toNamed(Routes.debitDetails, arguments: item),
                onEditItem: (item) =>
                    Get.toNamed(Routes.addUpdateDebit, arguments: item),
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
