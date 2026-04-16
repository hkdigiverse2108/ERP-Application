import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/permission_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionService = PermissionService.to;

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
            child: Obx(() {
              if (permissionService.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final tabs = permissionService.permittedTabs;
              if (tabs.isEmpty) {
                return Center(
                  child: Text(
                    'No Permitted Tabs',
                    style: TextHelper.bodySmallStyle(context),
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingS),
                children: [
                  _buildSectionLabel(context, 'MENU'),
                  ...tabs.map((tab) => _buildMenuItem(context, tab)),
                  const Gap(Sizes.lgVerticalSpace),
                ],
              );
            }),
          ),

          // Footer
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, PermissionModel tab) {
    if (!tab.view) return const SizedBox.shrink();

    final icon = _getIconForTab(tab.tabName);

    if (tab.children.isNotEmpty) {
      return _ExpandableMenuItem(
        icon: icon,
        label: tab.displayName,
        items: tab.children,
      );
    }

    return _MenuItem(
      icon: icon,
      label: tab.displayName,
      isActive: Get.currentRoute == tab.tabUrl,
      onTap: () {
        Get.back(); // Close drawer
        if (Get.currentRoute != tab.tabUrl) {
          Get.toNamed(tab.tabUrl);
        }
      },
    );
  }

  IconData _getIconForTab(String tabName) {
    switch (tabName.toLowerCase()) {
      case 'dashboard':
        return PhosphorIconsFill.squaresFour;
      case 'user':
        return PhosphorIconsLight.users;
      case 'contact':
        return PhosphorIconsLight.user;
      case 'inventory':
        return PhosphorIconsLight.package;
      case 'bank / cash':
      case 'bank':
      case 'cash':
        return PhosphorIconsLight.bank;
      case 'pos':
        return PhosphorIconsLight.shoppingCart;
      case 'purchase':
        return PhosphorIconsLight.receipt;
      case 'support':
        return PhosphorIconsLight.headset;
      case 'settings':
        return PhosphorIconsLight.gear;
      case 'accounting':
        return PhosphorIconsLight.calculator;
      case 'crm':
        return PhosphorIconsLight.usersThree;
      default:
        return PhosphorIconsLight.circlesThree;
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingM),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.appColors.primary,
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
              color: context.appColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
              border: Border.all(
                color: context.appColors.primary.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Want Insider Tips \$ Updates?',
                  textAlign: TextAlign.center,
                  style: TextHelper.bodySmallStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.primary,
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
    final activeColor = context.appColors.primary;
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
  final List<PermissionModel> items;

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
        children: items.map((subTab) {
          if (!subTab.view) return const SizedBox.shrink();
          final isActive = Get.currentRoute == subTab.tabUrl;

          return ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 48),
            title: Row(
              children: [
                Icon(
                  PhosphorIconsLight.arrowBendDownRight,
                  size: 14,
                  color: isActive 
                      ? context.appColors.primary 
                      : textColor.withValues(alpha: 0.6),
                ),
                const Gap(8),
                Text(
                  subTab.displayName,
                  style: TextHelper.bodySmallStyle(context).copyWith(
                    color: isActive ? context.appColors.primary : textColor,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.back(); // Close drawer
              if (Get.currentRoute != subTab.tabUrl) {
                Get.toNamed(subTab.tabUrl);
              }
            },
          );
        }).toList(),
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
