import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class QuickActionDropdown extends StatelessWidget {
  final double topOffset;
  const QuickActionDropdown({super.key, required this.topOffset});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: topOffset,
          left: Sizes.paddingM,
          child: Material(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            color: context.responsive(
              light: AppColors.lightSurface,
              dark: AppColors.darkSurface,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - topOffset - 20,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.paddingM,
                  vertical: Sizes.paddingM,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MainHeader(
                      title: "Dashboard",
                      onTap: () {
                        Get.toNamed(Routes.dashboard);
                      },
                    ),
                    _ExpandableSection(
                      title: "Accounting",
                      items: [
                        QuickActionItem(
                          title: "Cradit Note",
                          route: Routes.credit,
                        ),
                        QuickActionItem(
                          title: "Debit Note",
                          route: Routes.debit,
                        ),
                      ],
                    ),
                    _ExpandableSection(
                      title: "Bank / Cash",
                      items: [
                        QuickActionItem(title: "Bank", route: Routes.bank),
                        QuickActionItem(
                          title: "Bank Transaction",
                          route: Routes.bankTransaction,
                        ),
                        QuickActionItem(
                          title: "Receipt",
                          route: Routes.receipt,
                        ),
                        QuickActionItem(
                          title: "Payment",
                          route: Routes.posPayment,
                        ),
                        QuickActionItem(
                          title: "Expense",
                          route: Routes.expense,
                        ),
                        QuickActionItem(title: "Salary", route: Routes.salary),
                      ],
                    ),
                    _ExpandableSection(
                      title: "Purchase",
                      items: [
                        QuickActionItem(
                          title: "Supplier Bill",
                          route: Routes.supplierBill,
                        ),
                        QuickActionItem(
                          title: "Purchase Order",
                          route: Routes.purchaseOrder,
                        ),
                        QuickActionItem(
                          title: "Purchase Debit Note",
                          route: Routes.purchaseReturn,
                        ),
                      ],
                    ),
                    _ExpandableSection(
                      title: "Sales",
                      items: [
                        QuickActionItem(
                          title: "Estimate",
                          route: Routes.estimate,
                        ),
                        QuickActionItem(
                          title: "Sales Order",
                          route: Routes.salesOrder,
                        ),
                        QuickActionItem(
                          title: "Invoice",
                          route: Routes.invoice,
                        ),
                        QuickActionItem(
                          title: "Delivery Challan",
                          route: Routes.deliveryChallan,
                        ),
                        QuickActionItem(
                          title: "Sales Credit Note",
                          route: Routes.salesCreditNote,
                        ),
                      ],
                    ),
                    _ExpandableSection(
                      title: "Contact",
                      items: [
                        QuickActionItem(
                          title: "Contact",
                          route: Routes.contact,
                        ),
                      ],
                    ),
                    _ExpandableSection(
                      title: "Inventory",
                      items: [
                        QuickActionItem(
                          title: "Product",
                          route: Routes.product,
                        ),
                        QuickActionItem(title: "Stock", route: Routes.stock),
                        QuickActionItem(title: "Recipt", route: Routes.recipe),
                        QuickActionItem(
                          title: "Stock Varification ",
                          route: Routes.stockVerification,
                        ),
                        QuickActionItem(
                          title: "Bill of Live",
                          route: Routes.billOfLive,
                        ),
                        QuickActionItem(
                          title: "Material Consumption",
                          route: Routes.materialConsumption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class QuickActionItem {
  final String title;
  final String? route;

  const QuickActionItem({required this.title, this.route});
}

class _ExpandableSection extends StatelessWidget {
  final String title;
  final List<QuickActionItem>? items;
  // final VoidCallback? onTap;

  const _ExpandableSection({required this.title, this.items});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: GestureDetector(
        // onTap: onTap,
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(
            left: Sizes.paddingS,
            bottom: Sizes.paddingS,
          ),
          initiallyExpanded: true,
          iconColor: context.responsive(
            light: AppColors.lightTextSecondary,
            dark: AppColors.darkTextSecondary,
          ),
          collapsedIconColor: context.responsive(
            light: AppColors.lightTextSecondary,
            dark: AppColors.darkTextSecondary,
          ),
          title: Text(
            title,
            style: TextHelper.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          children: items != null
              ? items!
                    .map(
                      (item) => _QuickActionItem(
                        label: item.title,
                        onTap: () {
                          if (item.route != null) {
                            Get.toNamed(item.route!);
                          } else {
                            Get.back();
                          }
                        },
                      ),
                    )
                    .toList()
              : [],
        ),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        onTap();
      },
      borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.paddingS / 2),
        child: Row(
          children: [
            Icon(
              PhosphorIconsRegular.arrowBendDownRight,
              size: Sizes.iconSizeS,
              color: context.responsive(
                light: AppColors.lightTextSecondary,
                dark: AppColors.darkTextSecondary,
              ),
            ),
            const Gap(Sizes.paddingS),
            Text(
              label,
              style: TextHelper.bodyMedium.copyWith(
                color: context.responsive(
                  light: AppColors.lightTextSecondary,
                  dark: AppColors.darkTextSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _MainHeader({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            Get.toNamed(Routes.dashboard);
          } else {
            Get.toNamed(Routes.dashboard);
          }
        },
        child: Text(
          title,
          style: TextHelper.h2.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
