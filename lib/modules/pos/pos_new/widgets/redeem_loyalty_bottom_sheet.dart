import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/crm/loyalty_pos_model.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RedeemLoyaltyBottomSheet extends StatefulWidget {
  const RedeemLoyaltyBottomSheet({super.key});

  @override
  State<RedeemLoyaltyBottomSheet> createState() => _RedeemLoyaltyBottomSheetState();
}

class _RedeemLoyaltyBottomSheetState extends State<RedeemLoyaltyBottomSheet> {
  final controller = PosNewController.instance;
  final searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.borderRadiusXL),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Redeem Loyalty",
                style: TextHelper.h4Style(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
                style: IconButton.styleFrom(
                  backgroundColor: context.appColors.border.withValues(
                    alpha: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),

          // Search
          EditTextField(
            label: "Search Campaign",
            controller: searchController,
            hintText: "Enter campaign name...",
            prefixIcon: const Icon(PhosphorIconsLight.magnifyingGlass),
            onChanged: (val) {
              setState(() {
                searchQuery = val.toLowerCase();
              });
            },
          ),
          const Gap(20),

          Flexible(
            child: Obx(() {
              if (controller.isLoyaltyLoading.value) {
                return const Center(child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(),
                ));
              }

              final filteredLoyalties = controller.loyalties.where((l) {
                return l.name.toLowerCase().contains(searchQuery);
              }).toList();

              if (filteredLoyalties.isEmpty) {
                return _buildEmptyState(context);
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: filteredLoyalties.length,
                itemBuilder: (context, index) {
                  final loyalty = filteredLoyalties[index];
                  final isApplied = controller.appliedLoyalty.value?.loyaltyId == loyalty.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildLoyaltyCard(context, loyalty, isApplied),
                  );
                },
              );
            }),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildLoyaltyCard(
    BuildContext context,
    LoyaltyDropdownModel loyalty,
    bool isApplied,
  ) {
    return GestureDetector(
      onTap: () {
        if (!isApplied) {
          controller.redeemLoyalty(loyalty);
        } else {
          controller.appliedLoyalty.value = null;
          controller.calculateTotals();
          Get.back();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isApplied
              ? context.appColors.primary.withValues(alpha: 0.05)
              : context.appColors.surface,
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          border: Border.all(
            color: isApplied
                ? context.appColors.primary
                : context.appColors.border,
            width: isApplied ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Left: Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                PhosphorIconsLight.gift,
                color: context.appColors.primary,
                size: 24,
              ),
            ),
            const Gap(16),

            // Middle: Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        loyalty.name,
                        style: TextHelper.bodyMediumStyle(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(8),
                      if (isApplied)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: context.appColors.success,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "Applied",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    "Min. Purchase: ₹${loyalty.minimumPurchaseAmount}",
                    style: TextHelper.bodySmall.copyWith(
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Right: Arrow/Check
            Icon(
              isApplied
                  ? Icons.check_circle
                  : PhosphorIconsLight.caretRight,
              color: isApplied
                  ? context.appColors.success
                  : context.appColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            PhosphorIconsLight.gift,
            size: 64,
            color: context.appColors.textSecondary.withValues(alpha: 0.3),
          ),
          const Gap(16),
          Text(
            "No Loyalty Campaigns",
            style: TextHelper.bodyMediumStyle(context).copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.textSecondary,
            ),
          ),
          const Gap(8),
          Text(
            "We couldn't find any active loyalty campaigns for this customer.",
            textAlign: TextAlign.center,
            style: TextHelper.bodySmall.copyWith(
              color: context.appColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
