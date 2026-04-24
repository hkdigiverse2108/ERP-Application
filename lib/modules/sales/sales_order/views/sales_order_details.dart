import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SalesOrderDetails extends StatelessWidget {
  const SalesOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesOrderModel order = Get.arguments;
    final dateStr = DateFormat(
      'dd MMM yyyy',
    ).format(order.date ?? DateTime.now());
    final dueDateStr = DateFormat(
      'dd MMM yyyy',
    ).format(order.dueDate ?? DateTime.now());

    return DetailsView(
      title: 'Sales Order #${order.salesOrderNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.shoppingCartSimple,
      status: order.status ?? 'Pending',
      statusColor: _getStatusColor(context, order.status),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapSalesOrder(order);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapSalesOrder(order);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        // DetailAction(
        //   label: 'Ready for delivery',
        //   icon: PhosphorIconsFill.truck,
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
                  label: 'Customer',
                  value:
                      '${order.customerId?.firstName} ${order.customerId?.lastName}',
                ),
                DetailItem(
                  label: 'Place of Supply',
                  value: order.placeOfSupply ?? '-',
                ),
                DetailItem(label: 'Due Date', value: dueDateStr),
                DetailItem(label: 'Tax Type', value: order.taxType ?? '-'),
                DetailItem(
                  label: 'Reverse Charge',
                  value: order.reverseCharge ? 'Yes' : 'No',
                ),
                DetailItem(
                  label: 'Payment Terms',
                  value: order.paymentTerms ?? '-',
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
              order.transactionSummary?.grossAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Discount',
              -(order.transactionSummary?.discountAmount ?? 0),
              context: context,
            ),
            _buildSummaryRow(
              'Taxable Amount',
              order.transactionSummary?.taxableAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Tax Amount',
              order.transactionSummary?.taxAmount ?? 0,
              context: context,
            ),
            if (order.additionalCharges.isNotEmpty)
              _buildSummaryRow(
                'Additional Charges',
                order.additionalCharges.fold(
                  0.0,
                  (sum, item) => sum + item.totalAmount,
                ),
                context: context,
              ),
            _buildSummaryRow(
              'Round Off',
              order.transactionSummary?.roundOff ?? 0,
              context: context,
            ),
            const Divider(height: 32),
            _buildSummaryRow(
              'Net Amount',
              order.transactionSummary?.netAmount ?? 0,
              isTotal: true,
              context: context,
            ),
          ],
        ),
        if (order.billingAddress != null || order.shippingAddress != null)
          DetailSection(
            title: 'Address Information',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (order.billingAddress != null)
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
                          _buildAddressText(order.billingAddress!),
                        ],
                      ),
                    ),
                  if (order.shippingAddress != null) ...[
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
                          _buildAddressText(order.shippingAddress!),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        if (order.shippingDetails != null)
          DetailSection(
            title: 'Shipping Details',
            children: [
              DataGrid(
                items: [
                  DetailItem(
                    label: 'Shipping Type',
                    value: order.shippingDetails?.shippingType ?? '-',
                  ),
                  DetailItem(
                    label: 'Weight',
                    value: '${order.shippingDetails?.weight ?? 0} kg',
                  ),
                  DetailItem(
                    label: 'Mode of Transport',
                    value: order.shippingDetails?.modeOfTransport ?? '-',
                  ),
                  DetailItem(
                    label: 'Vehicle No',
                    value: order.shippingDetails?.vehicleNo ?? '-',
                  ),
                ],
              ),
            ],
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

  Color _getStatusColor(BuildContext context, String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return AppColors.success;
      case 'processing':
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return AppColors.error;
      default:
        return context.appColors.primary;
    }
  }

  Widget _buildItemsTable(BuildContext context, List<SalesOrderItem> items) {
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
              DataCell(Text('${item.qty}', style: TextHelper.bodySmall)),
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

  Widget _buildAddressText(SalesOrderAddress addr) {
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
