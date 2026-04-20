import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/purchase/supplier_bill_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SupplierBillDetails extends StatelessWidget {
  const SupplierBillDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final SupplierBillModel bill = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(bill.supplierBillDate);
    final dueDateStr = bill.dueDate != null
        ? DateFormat('dd MMM yyyy').format(bill.dueDate!)
        : '-';

    return DetailsView(
      title: 'Supplier Bill #${bill.supplierBillNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.receipt,
      status: bill.paymentStatus.isNotEmpty ? bill.paymentStatus : bill.status,
      statusColor: _getStatusColor(
        context,
        bill.paymentStatus.isNotEmpty ? bill.paymentStatus : bill.status,
      ),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapSupplierBill(bill);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapSupplierBill(bill);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        // if (bill.balanceAmount > 0)
        // DetailAction(
        //   label: 'Pay Now',
        //   icon: PhosphorIconsFill.creditCard,
        //   color: Colors.green,
        //   onTap: () {},
        // ),
      ],
      sections: [
        DetailSection(
          title: 'Bill Details',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Supplier',
                  value:
                      '${bill.supplierId.firstName} ${bill.supplierId.lastName}',
                ),
                DetailItem(
                  label: 'Reference No.',
                  value: bill.referenceBillNo.isNotEmpty
                      ? bill.referenceBillNo
                      : '-',
                ),
                DetailItem(
                  label: 'Place of Supply',
                  value: bill.placeOfSupply ?? '-',
                ),
                DetailItem(label: 'Due Date', value: dueDateStr),
                DetailItem(
                  label: 'Payment Status',
                  value: bill.paymentStatus.toUpperCase(),
                ),
                DetailItem(
                  label: 'Reverse Charge',
                  value: bill.reverseCharge ? 'Yes' : 'No',
                ),
              ],
            ),
          ],
        ),
        if (bill.productDetails != null &&
            bill.productDetails is List &&
            (bill.productDetails as List).isNotEmpty)
          DetailSection(
            title: 'Items',
            children: [_buildItemsTable(context, bill.productDetails as List)],
          ),
        DetailSection(
          title: 'Summary',
          children: [
            _buildSummaryRow(
              'Gross Amount',
              bill.summary.grossAmount,
              context: context,
            ),
            _buildSummaryRow(
              'Discount',
              -bill.summary.discountAmount.toDouble(),
              context: context,
            ),
            _buildSummaryRow(
              'Taxable Amount',
              bill.summary.taxableAmount,
              context: context,
            ),
            _buildSummaryRow(
              'Tax Amount',
              bill.summary.taxAmount,
              context: context,
            ),
            _buildSummaryRow(
              'Round Off',
              bill.summary.roundOff.toDouble(),
              context: context,
            ),
            const Divider(height: 32),
            _buildSummaryRow(
              'Net Amount',
              bill.summary.netAmount,
              isTotal: true,
              context: context,
            ),
            _buildSummaryRow(
              'Paid Amount',
              bill.paidAmount.toDouble(),
              color: AppColors.success,
              context: context,
            ),
            _buildSummaryRow(
              'Balance Amount',
              bill.balanceAmount.toDouble(),
              color: AppColors.error,
              isBold: true,
              context: context,
            ),
          ],
        ),
        if (bill.billingAddress != null)
          DetailSection(
            title: 'Billing Address',
            children: [_buildAddressText(bill.billingAddress!)],
          ),
        if (bill.notes != null && bill.notes!.isNotEmpty)
          DetailSection(
            title: 'Notes',
            children: [
              Text(
                bill.notes!,
                style: TextHelper.bodySmall.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'completed':
        return AppColors.success;
      case 'partially paid':
      case 'pending':
        return Colors.orange;
      case 'unpaid':
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
          DataColumn(label: Text('Cost'), numeric: true),
          DataColumn(label: Text('Total'), numeric: true),
        ],
        rows: items.map((item) {
          final name = item['productId'] != null
              ? (item['productId']['name'] ?? '-')
              : '-';
          final qty = item['qty'] ?? 0;
          final cost = item['unitCost'] ?? 0;
          final total = item['total'] ?? 0;

          return DataRow(
            cells: [
              DataCell(Text('$name', style: TextHelper.bodySmall)),
              DataCell(Text('$qty', style: TextHelper.bodySmall)),
              DataCell(Text('₹$cost', style: TextHelper.bodySmall)),
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

  Widget _buildAddressText(Address addr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(addr.addressLine1, style: TextHelper.bodySmall),
        if (addr.addressLine2.isNotEmpty)
          Text(addr.addressLine2, style: TextHelper.bodySmall),
        Text(
          '${addr.city.name}, ${addr.state?.name ?? ""}, ${addr.country.name} - ${addr.pinCode ?? ""}',
          style: TextHelper.bodySmall,
        ),
      ],
    );
  }
}
