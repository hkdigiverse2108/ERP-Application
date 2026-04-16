import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/data/model/crm/coupon_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CouponDetails extends StatelessWidget {
  const CouponDetails({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Coupon Details')),
        body: const Center(child: Text('No coupon data found')),
      );
    }
    final CouponModel coupon = Get.arguments;

    final createdAtStr = DateFormat('dd MMM yyyy').format(coupon.createdAt);
    final startDateStr = coupon.startDate != null
        ? DateFormat('dd MMM yyyy').format(coupon.startDate!)
        : '-';
    final endDateStr = coupon.endDate != null
        ? DateFormat('dd MMM yyyy').format(coupon.endDate!)
        : '-';

    return DetailsView(
      title: coupon.name,
      subtitle: 'Created: $createdAtStr',
      heroIcon: PhosphorIconsFill.ticket,
      status: coupon.status,
      statusColor: coupon.status == 'active'
          ? AppColors.success
          : AppColors.error,
      actions: [
        DetailAction(
          label: 'Deactivate',
          icon: PhosphorIconsFill.power,
          onTap: () {},
          color: AppColors.error,
        ),
      ],
      sections: [
        DetailSection(
          title: 'Coupon Info',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Value',
                  value: '${coupon.redeemValue} (${coupon.redemptionType})',
                ),
                DetailItem(
                  label: 'Single Use',
                  value: coupon.singleTimeUse ? 'Yes' : 'No',
                ),
                DetailItem(
                  label: 'Usage Limit',
                  value: coupon.usageLimit?.toString() ?? 'Unlimited',
                ),
                DetailItem(
                  label: 'Used Count',
                  value: coupon.usedCount.toString(),
                ),
                DetailItem(
                  label: 'Price',
                  value: coupon.couponPrice?.toString() ?? 'Free',
                ),
                DetailItem(
                  label: 'Expiry Days',
                  value: coupon.expiryDays?.toString() ?? '-',
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Validity',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Start Date', value: startDateStr),
                DetailItem(label: 'End Date', value: endDateStr),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'System Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Created By',
                  value: coupon.createdBy?.fullName ?? 'N/A',
                ),
                DetailItem(
                  label: 'Company',
                  value: coupon.companyId?.name ?? 'N/A',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
