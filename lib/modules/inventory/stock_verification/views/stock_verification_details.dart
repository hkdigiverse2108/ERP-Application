import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/invetory/stock_verification_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StockVerificationDetails extends StatelessWidget {
  const StockVerificationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final StockVerificationModel verification = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(verification.createdAt);

    return DetailsView(
      title: 'Verification #${verification.stockVerificationNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.clipboardText,
      status: verification.status,
      statusColor: _getStatusColor(context, verification.status),
      // backgroundHeroColor: Colors.blueGrey.shade700,
      actions: [
        DetailAction(
          label: 'Print Report',
          icon: PhosphorIconsFill.printer,
          onTap: () {},
        ),
        DetailAction(
          label: 'Export PDF',
          icon: PhosphorIconsFill.filePdf,
          onTap: () {},
        ),
      ],
      sections: [
        DetailSection(
          title: 'Verification Summary',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Total Products',
                  value: verification.totalProducts.toStringAsFixed(0),
                ),
                DetailItem(
                  label: 'Total Physical Qty',
                  value: verification.totalPhysicalQty.toStringAsFixed(2),
                ),
                DetailItem(
                  label: 'Net Difference',
                  value:
                      '₹${verification.totalDifferenceAmount.toStringAsFixed(2)}',
                  color: verification.totalDifferenceAmount < 0
                      ? AppColors.error
                      : AppColors.success,
                ),
                DetailItem(
                  label: 'Responsible',
                  value: verification.createdBy.fullName,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Item Discrepancies',
          children: [
            ...verification.items.map((item) => _buildItemCard(item, context)),
          ],
        ),
        DetailSection(
          title: 'Audit Log',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Log No',
                  value: verification.stockVerificationNo,
                ),
                DetailItem(
                  label: 'Created At',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(verification.createdAt),
                ),
                DetailItem(
                  label: 'Last Modified',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(verification.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemCard(Item item, BuildContext context) {
    final bool isNegative = item.differenceQty < 0;

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isNegative ? AppColors.error : AppColors.success)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Diff: ${item.differenceQty > 0 ? '+' : ''}${item.differenceQty}',
                  style: TextHelper.bodyMediumStyle(context).copyWith(
                    color: isNegative ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSimpleStat(
                'System Qty',
                item.systemQty.toString(),
                context: context,
              ),
              _buildSimpleStat(
                'Physical Qty',
                item.physicalQty.toString(),
                context: context,
              ),
              _buildSimpleStat(
                'Value Diff',
                '₹${item.differenceAmount.toStringAsFixed(2)}',
                color: isNegative ? AppColors.error : AppColors.success,
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(
    String label,
    String value, {
    Color? color,
    required BuildContext context,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextHelper.captionStyle(
              context,
            ).copyWith(color: AppColors.lightTextSecondary),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextHelper.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
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
}
