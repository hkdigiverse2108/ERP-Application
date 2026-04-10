import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/pos/credit_note_model.dart';
import 'package:ai_setu/modules/pos/credit_note/controllers/credit_note_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreditNoteTable extends StatelessWidget {
  const CreditNoteTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreditNoteController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.creditNotes.isEmpty) {
          return const TableShimmer();
        }

        final items = controller.creditNotes;
        if (items.isEmpty && !controller.isLoading.value) {
          return BorderContainer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(Sizes.paddingL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.money_off_outlined,
                      size: 64,
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    const Gap(12),
                    Text(
                      "No Credit Notes Found",
                      style: TextHelper.bodyMedium.copyWith(color: Colors.grey),
                    ),
                    const Gap(16),
                    TextButton.icon(
                      onPressed: () => controller.getCreditNoteData(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) => controller.updateDateRange(range),
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<CreditNoteModel>(
                isLoading: controller.isLoading.value,
                items: controller.creditNotes.toList(),
                columns: [
                  TableColumn(
                    title: 'Credit Note No.',
                    width: 160,
                    cellBuilder: (context, item, index) => Text(
                      item.creditNoteNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Customer Name',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      "${item.customerId.firstName} ${item.customerId.lastName}",
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Total Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.totalAmount.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Credits Used',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.creditsUsed.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Refunded Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${(item.refundedAmount ?? 0).toDouble().toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Credits Remaining',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.creditsRemaining.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 110,
                    cellBuilder: (context, item, index) =>
                        Text(item.status, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                pageSize: controller.limit.value,
                onPageChanged: (page) => controller.goToPage(page),
              ),
            ],
          ),
        );
      }),
    );
  }
}
