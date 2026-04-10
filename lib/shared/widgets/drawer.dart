import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const Color _activeBg = Color(0xFFE8F0FF);
  static const Color _activeFg = Color(0xFF3D5AFE);
  static const Color _footerBg = Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final colors = context.appColors;
    final isDark = ThemeService().isDarkMode;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.82,
      backgroundColor: colors.background,
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  (isDark)
                      ? Image.asset(Images.lightAisetuLogo, height: 24)
                      : Image.asset(Images.darkAisetuLogo, height: 24),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      PhosphorIconsLight.x,
                      color: colors.textSecondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),
            const Gap(8),

            // ── Menu Label ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'MENU',
                  style: TextHelper.caption.copyWith(
                    color: Colors.grey,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Gap(8),

            // ── Nav Items ──
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _NavItem(
                    icon: PhosphorIconsLight.houseLine,
                    label: 'Dashboard',
                    route: Routes.home,
                    isActive: currentRoute == Routes.home,
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.package,
                    label: 'Inventory',
                    children: [
                      _NavItem(
                        label: 'Products',
                        route: Routes.product,
                        isChild: true,
                        isActive: currentRoute == Routes.product,
                      ),
                      _NavItem(
                        label: 'Stock',
                        route: Routes.stock,
                        isChild: true,
                        isActive: currentRoute == Routes.stock,
                      ),
                      _NavItem(
                        label: 'Stock Verification',
                        route: Routes.stockVarification,
                        isChild: true,
                        isActive: currentRoute == Routes.stockVarification,
                      ),
                      _NavItem(
                        label: 'Recipe',
                        route: Routes.recipt,
                        isChild: true,
                        isActive: currentRoute == Routes.recipt,
                      ),
                      _NavItem(
                        label: 'Bill of Live',
                        route: Routes.billOfLive,
                        isChild: true,
                      ),
                      _NavItem(
                        label: 'Material Consumption',
                        route: Routes.materialConsumption,
                        isChild: true,
                      ),
                    ],
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.calculator,
                    label: 'Accounting',
                    children: [
                      _NavItem(
                        label: 'Debit Note',
                        route: Routes.debit,
                        isChild: true,
                      ),
                      _NavItem(
                        label: 'Credit Note',
                        route: Routes.credit,
                        isChild: true,
                      ),
                    ],
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.cashRegister,
                    label: 'POS',
                    children: [
                      _NavItem(
                        label: 'Order List',
                        route: Routes.posOrderList,
                        isChild: true,
                      ),
                      _NavItem(
                        label: 'Credit Note',
                        route: Routes.posCreditNote,
                        isChild: true,
                      ),
                      _NavItem(
                        label: 'Sales Register',
                        route: Routes.posSalesRegister,
                        isChild: true,
                      ),
                    ],
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.shoppingCart,
                    label: 'Purchase',
                    children: [
                      _NavItem(
                        label: 'Supplier Bill',
                        route: Routes.supplierBill,
                        isChild: true,
                        isActive: currentRoute == Routes.supplierBill,
                      ),
                      _NavItem(
                        label: 'Purchase Order',
                        route: Routes.purchaseOrder,
                        isChild: true,
                        isActive: currentRoute == Routes.purchaseOrder,
                      ),
                      _NavItem(
                        label: 'Purchase Debit Note',
                        route: Routes.purchaseReturn,
                        isChild: true,
                        isActive: currentRoute == Routes.purchaseReturn,
                      ),
                    ],
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.users,
                    label: 'CRM',
                    children: [
                      _NavItem(
                        label: 'Coupon',
                        route: Routes.coupon,
                        isChild: true,
                        isActive: currentRoute == Routes.coupon,
                      ),
                      _NavItem(
                        label: 'Loyalty',
                        route: Routes.loyalty,
                        isChild: true,
                        isActive: currentRoute == Routes.loyalty,
                      ),
                      _NavItem(
                        label: 'Discount',
                        route: Routes.discount,
                        isChild: true,
                        isActive: currentRoute == Routes.discount,
                      ),
                    ],
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.chartLine,
                    label: 'Sales',
                    children: [
                      _NavItem(
                        label: 'Estimate',
                        route: Routes.estimate,
                        isChild: true,
                        isActive: currentRoute == Routes.estimate,
                      ),
                      _NavItem(
                        label: 'Sales Order',
                        route: Routes.salesOrder,
                        isChild: true,
                        isActive: currentRoute == Routes.salesOrder,
                      ),
                      _NavItem(
                        label: 'Invoice',
                        route: Routes.invoice,
                        isChild: true,
                        isActive: currentRoute == Routes.invoice,
                      ),
                      _NavItem(
                        label: 'Delivery Challan',
                        route: Routes.deliveryChallan,
                        isChild: true,
                        isActive: currentRoute == Routes.deliveryChallan,
                      ),
                      _NavItem(
                        label: 'Sales Credit Note',
                        route: Routes.salesCreditNote,
                        isChild: true,
                        isActive: currentRoute == Routes.salesCreditNote,
                      ),
                    ],
                  ),
                  _NavItem(
                    icon: PhosphorIconsLight.user,
                    label: 'User',
                    route: Routes.user,
                    isActive: currentRoute == Routes.user,
                  ),
                  _NavItem(
                    icon: PhosphorIconsLight.addressBook,
                    label: 'Contact',
                    route: Routes.contact,
                    isActive: currentRoute == Routes.contact,
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.gear,
                    label: 'Settings',
                    children: [_NavItem(label: 'General Settings', route: '')],
                  ),
                  _ExpandableSection(
                    icon: PhosphorIconsLight.bank,
                    label: 'Bank / Cash',
                    children: [
                      _NavItem(
                        label: 'Bank',
                        route: Routes.bank,
                        isChild: true,
                        isActive: currentRoute == Routes.bank,
                      ),
                      _NavItem(
                        label: 'Bank Transaction',
                        route: Routes.bankTransaction,
                        isChild: true,
                        isActive: currentRoute == Routes.bankTransaction,
                      ),
                      _NavItem(
                        label: 'Payment',
                        route: Routes.posPayment,
                        isChild: true,
                        isActive: currentRoute == Routes.posPayment,
                      ),
                      _NavItem(
                        label: 'Receipt',
                        route: Routes.receipt,
                        isChild: true,
                        isActive: currentRoute == Routes.receipt,
                      ),
                      _NavItem(
                        label: 'Expense',
                        route: Routes.expense,
                        isChild: true,
                        isActive: currentRoute == Routes.expense,
                      ),
                      _NavItem(
                        label: 'Salary',
                        route: Routes.salary,
                        isChild: true,
                        isActive: currentRoute == Routes.salary,
                      ),
                    ],
                  ),
                  const Gap(24),
                ],
              ),
            ),

            // ── Footer ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: isDark ? colors.surface : _footerBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Want insider tips & updates?',
                      textAlign: TextAlign.center,
                      style: TextHelper.bodyMedium.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Follow us:',
                      style: TextHelper.bodyMedium.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIcon(icon: PhosphorIconsLight.instagramLogo),
                        const Gap(12),
                        _SocialIcon(icon: PhosphorIconsLight.facebookLogo),
                        const Gap(12),
                        _SocialIcon(icon: PhosphorIconsLight.youtubeLogo),
                        const Gap(12),
                        _SocialIcon(icon: PhosphorIconsLight.x),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Nav Item ──
class _NavItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String route;
  final bool isActive;
  final bool isChild;

  const _NavItem({
    this.icon,
    required this.label,
    required this.route,
    this.isActive = false,
    this.isChild = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = ThemeService().isDarkMode;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        if (Get.currentRoute != route) Get.toNamed(route);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding: EdgeInsets.symmetric(
          horizontal: isChild ? 32 : 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? (isDark ? AppColors.primary : AppDrawer._activeBg)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isActive
                    ? (isDark ? Colors.white : AppDrawer._activeFg)
                    : colors.textSecondary,
                size: 22,
              ),
              const Gap(12),
            ],
            Text(
              label,
              style: TextHelper.bodyMedium.copyWith(
                color: isActive
                    ? (isDark ? Colors.white : AppDrawer._activeFg)
                    : colors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Expandable Section ──
class _ExpandableSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Widget> children;

  const _ExpandableSection({
    required this.icon,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: colors.textSecondary, size: 22),
        title: Text(
          label,
          style: TextHelper.bodyMedium.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: colors.textSecondary,
        collapsedIconColor: colors.textSecondary,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16 + 12),
        childrenPadding: EdgeInsets.zero,
        children: children,
      ),
    );
  }
}

// ── Social Icon ──
class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = ThemeService().isDarkMode;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? colors.background : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: colors.border.withOpacity(0.5)),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Icon(
        icon,
        color: isDark ? Colors.white : AppColors.primary,
        size: 20,
      ),
    );
  }
}
