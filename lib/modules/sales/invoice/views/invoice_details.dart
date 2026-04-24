import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/invoice_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InvoiceDetails extends StatelessWidget {
  const InvoiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoiceModel invoice = Get.arguments;
    final dateStr = DateFormat(
      'dd MMM yyyy',
    ).format(invoice.date ?? DateTime.now());
    final dueDateStr = DateFormat(
      'dd MMM yyyy',
    ).format(invoice.dueDate ?? DateTime.now());

    return DetailsView(
      title: 'Invoice #${invoice.invoiceNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.fileText,
      status: invoice.paymentStatus ?? 'Pending',
      statusColor: _getStatusColor(context, invoice.paymentStatus),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapInvoice(invoice);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapInvoice(invoice);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        // DetailAction(
        //   label: 'Payment',
        //   icon: PhosphorIconsFill.currencyInr,
        //   color: Colors.green,
        //   onTap: () {
        //     // Record payment logic
        //   },
        // ),
      ],
      sections: [
        DetailSection(
          title: 'Invoice Details',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Customer',
                  value:
                      '${invoice.customerId?.firstName} ${invoice.customerId?.lastName}',
                ),
                DetailItem(
                  label: 'Place of Supply',
                  value: invoice.placeOfSupply ?? '-',
                ),
                DetailItem(label: 'Due Date', value: dueDateStr),
                DetailItem(
                  label: 'Reverse Charge',
                  value: invoice.reverseCharge ? 'Yes' : 'No',
                ),
                DetailItem(label: 'Tax Type', value: invoice.taxType ?? '-'),
                DetailItem(
                  label: 'Payment Terms',
                  value: invoice.paymentTerms ?? '-',
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Items',
          children: [_buildItemsTable(context, invoice.items)],
        ),
        DetailSection(
          title: 'Summary',
          children: [
            _buildSummaryRow(
              'Gross Amount',
              invoice.transactionSummary?.grossAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Discount',
              -(invoice.transactionSummary?.discountAmount ?? 0),
              context: context,
            ),
            _buildSummaryRow(
              'Taxable Amount',
              invoice.transactionSummary?.taxableAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Tax Amount',
              invoice.transactionSummary?.taxAmount ?? 0,
              context: context,
            ),
            if (invoice.additionalCharges.isNotEmpty)
              _buildSummaryRow(
                'Additional Charges',
                invoice.additionalCharges.fold(
                  0.0,
                  (sum, item) => sum + item.totalAmount,
                ),
                context: context,
              ),
            _buildSummaryRow(
              'Round Off',
              invoice.transactionSummary?.roundOff ?? 0,
              context: context,
            ),
            const Divider(height: 32),
            _buildSummaryRow(
              'Net Amount',
              invoice.transactionSummary?.netAmount ?? 0,
              isTotal: true,
              context: context,
            ),
            _buildSummaryRow(
              'Paid Amount',
              invoice.paidAmount,
              color: AppColors.success,
              context: context,
            ),
            _buildSummaryRow(
              'Balance Amount',
              invoice.balanceAmount,
              color: AppColors.error,
              isBold: true,
              context: context,
            ),
          ],
        ),
        DetailSection(
          title: 'Address Information',
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (invoice.billingAddress != null)
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
                        _buildAddressText(invoice.billingAddress!),
                      ],
                    ),
                  ),
                if (invoice.shippingAddress != null) ...[
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
                        _buildAddressText(invoice.shippingAddress!),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(BuildContext context, String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
        return AppColors.success;
      case 'partially_paid':
      case 'partial':
        return Colors.orange;
      case 'pending':
      case 'unpaid':
      case 'due':
        return AppColors.error;
      default:
        return context.appColors.primary;
    }
  }

  Widget _buildItemsTable(BuildContext context, List<InvoiceItem> items) {
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
          DataColumn(label: Text('Tax (%)'), numeric: true),
          DataColumn(label: Text('Total'), numeric: true),
        ],
        rows: items.map((item) {
          return DataRow(
            cells: [
              DataCell(
                Text(item.productId?.name ?? '-', style: TextHelper.bodySmall),
              ),
              DataCell(
                Text(
                  '${item.qty} ${item.unit ?? ""}',
                  style: TextHelper.bodySmall,
                ),
              ),
              DataCell(Text('₹${item.price}', style: TextHelper.bodySmall)),
              DataCell(
                Text(
                  '${item.taxId?.percentage ?? 0}%',
                  style: TextHelper.bodySmall,
                ),
              ),
              DataCell(
                Text(
                  '₹${item.totalAmount}',
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

  Widget _buildAddressText(InvoiceAddress addr) {
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
