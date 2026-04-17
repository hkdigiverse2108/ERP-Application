import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EstimateDetails extends StatelessWidget {
  const EstimateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final EstimateModel estimate = Get.arguments;
    final dateStr = DateFormat(
      'dd MMM yyyy',
    ).format(estimate.date ?? DateTime.now());
    final dueDateStr = DateFormat(
      'dd MMM yyyy',
    ).format(estimate.dueDate ?? DateTime.now());

    return DetailsView(
      title: 'Estimate #${estimate.estimateNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.calculator,
      status: estimate.status ?? 'Pending',
      statusColor: _getStatusColor(context, estimate.status),
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapEstimate(estimate);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapEstimate(estimate);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        DetailAction(
          label: 'Accept',
          icon: PhosphorIconsFill.checkCircle,
          color: Colors.green,
          onTap: () {},
        ),
      ],
      sections: [
        DetailSection(
          title: 'Estimate Details',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Customer',
                  value:
                      '${estimate.customerId?.firstName} ${estimate.customerId?.lastName}',
                ),
                DetailItem(
                  label: 'Place of Supply',
                  value: estimate.placeOfSupply ?? '-',
                ),
                DetailItem(label: 'Due Date', value: dueDateStr),
                DetailItem(label: 'Tax Type', value: estimate.taxType ?? '-'),
                DetailItem(
                  label: 'Payment Terms',
                  value: estimate.paymentTerms ?? '-',
                ),
                DetailItem(
                  label: 'Reverse Charge',
                  value: estimate.reverseCharge ? 'Yes' : 'No',
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Items',
          children: [_buildItemsTable(context, estimate.items)],
        ),
        DetailSection(
          title: 'Summary',
          children: [
            _buildSummaryRow(
              'Gross Amount',
              estimate.transactionSummary?.grossAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Discount',
              -(estimate.transactionSummary?.discountAmount ?? 0),
              context: context,
            ),
            _buildSummaryRow(
              'Taxable Amount',
              estimate.transactionSummary?.taxableAmount ?? 0,
              context: context,
            ),
            _buildSummaryRow(
              'Tax Amount',
              estimate.transactionSummary?.taxAmount ?? 0,
              context: context,
            ),
            if (estimate.additionalCharges.isNotEmpty)
              _buildSummaryRow(
                'Additional Charges',
                estimate.additionalCharges.fold(
                  0.0,
                  (sum, item) => sum + item.totalAmount,
                ),
                context: context,
              ),
            _buildSummaryRow(
              'Round Off',
              estimate.transactionSummary?.roundOff ?? 0,
              context: context,
            ),
            const Divider(height: 32),
            _buildSummaryRow(
              'Net Amount',
              estimate.transactionSummary?.netAmount ?? 0,
              isTotal: true,
              context: context,
            ),
          ],
        ),
        if (estimate.billingAddress != null || estimate.shippingAddress != null)
          DetailSection(
            title: 'Address Information',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (estimate.billingAddress != null)
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
                          _buildAddressText(estimate.billingAddress!),
                        ],
                      ),
                    ),
                  if (estimate.shippingAddress != null) ...[
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
                          _buildAddressText(estimate.shippingAddress!),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        if (estimate.notes != null && estimate.notes!.isNotEmpty)
          DetailSection(
            title: 'Notes',
            children: [
              Text(
                estimate.notes!,
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
      case 'accepted':
      case 'order created':
      case 'invoice created':
        return AppColors.success;
      case 'pending':
        return Colors.orange;
      case 'rejected':
      case 'cancelled':
        return AppColors.error;
      default:
        return context.appColors.primary;
    }
  }

  Widget _buildItemsTable(BuildContext context, List<Item> items) {
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

  Widget _buildAddressText(Address addr) {
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
