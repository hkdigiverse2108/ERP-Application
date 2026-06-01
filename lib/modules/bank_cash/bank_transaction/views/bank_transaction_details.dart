import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/bank_cash/bank_transaction_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BankTransactionDetails extends StatelessWidget {
  const BankTransactionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final BankTransactionModel transaction = Get.arguments;
    final dateStr = DateFormat(
      'dd MMM yyyy',
    ).format(transaction.transactionDate);

    return DetailsView(
      title: 'Transaction #${transaction.voucherNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.bank,
      status:
          transaction.transactionType.capitalizeFirst ??
          transaction.transactionType,
      statusColor: _getTypeColor(transaction.transactionType),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapBankTransaction(transaction);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapBankTransaction(transaction);
            await PdfService.generateAndShare(pdfData);
          },
        ),
      ],
      sections: [
        DetailSection(
          title: 'Transaction Breakdown',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Type',
                  value:
                      transaction.transactionType.capitalizeFirst ??
                      transaction.transactionType,
                ),
                DetailItem(
                  label: 'From Account',
                  value: transaction.fromAccount?.name ?? '-',
                ),
                DetailItem(
                  label: 'To Account',
                  value: transaction.toAccount?.name ?? '-',
                ),
                DetailItem(
                  label: 'Amount',
                  value: '₹${transaction.amount.toStringAsFixed(2)}',
                  color: context.appColors.primary,
                ),
              ],
            ),
          ],
        ),
        if (transaction.description.isNotEmpty)
          DetailSection(
            title: 'Description',
            children: [
              Text(
                transaction.description,
                style: TextHelper.bodyMediumStyle(context),
              ),
            ],
          ),
        DetailSection(
          title: 'System Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Created By',
                  value: transaction.createdBy?.fullName ?? '-',
                ),
                DetailItem(
                  label: 'Created At',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(transaction.createdAt),
                ),
                DetailItem(
                  label: 'Last Updated',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(transaction.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'deposit':
        return Colors.green;
      case 'withdraw':
        return Colors.red;
      case 'transfer':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }
}
