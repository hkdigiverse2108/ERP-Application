import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PurchaseOrderDetails extends StatelessWidget {
  const PurchaseOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseOrderModel order = Get.arguments;
    final dateStr = order.orderDate != null ? DateFormat('dd MMM yyyy').format(order.orderDate!) : '-';
    final shippingDateStr = order.shippingDate != null ? DateFormat(
      'dd MMM yyyy',
    ).format(order.shippingDate!) : '-';

    return DetailsView(
      title: 'Purchase Order #${order.orderNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.shoppingCart,
      status: order.status ?? 'Pending',
      statusColor: _getStatusColor(context, order.status ?? 'Pending'),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapPurchaseOrder(order);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapPurchaseOrder(order);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        // DetailAction(
        //   label: 'Convert to Bill',
        //   icon: PhosphorIconsFill.receipt,
        //   color: Colors.blue,
        //   onTap: () {},
        // ),
      ],
      sections: [
        DetailSection(
          title: 'Order Details',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Supplier',
                  value: order.supplierId != null
                      ? '${order.supplierId?.firstName} ${order.supplierId?.lastName}'
                      : '-',
                ),
                DetailItem(
                  label: 'Company',
                  value: order.supplierId?.companyName ?? '-',
                ),
                DetailItem(
                  label: 'Place of Supply',
                  value: order.placeOfSupply ?? '-',
                ),
                DetailItem(label: 'Shipping Date', value: shippingDateStr),
                DetailItem(label: 'Tax Type', value: order.taxType ?? '-'),
                DetailItem(
                  label: 'Reverse Charge',
                  value: order.isActive
                      ? 'Yes'
                      : 'No', // Check model field if different
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Items',
          children: [_buildItemsTable(context, order.items)],
        ),
        DetailSection(
          title: 'Summary',
          children: [
            _buildSummaryRow(
              'Gross Amount',
              order.summary?.grossAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Discount',
              -(order.summary?.discountAmount ?? 0),
              context: context,
            ),
            _buildSummaryRow(
              'Taxable Amount',
              order.summary?.taxableAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Tax Amount',
              order.summary?.taxAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Round Off',
              order.summary?.roundOff ?? 0,
              context: context,
            ),
            const Divider(height: 32),
            _buildSummaryRow(
              'Net Amount',
              order.summary?.netAmount ?? 0,
              isTotal: true,
              context: context,
            ),
          ],
        ),
        if (order.billingAddress != null)
          DetailSection(
            title: 'Billing Address',
            children: [_buildAddressText(order.billingAddress!)],
          ),
        if (order.notes != null && order.notes!.isNotEmpty)
          DetailSection(
            title: 'Notes',
            children: [
              Text(
                order.notes!,
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
      case 'completed':
      case 'received':
        return AppColors.success;
      case 'pending':
      case 'ordered':
        return Colors.orange;
      case 'cancelled':
        return AppColors.error;
      default:
        return context.appColors.primary;
    }
  }

  Widget _buildItemsTable(BuildContext context, List<PurchaseOrderItem> items) {
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
          DataColumn(label: Text('Tax (%)'), numeric: true),
          DataColumn(label: Text('Total'), numeric: true),
        ],
        rows: items.map((item) {
          return DataRow(
            cells: [
              DataCell(Text(item.productId?.name ?? '-', style: TextHelper.bodySmall)),
              DataCell(
                Text(
                  '${item.qty} ${item.unit ?? ""}',
                  style: TextHelper.bodySmall,
                ),
              ),
              DataCell(
                Text('₹${item.unitCost}', style: TextHelper.bodySmall),
              ),
              DataCell(
                Text(
                  '${item.taxId?.percentage ?? 0}%',
                  style: TextHelper.bodySmall,
                ),
              ),
              DataCell(
                Text(
                  '₹${item.total}',
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

  Widget _buildAddressText(PurchaseOrderAddress addr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(addr.addressLine1, style: TextHelper.bodySmall),
        if (addr.addressLine2 != null && addr.addressLine2!.isNotEmpty)
          Text(addr.addressLine2!, style: TextHelper.bodySmall),
        Text(
          '${addr.city?.name ?? ""}, ${addr.state?.name ?? ""}, ${addr.country?.name ?? ""} - ${addr.pinCode ?? ""}',
          style: TextHelper.bodySmall,
        ),
      ],
    );
  }
}
