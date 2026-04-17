import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SalesCreditNoteDetails extends StatelessWidget {
  const SalesCreditNoteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Credit Note Details')),
        body: const Center(child: Text('No data found')),
      );
    }
    final SalesCreditNoteModel note = Get.arguments;
    final dateStr = DateFormat(
      'dd MMM yyyy',
    ).format(note.creditNoteDate ?? DateTime.now());
    final dueDateStr = DateFormat(
      'dd MMM yyyy',
    ).format(note.dueDate ?? DateTime.now());

    return DetailsView(
      title: 'Credit Note #${note.creditNoteNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.arrowCounterClockwise,
      status: note.status ?? 'Pending',
      statusColor: _getStatusColor(context, note.status),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapSalesCreditNote(note);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapSalesCreditNote(note);
            await PdfService.generateAndShare(pdfData);
          },
        ),
      ],
      sections: [
        DetailSection(
          title: 'Note Details',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Customer',
                  value: note.customerId != null
                      ? '${note.customerId?.firstName ?? ""} ${note.customerId?.lastName ?? ""}'
                      : '-',
                ),
                DetailItem(label: 'Reason', value: note.reason ?? '-'),
                DetailItem(
                  label: 'Place of Supply',
                  value: note.placeOfSupply ?? '-',
                ),
                DetailItem(label: 'Due Date', value: dueDateStr),
                DetailItem(
                  label: 'Reverse Charge',
                  value: note.reverseCharge ? 'Yes' : 'No',
                ),
              ],
            ),
          ],
        ),
        if (note.productDetails != null &&
            note.productDetails is List &&
            (note.productDetails as List).isNotEmpty)
          DetailSection(
            title: 'Items',
            children: [_buildItemsTable(context, note.productDetails as List)],
          ),
        DetailSection(
          title: 'Summary',
          children: [
            _buildSummaryRow(
              'Gross Amount',
              note.summary?.grossAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Discount',
              -(note.summary?.discountAmount ?? 0),
              context: context,
            ),
            _buildSummaryRow(
              'Taxable Amount',
              note.summary?.taxableAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Tax Amount',
              note.summary?.taxAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Round Off',
              note.summary?.roundOff ?? 0,
              context: context,
            ),
            const Divider(height: 32),
            _buildSummaryRow(
              'Net Amount',
              note.summary?.netAmount ?? 0,
              isTotal: true,
              context: context,
            ),
          ],
        ),
        if (note.billingAddress != null || note.shippingAddress != null)
          DetailSection(
            title: 'Address Information',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (note.billingAddress != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Billing Address',
                            style: TextHelper.caption.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          _buildAddressText(note.billingAddress!),
                        ],
                      ),
                    ),
                  if (note.shippingAddress != null) ...[
                    const Gap(24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Address',
                            style: TextHelper.caption.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          _buildAddressText(note.shippingAddress),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        if (note.notes != null && note.notes?.isNotEmpty == true)
          DetailSection(
            title: 'Notes',
            children: [
              Text(
                note.notes!,
                style: TextHelper.bodySmall.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Color _getStatusColor(BuildContext context, String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
      case 'active':
        return AppColors.success;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return AppColors.error;
      default:
        return context.appColors.primary;
    }
  }

  Widget _buildItemsTable(BuildContext context, List items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 40,
        horizontalMargin: 0,
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('Item')),
          DataColumn(label: Text('Qty'), numeric: true),
          DataColumn(label: Text('Price'), numeric: true),
          DataColumn(label: Text('Total'), numeric: true),
        ],
        rows: items.map((item) {
          // Handling dynamic productDetails items
          final name = item['productId'] != null
              ? (item['productId']['name'] ?? '-')
              : '-';
          final qty = item['qty'] ?? 0;
          final price = item['price'] ?? 0;
          final total = item['totalAmount'] ?? 0;

          return DataRow(
            cells: [
              DataCell(Text('$name', style: TextHelper.bodySmall)),
              DataCell(Text('$qty', style: TextHelper.bodySmall)),
              DataCell(Text('₹$price', style: TextHelper.bodySmall)),
              DataCell(
                Text(
                  '₹$total',
                  style: TextHelper.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isTotal = false,
    bool isBold = false,
    Color? color,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? TextHelper.bodyLarge.copyWith(fontWeight: FontWeight.bold)
                : TextHelper.bodyMedium.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: (isTotal || isBold)
                ? TextHelper.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        color ?? (isTotal ? context.appColors.primary : null),
                  )
                : TextHelper.bodyMedium.copyWith(
                    color: color,
                    fontWeight: isBold ? FontWeight.bold : null,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressText(Address? addr) {
    if (addr == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(addr.addressLine1, style: TextHelper.bodySmall),
        if (addr.addressLine2 != null)
          Text(addr.addressLine2!, style: TextHelper.bodySmall),
        Text(
          '${addr.city?.name}, ${addr.state?.name}, ${addr.country?.name} - ${addr.pinCode}',
          style: TextHelper.bodySmall,
        ),
      ],
    );
  }
}
