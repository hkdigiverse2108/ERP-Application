import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/crm/coupon_model.dart';
import 'package:ai_setu/data/model/crm/discount_model.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ApplyCouponBottomSheet extends StatefulWidget {
  const ApplyCouponBottomSheet({super.key});

  @override
  State<ApplyCouponBottomSheet> createState() => _ApplyCouponBottomSheetState();
}

class _ApplyCouponBottomSheetState extends State<ApplyCouponBottomSheet> {
  final controller = PosNewController.instance;
  final searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    controller.fetchCoupons();
    controller.fetchDiscounts();
  }

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
                "Coupons and Discounts",
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
            label: "Search Coupon",
            controller: searchController,
            hintText: "Enter coupon code...",
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
              if (controller.isCouponLoading.value ||
                  controller.isDiscountLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final filteredCoupons = controller.coupons.where((c) {
                return c.name.toLowerCase().contains(searchQuery);
              }).toList();

              final filteredDiscounts = controller.discounts.where((d) {
                return d.title.toLowerCase().contains(searchQuery) ||
                    d.discountCode.toLowerCase().contains(searchQuery);
              }).toList();

              if (filteredCoupons.isEmpty && filteredDiscounts.isEmpty) {
                return _buildEmptyState(context);
              }

              return ListView(
                shrinkWrap: true,
                children: [
                  if (filteredCoupons.isNotEmpty) ...[
                    _buildSectionTitle(context, "Coupons"),
                    const Gap(12),
                    ...filteredCoupons.map((coupon) {
                      final isApplied =
                          controller.appliedCoupon.value?.id == coupon.id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildCouponCard(context, coupon, isApplied),
                      );
                    }),
                    const Gap(8),
                  ],
                  if (filteredDiscounts.isNotEmpty) ...[
                    _buildSectionTitle(context, "Discounts"),
                    const Gap(12),
                    ...filteredDiscounts.map((discount) {
                      final isApplied =
                          controller.appliedDiscount.value?.id == discount.id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildDiscountCard(context, discount, isApplied),
                      );
                    }),
                  ],
                ],
              );
            }),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildCouponCard(
    BuildContext context,
    CouponModel coupon,
    bool isApplied,
  ) {
    final discountLabel =
        (coupon.redemptionType == 'fixed_amount' ||
            coupon.redemptionType == 'flat')
        ? "₹${coupon.redeemValue}"
        : "${coupon.redeemValue}% OFF";

    return GestureDetector(
      onTap: () {
        if (!isApplied) {
          controller.applyCoupon(coupon);
          Get.back();
        } else {
          controller.removeCoupon();
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
            // Left: Icon/Design
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                PhosphorIconsLight.ticket,
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
                        coupon.name,
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
                    "Valid till ${coupon.endDate != null ? DateFormat('dd MMM yyyy').format(coupon.endDate!) : 'N/A'}",
                    style: TextHelper.bodySmall.copyWith(
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Right: Discount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  discountLabel,
                  style: TextHelper.bodyMediumStyle(context).copyWith(
                    color: context.appColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
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
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountCard(
    BuildContext context,
    DiscountModel discount,
    bool isApplied,
  ) {
    final discountLabel =
        (discount.discountType == 'fixed_amount' ||
            discount.discountType == 'flat')
        ? "₹${discount.discountValue}"
        : "${discount.discountValue}% OFF";

    return GestureDetector(
      onTap: () {
        if (!isApplied) {
          controller.applyDiscount(discount);
          Get.back();
        } else {
          controller.removeDiscount();
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
            // Left: Icon/Design
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                PhosphorIconsLight.tag,
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
                        discount.title,
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
                    "Code: ${discount.discountCode}",
                    style: TextHelper.bodySmall.copyWith(
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Right: Discount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  discountLabel,
                  style: TextHelper.bodyMediumStyle(context).copyWith(
                    color: context.appColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextHelper.bodyMediumStyle(context).copyWith(
        fontWeight: FontWeight.bold,
        color: context.appColors.textSecondary,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            PhosphorIconsLight.ticket,
            size: 64,
            color: context.appColors.textSecondary.withValues(alpha: 0.3),
          ),
          const Gap(16),
          Text(
            "No Offers Available",
            style: TextHelper.bodyMediumStyle(context).copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.textSecondary,
            ),
          ),
          const Gap(8),
          Text(
            "We couldn't find any active coupons or discounts at the moment.",
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
