import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final PosPaymentModel payment = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(payment.createdAt);

    return DetailsView(
      title: 'Payment #${payment.paymentNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.arrowUpRight,
      status: payment.status,
      statusColor: _getStatusColor(context, payment.status),
      // backgroundHeroColor: Colors.red.shade700,
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapBankPayment(payment);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapBankPayment(payment);
            await PdfService.generateAndShare(pdfData);
          },
        ),
      ],
      sections: [
        DetailSection(
          title: 'Payment Details',
          children: [
            DataGrid(
              items: [
                 DetailItem(
                  label: 'Party/Supplier',
                  value: payment.partyId?.companyName?.isNotEmpty == true
                      ? payment.partyId!.companyName!
                      : '${payment.partyId?.firstName ?? '-'} ${payment.partyId?.lastName ?? ''}'.trim(),
                ),
                DetailItem(
                  label: 'Payment Mode',
                  value: payment.paymentMode.toUpperCase(),
                ),
                DetailItem(
                  label: 'Note',
                  value: payment.expenseType.isNotEmpty
                      ? payment.expenseType
                      : '-',
                ),
                if (payment.posOrderId != null && payment.posOrderId!.orderNo.isNotEmpty)
                  DetailItem(
                    label: 'Reference No.',
                    value: payment.posOrderId!.orderNo,
                  ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Financial Summary',
          children: [
            _buildAmountRow('Base Amount', payment.amount, context: context),
            if (payment.discountAmount > 0)
              _buildAmountRow(
                'Discount',
                -payment.discountAmount.toDouble(),
                context: context,
              ),
            const Divider(height: 32),
            _buildAmountRow(
              'Net Payment',
              payment.totalAmount.toDouble(),
              isTotal: true,
              context: context,
            ),
            _buildAmountRow(
              'Amount Settled',
              payment.paidAmount.toDouble(),
              color: AppColors.success,
              context: context,
            ),
            if (payment.pendingAmount > 0)
              _buildAmountRow(
                'Balance Due',
                payment.pendingAmount.toDouble(),
                color: AppColors.error,
                isBold: true,
                context: context,
              ),
          ],
        ),
        DetailSection(
          title: 'Audit Trail',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Processed By',
                  value: payment.createdBy?.fullName ?? '-',
                ),
                DetailItem(
                  label: 'Entry Date',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(payment.createdAt),
                ),
                DetailItem(
                  label: 'Last Modified',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(payment.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'active':
      case 'paid':
        return AppColors.success;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
      case 'failed':
        return AppColors.error;
      default:
        return context.appColors.primary;
    }
  }

  Widget _buildAmountRow(
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
}
