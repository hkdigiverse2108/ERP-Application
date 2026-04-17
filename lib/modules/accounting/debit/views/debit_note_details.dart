import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/accounting/debit_note_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DebitNoteDetails extends StatelessWidget {
  const DebitNoteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final DebitNoteModel note = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(note.date);

    return DetailsView(
      title: 'Debit Note #${note.voucherNumber}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.fileArrowDown,
      status: note.isActive ? 'Active' : 'Inactive',
      statusColor: note.isActive ? Colors.green : Colors.grey,
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapAccountingDebitNote(note);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapAccountingDebitNote(note);
            await PdfService.generateAndShare(pdfData);
          },
        ),
      ],
      sections: [
        DetailSection(
          title: 'Transaction Details',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Person Name', value: note.personName),
                DetailItem(
                  label: 'Phone',
                  value: '${note.phoneNo.countryCode} ${note.phoneNo.phoneNo}',
                ),
                DetailItem(label: 'Account', value: note.bankAccountId.name),
                DetailItem(
                  label: 'Amount',
                  value: '₹${note.amount.toStringAsFixed(2)}',
                  color: Colors.red,
                ),
                DetailItem(label: 'Type', value: note.type),
              ],
            ),
          ],
        ),
        if (note.description.isNotEmpty)
          DetailSection(
            title: 'Description',
            children: [
              Text(
                note.description,
                style: TextHelper.bodyMediumStyle(context),
              ),
            ],
          ),
        DetailSection(
          title: 'System Information',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Created By', value: note.createdBy.fullName),
                DetailItem(
                  label: 'Created At',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(note.createdAt),
                ),
                DetailItem(
                  label: 'Last Updated',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(note.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
