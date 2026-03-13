import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.responsive(
        light: AppColors.lightSurface,
        dark: AppColors.darkSurface,
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(context),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingS),
              children: [
                _buildSectionLabel(context, 'MENU'),
                _MenuItem(
                  icon: PhosphorIconsFill.squaresFour,
                  label: 'Dashboard',
                  isActive: true, // Mocking active state
                  onTap: () => Get.back(),
                ),
                _MenuItem(
                  icon: PhosphorIconsLight.users,
                  label: 'User',
                  onTap: () => Get.back(),
                ),
                _MenuItem(
                  icon: PhosphorIconsLight.user,
                  label: 'Contact',
                  onTap: () => Get.back(),
                ),
                _ExpandableMenuItem(
                  icon: PhosphorIconsLight.gear,
                  label: 'Inventory',
                  items: const ['Items', 'Categories', 'Brands'],
                ),
                _ExpandableMenuItem(
                  icon: PhosphorIconsLight.bank,
                  label: 'Bank / Cash',
                  items: const ['Accounts', 'Transactions'],
                ),
                _ExpandableMenuItem(
                  icon: PhosphorIconsLight.bag,
                  label: 'POS',
                  items: const ['New Sale', 'Sales History'],
                ),
                _ExpandableMenuItem(
                  icon: PhosphorIconsLight.receipt,
                  label: 'Purchase',
                  items: const ['Orders', 'Suppliers'],
                ),
                _MenuItem(
                  icon: PhosphorIconsLight.headset,
                  label: 'Support',
                  onTap: () => Get.back(),
                ),
                _ExpandableMenuItem(
                  icon: PhosphorIconsLight.gear,
                  label: 'Settings',
                  items: const ['General Setting', 'Profile'],
                ),
                const Gap(Sizes.lgVerticalSpace),
              ],
            ),
          ),

          // Footer
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingM),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
            ),
            child: Image.asset(
              Images.lightAiLogo,
              height: 24,
              width: 24,
              color: Colors.white,
            ),
          ),
          const Gap(Sizes.paddingS),
          Text(
            'TailAdmin', // Matches the image, but maybe we should use 'AI Setu'?
            style: TextHelper.h3Style(context).copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.paddingS,
        top: Sizes.paddingM,
        bottom: Sizes.paddingS,
      ),
      child: Text(
        label,
        style: TextHelper.caption.copyWith(
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
          color: context.responsive(
            light: AppColors.lightTextSecondary,
            dark: AppColors.darkTextSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingM),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Sizes.paddingM),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Want Insider Tips \$ Updates?',
                  textAlign: TextAlign.center,
                  style: TextHelper.bodySmallStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const Gap(8),
                Text(
                  'Follow Us:',
                  style: TextHelper.caption.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(Sizes.paddingS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SocialIcon(iconPath: PhosphorIconsFill.facebookLogo, color: const Color(0xFF1877F2)),
                    _SocialIcon(iconPath: PhosphorIconsFill.instagramLogo, color: const Color(0xFFE4405F)),
                    _SocialIcon(iconPath: PhosphorIconsFill.linkedinLogo, color: const Color(0xFF0A66C2)),
                    _SocialIcon(iconPath: PhosphorIconsFill.xLogo, color: Colors.black87),
                  ],
                ),
              ],
            ),
          ),
          const Gap(Sizes.paddingS),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor = context.responsive(
      light: AppColors.lightTextSecondary.withValues(alpha: 0.8),
      dark: AppColors.darkTextSecondary.withValues(alpha: 0.8),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? activeColor.withValues(alpha: 0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
        border: isActive 
          ? Border(left: BorderSide(color: activeColor, width: 3))
          : null,
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        leading: Icon(
          icon,
          color: isActive ? activeColor : inactiveColor,
          size: 20,
        ),
        title: Text(
          label,
          style: TextHelper.bodyMediumStyle(context).copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}

class _ExpandableMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> items;

  const _ExpandableMenuItem({
    required this.icon,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = context.responsive(
      light: AppColors.lightTextSecondary,
      dark: AppColors.darkTextSecondary,
    );

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: Sizes.paddingS),
        leading: Icon(icon, color: textColor, size: 20),
        title: Text(
          label,
          style: TextHelper.bodyMediumStyle(context).copyWith(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing: Icon(
          PhosphorIconsLight.caretDown,
          size: 16,
          color: textColor,
        ),
        children: items.map((item) => ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(left: 48),
          title: Row(
            children: [
              Icon(
                PhosphorIconsLight.arrowBendDownRight,
                size: 14,
                color: textColor.withValues(alpha: 0.6),
              ),
              const Gap(8),
              Text(
                item,
                style: TextHelper.bodySmallStyle(context).copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
          onTap: () => Get.back(),
        )).toList(),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData iconPath;
  final Color color;

  const _SocialIcon({required this.iconPath, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Icon(iconPath, size: 18, color: color),
    );
  }
}
