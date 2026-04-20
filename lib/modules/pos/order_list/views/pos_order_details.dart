import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/pos/order_list_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class POSOrderDetails extends StatelessWidget {
  const POSOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderListModel order = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(order.createdAt);

    return DetailsView(
      title: 'POS Order #${order.orderNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.shoppingCartSimple,
      status: order.paymentStatus,
      statusColor: _getPaymentStatusColor(order.paymentStatus),
      actions: [
        DetailAction(
          label: 'Print Invoice',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapPOSOrder(order);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapPOSOrder(order);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        // DetailAction(
        //   label: 'Refund',
        //   icon: PhosphorIconsFill.arrowCounterClockwise,
        //   onTap: () {},
        // ),
      ],
      sections: [
        DetailSection(
          title: 'Order Summary',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Order Type', value: order.orderType),
                DetailItem(label: 'Salesman', value: order.salesManId.fullName),
                DetailItem(
                  label: 'Payment',
                  value: order.paymentMethod ?? 'Multiple',
                ),
                DetailItem(
                  label: 'Total Amount',
                  value: '₹${order.totalAmount.toStringAsFixed(2)}',
                  color: context.appColors.primary,
                ),
              ],
            ),
          ],
        ),
        if (order.customerId != null)
          DetailSection(
            title: 'Customer Information',
            children: [
              DataGrid(
                items: [
                  DetailItem(
                    label: 'Customer',
                    value:
                        '${order.customerId!.firstName} ${order.customerId!.lastName}',
                  ),
                  DetailItem(
                    label: 'Phone',
                    value:
                        '${order.customerId!.phoneNo.countryCode} ${order.customerId!.phoneNo.phoneNo}',
                  ),
                  if (order.customerId!.email != null)
                    DetailItem(label: 'Email', value: order.customerId!.email!),
                ],
              ),
            ],
          ),
        DetailSection(
          title: 'Order Items',
          children: [
            ...order.items.map((item) => _buildOrderItemCard(item, context)),
          ],
        ),
        DetailSection(
          title: 'Financial Breakdown',
          children: [
            _buildFinancialRow(
              'Subtotal (MRP)',
              '₹${order.totalMrp.toStringAsFixed(2)}',
            ),
            _buildFinancialRow(
              'Discount',
              '-₹${order.totalDiscount.toStringAsFixed(2)}',
              color: AppColors.error,
            ),
            _buildFinancialRow(
              'Tax',
              '+₹${order.totalTaxAmount.toStringAsFixed(2)}',
            ),
            if (order.totalAdditionalCharge > 0)
              _buildFinancialRow(
                'Add. Charges',
                '+₹${order.totalAdditionalCharge.toStringAsFixed(2)}',
              ),
            _buildFinancialRow(
              'Round Off',
              '₹${order.roundOff.toStringAsFixed(2)}',
            ),
            const Divider(height: 24),
            _buildFinancialRow(
              'Grand Total',
              '₹${order.totalAmount.toStringAsFixed(2)}',
              isBold: true,
              fontSize: 18,
            ),
            _buildFinancialRow(
              'Paid Amount',
              '₹${order.paidAmount.toStringAsFixed(2)}',
              color: AppColors.success,
            ),
            if (order.dueAmount > 0)
              _buildFinancialRow(
                'Due Amount',
                '₹${order.dueAmount.toStringAsFixed(2)}',
                color: AppColors.error,
              ),
          ],
        ),
        if (order.remark != null && order.remark!.isNotEmpty)
          DetailSection(
            title: 'Remarks',
            children: [Text(order.remark!, style: TextHelper.bodyMedium)],
          ),
      ],
    );
  }

  Widget _buildOrderItemCard(Item item, BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.productId.name,
                  style: TextHelper.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'x${item.qty}',
                style: TextHelper.h4Style(
                  context,
                ).copyWith(color: context.appColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price: ₹${item.unitCost.toStringAsFixed(2)}',
                style: TextHelper.bodySmall.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
              Text(
                'Total: ₹${item.netAmount.toStringAsFixed(2)}',
                style: TextHelper.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
    double? fontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextHelper.bodyMedium.copyWith(
              color: isBold ? null : AppColors.lightTextSecondary,
              fontWeight: isBold ? FontWeight.bold : null,
            ),
          ),
          Text(
            value,
            style: TextHelper.bodyLarge.copyWith(
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'completed':
        return AppColors.success;
      case 'partial':
      case 'unpaid':
        return Colors.orange;
      case 'cancelled':
        return AppColors.error;
      default:
        return Colors.blue;
    }
  }
}
