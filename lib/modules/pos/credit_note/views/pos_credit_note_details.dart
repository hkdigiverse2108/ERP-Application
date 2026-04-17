import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/pos/credit_note_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class POSCreditNoteDetails extends StatelessWidget {
  const POSCreditNoteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CreditNoteModel note = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(note.createdAt);

    return DetailsView(
      title: 'Credit Note #${note.creditNoteNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.ticket,
      status: note.status.toUpperCase(),
      statusColor: _getStatusColor(note.status),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapPOSCreditNote(note);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapPOSCreditNote(note);
            await PdfService.generateAndShare(pdfData);
          },
        ),
      ],
      sections: [
        DetailSection(
          title: 'Customer Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Customer',
                  value:
                      '${note.customerId.firstName} ${note.customerId.lastName}',
                ),
                DetailItem(
                  label: 'Phone',
                  value:
                      '${note.customerId.phoneNo.countryCode} ${note.customerId.phoneNo.phoneNo}',
                ),
                DetailItem(
                  label: 'Order Reference',
                  value: note.returnPosOrderId.returnOrderNo,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Credit Summary',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Total Amount',
                  value: '₹${note.totalAmount.toStringAsFixed(2)}',
                  color: context.appColors.primary,
                ),
                DetailItem(
                  label: 'Credits Used',
                  value: '₹${note.creditsUsed.toStringAsFixed(2)}',
                  color: Colors.orange,
                ),
                DetailItem(
                  label: 'Credits Remaining',
                  value: '₹${note.creditsRemaining.toStringAsFixed(2)}',
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
        if (note.returnPosOrderId.items.isNotEmpty)
          DetailSection(
            title: 'Returned Items',
            children: [
              ...note.returnPosOrderId.items.map(
                (item) => _buildItemCard(item, context),
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
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'unused':
        return Colors.green;
      case 'partially_used':
        return Colors.blue;
      case 'fully_used':
        return Colors.grey;
      case 'refunded':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildItemCard(Item item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.appColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productId.name,
                  style: TextHelper.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'MRP: ₹${(item.mrp ?? 0).toStringAsFixed(2)}',
                  style: TextHelper.bodySmall.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Qty', style: TextHelper.captionStyle(context)),
              Text(
                '${item.returnedQty ?? item.qty ?? 0}',
                style: TextHelper.h4Style(
                  context,
                ).copyWith(color: context.appColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
