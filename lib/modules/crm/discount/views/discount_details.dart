import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/data/model/crm/dicount_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DiscountDetails extends StatelessWidget {
  const DiscountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Discount Details')),
        body: const Center(child: Text('No discount data found')),
      );
    }
    final DiscountModel discount = Get.arguments;

    final startDateStr = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(discount.startDateTime);
    final endDateStr = discount.endDateTime != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(discount.endDateTime!)
        : 'Evergreen';

    return DetailsView(
      title: discount.title,
      subtitle: 'Code: ${discount.discountCode}',
      heroIcon: PhosphorIconsFill.tag,
      status: discount.status,
      statusColor: discount.status == 'active'
          ? AppColors.success
          : AppColors.error,
      actions: [
        // DetailAction(
        //   label: 'Statistics',
        //   icon: PhosphorIconsFill.chartBar,
        //   onTap: () {},
        // ),
      ],
      sections: [
        DetailSection(
          title: 'Configuration',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Value',
                  value: '${discount.discountValue} (${discount.discountType})',
                ),
                DetailItem(
                  label: 'Apply Mode',
                  value: discount.autoApply ? 'Automatic' : 'Manual Code',
                ),
                DetailItem(
                  label: 'Applicable For',
                  value: discount.discountApplicable.toUpperCase(),
                ),
                DetailItem(
                  label: 'Requirement',
                  value: discount.minimumRequirement == 'none'
                      ? 'None'
                      : '${discount.minimumRequirement}: ${discount.minimumPurchaseAmount ?? discount.minimumQuantity ?? ""}',
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Performance',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Used Count',
                  value: discount.usedCount.toString(),
                ),
                DetailItem(
                  label: 'Usage Limit',
                  value: discount.usageLimitTotal?.toString() ?? 'Unlimited',
                ),
                DetailItem(
                  label: 'Revenue Generated',
                  value: '₹${discount.revenue.toStringAsFixed(2)}',
                  color: AppColors.success,
                ),
                DetailItem(label: 'Orders', value: discount.orders.toString()),
              ],
            ),
          ],
        ),
        if (discount.productIds.isNotEmpty || discount.categoryIds.isNotEmpty)
          DetailSection(
            title: 'Inclusions',
            children: [
              if (discount.categoryIds.isNotEmpty) ...[
                const Text(
                  'Categories:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children: discount.categoryIds
                      .map((e) => Chip(label: Text(e.name)))
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],
              if (discount.productIds.isNotEmpty) ...[
                const Text(
                  'Specific Products:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children: discount.productIds
                      .map((e) => Chip(label: Text(e.name)))
                      .toList(),
                ),
              ],
            ],
          ),
        DetailSection(
          title: 'Timeline',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Start Time', value: startDateStr),
                DetailItem(label: 'End Time', value: endDateStr),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
