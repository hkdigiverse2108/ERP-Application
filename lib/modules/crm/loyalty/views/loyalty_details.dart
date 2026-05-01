import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/data/model/crm/loyalty_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoyaltyDetails extends StatelessWidget {
  const LoyaltyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loyalty Program Details')),
        body: const Center(child: Text('No loyalty data found')),
      );
    }
    final LoyaltyModel loyalty = Get.arguments;

    final launchDateStr = DateFormat('dd MMM yyyy').format(loyalty.campaignLaunchDate);
    final expiryDateStr = DateFormat('dd MMM yyyy').format(loyalty.campaignExpiryDate);

    return DetailsView(
      title: loyalty.name,
      subtitle: loyalty.description,
      heroIcon: PhosphorIconsFill.crown,
      status: loyalty.isActive ? 'Active' : 'Inactive',
      statusColor: loyalty.isActive ? AppColors.success : AppColors.error,
      actions: [
        // DetailAction(
        //   label: 'Edit Program',
        //   icon: PhosphorIconsFill.pencil,
        //   onTap: () {},
        // ),
      ],
      sections: [
        DetailSection(
          title: 'Program Rules',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Redemption Points',
                  value: '${loyalty.redemptionPoints} Points',
                  color: AppColors.primary,
                ),
                DetailItem(
                  label: 'Discount Value',
                  value: '${loyalty.discountValue} (${loyalty.typeDisplayName})',
                ),
                DetailItem(
                  label: 'Min Purchase',
                  value: '₹${loyalty.minimumPurchaseAmount}',
                ),
                DetailItem(
                  label: 'Single Use',
                  value: loyalty.singleTimeUse ? 'Yes' : 'No',
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Campaign Performance',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Usage Limit',
                  value: loyalty.usageLimit.toString(),
                ),
                DetailItem(
                  label: 'Used Count',
                  value: loyalty.usedCount.toString(),
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Duration',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Launch Date', value: launchDateStr),
                DetailItem(label: 'Expiry Date', value: expiryDateStr),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Management',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Created By',
                  value: loyalty.createdBy?.fullName ?? 'N/A',
                ),
                DetailItem(
                  label: 'Branch',
                  value: loyalty.branchId?.name ?? 'Head Office',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
