import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/delivery_challan_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DeliveryChallanDetails extends StatelessWidget {
  const DeliveryChallanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryChallanModel challan = Get.arguments;
    final dateStr = DateFormat(
      'dd MMM yyyy',
    ).format(challan.date ?? DateTime.now());
    final dueDateStr = DateFormat(
      'dd MMM yyyy',
    ).format(challan.dueDate ?? DateTime.now());

    return DetailsView(
      title: 'Challan #${challan.deliveryChallanNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.truck,
      status: challan.status ?? 'Pending',
      statusColor: _getStatusColor(context, challan.status),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapDeliveryChallan(challan);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapDeliveryChallan(challan);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        // DetailAction(
        //   label: 'Mark Delivered',
        //   icon: PhosphorIconsFill.checkCircle,
        //   color: Colors.green,
        //   onTap: () {},
        // ),
      ],
      sections: [
        DetailSection(
          title: 'Challan Details',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Customer',
                  value:
                      '${challan.customerId?.firstName} ${challan.customerId?.lastName}',
                ),
                DetailItem(
                  label: 'Place of Supply',
                  value: challan.placeOfSupply ?? '-',
                ),
                if (challan.dueDate != null)
                  DetailItem(label: 'Due Date', value: dueDateStr),
                DetailItem(label: 'Tax Type', value: challan.taxType ?? '-'),
                DetailItem(
                  label: 'Reverse Charge',
                  value: challan.reverseCharge ? 'Yes' : 'No',
                ),
                DetailItem(
                  label: 'Payment Terms',
                  value: challan.paymentTerms ?? '-',
                ),
              ],
            ),
          ],
        ),
        if (challan.salesOrderIds.isNotEmpty || challan.invoiceIds.isNotEmpty)
          DetailSection(
            title: 'Linked Documents',
            children: [
              DataGrid(
                items: [
                  if (challan.salesOrderIds.isNotEmpty)
                    DetailItem(
                      label: 'Sales Orders',
                      value: challan.salesOrderIds
                          .map((e) => '#${e.name}')
                          .join(', '),
                    ),
                  if (challan.invoiceIds.isNotEmpty)
                    DetailItem(
                      label: 'Invoices',
                      value: challan.invoiceIds
                          .map((e) => '#${e.name}')
                          .join(', '),
                    ),
                ],
              ),
            ],
          ),
        DetailSection(
          title: 'Items',
          children: [_buildItemsTable(context, challan.items)],
        ),
        DetailSection(
          title: 'Summary',
          children: [
            _buildSummaryRow(
              'Gross Amount',
              challan.transactionSummary?.grossAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Discount',
              -(challan.transactionSummary?.discountAmount ?? 0),
              context: context,
            ),
            _buildSummaryRow(
              'Taxable Amount',
              challan.transactionSummary?.taxableAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Tax Amount',
              challan.transactionSummary?.taxAmount ?? 0,
              context: context,
            ),
            if (challan.additionalCharges.isNotEmpty)
              _buildSummaryRow(
                'Additional Charges',
                challan.additionalCharges.fold(
                  0.0,
                  (sum, item) => sum + item.totalAmount,
                ),
                context: context,
              ),
            _buildSummaryRow(
              'Round Off',
              challan.transactionSummary?.roundOff ?? 0,
              context: context,
            ),
            const Divider(height: 32),
            _buildSummaryRow(
              'Net Amount',
              challan.transactionSummary?.netAmount ?? 0,
              isTotal: true,
              context: context,
            ),
          ],
        ),
        if (challan.billingAddress != null || challan.shippingAddress != null)
          DetailSection(
            title: 'Address Information',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (challan.billingAddress != null)
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
                          _buildAddressText(challan.billingAddress!),
                        ],
                      ),
                    ),
                  if (challan.shippingAddress != null) ...[
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
                          _buildAddressText(challan.shippingAddress!),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        if (challan.shippingDetails != null)
          DetailSection(
            title: 'Shipping Details',
            children: [
              DataGrid(
                items: [
                  DetailItem(
                    label: 'Shipping Type',
                    value: challan.shippingDetails?.shippingType ?? '-',
                  ),
                  DetailItem(
                    label: 'Weight',
                    value: '${challan.shippingDetails?.weight ?? 0} kg',
                  ),
                  DetailItem(
                    label: 'Mode of Transport',
                    value: challan.shippingDetails?.modeOfTransport ?? '-',
                  ),
                  DetailItem(
                    label: 'Vehicle No',
                    value: challan.shippingDetails?.vehicleNo ?? '-',
                  ),
                ],
              ),
            ],
          ),
        if (challan.notes != null && challan.notes!.isNotEmpty)
          DetailSection(
            title: 'Notes',
            children: [
              Text(
                challan.notes!,
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
      case 'delivered':
      case 'completed':
        return AppColors.success;
      case 'pending':
      case 'transit':
        return Colors.orange;
      case 'returned':
      case 'cancelled':
        return AppColors.error;
      default:
        return context.appColors.primary;
    }
  }

  Widget _buildItemsTable(
    BuildContext context,
    List<DeliveryChallanItem> items,
  ) {
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

  Widget _buildAddressText(DeliveryChallanAddress addr) {
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
