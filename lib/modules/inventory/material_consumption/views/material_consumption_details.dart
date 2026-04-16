import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/invetory/material_consumption_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MaterialConsumptionDetails extends StatelessWidget {
  const MaterialConsumptionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialConsumptionModel consumption = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(consumption.date);

    return DetailsView(
      title: 'Consumption #${consumption.number}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.fire,
      status: consumption.isActive ? 'Active' : 'Inactive',
      statusColor: consumption.isActive ? AppColors.success : AppColors.error,
      // backgroundHeroColor: Colors.deepOrange.shade700,
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () {},
        ),
        DetailAction(
          label: 'Export',
          icon: PhosphorIconsFill.export,
          onTap: () {},
        ),
      ],
      sections: [
        DetailSection(
          title: 'Consumption Overview',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Voucher No', value: consumption.number),
                DetailItem(label: 'Type', value: consumption.consumptionTypeId.name),
                DetailItem(
                  label: 'Total Qty',
                  value: consumption.totalQty.toStringAsFixed(2),
                ),
                DetailItem(
                  label: 'Total Cost',
                  value: '₹${consumption.totalAmount.toStringAsFixed(2)}',
                ),
              ],
            ),
            if (consumption.remark != null && consumption.remark!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Remarks',
                style: TextHelper.label.copyWith(color: AppColors.lightTextSecondary),
              ),
              const SizedBox(height: 4),
              Text(
                consumption.remark!,
                style: TextHelper.bodyMedium,
              ),
            ],
          ],
        ),
        DetailSection(
          title: 'Consumed Items',
          children: [
            ...consumption.items.map((item) => _buildItemRow(item, context)),
          ],
        ),
        DetailSection(
          title: 'Audit Detail',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Created By', value: consumption.createdBy.fullName),
                DetailItem(
                  label: 'Log Date',
                  value: DateFormat('dd MMM yyyy, hh:mm a').format(consumption.createdAt),
                ),
                DetailItem(
                  label: 'Branch',
                  value: consumption.branchId.name,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemRow(Item item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productId.name,
                  style: TextHelper.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Unit Price: ₹${item.price.toStringAsFixed(2)}',
                  style: TextHelper.bodySmall.copyWith(color: AppColors.lightTextSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Qty: ${item.qty}',
                style: TextHelper.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${item.totalPrice.toStringAsFixed(2)}',
                style: TextHelper.bodySmall.copyWith(
                  color: context.appColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
