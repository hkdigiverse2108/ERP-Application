import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/helper/route_resolver.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/data/model/permission_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ai_setu/shared/widgets/dialogs/logout_confirmation_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _showLogoutDialog(BuildContext context) {
    LogoutConfirmationDialog.show();
  }

  static const Color _activeBg = Color(0xFFE8F0FF);
  static const Color _activeFg = Color(0xFF3D5AFE);
  static const Color _footerBg = Color(0xFFF4F7FA);

  IconData _getIconForTab(String tabName) {
    switch (tabName.toLowerCase()) {
      case 'dashboard':
        return PhosphorIconsLight.houseLine;
      case 'inventory':
        return PhosphorIconsLight.package;
      case 'accounting':
        return PhosphorIconsLight.calculator;
      case 'pos':
        return PhosphorIconsLight.cashRegister;
      case 'purchase':
        return PhosphorIconsLight.shoppingCart;
      case 'crm':
        return PhosphorIconsLight.users;
      case 'sales':
        return PhosphorIconsLight.chartLine;
      case 'user':
        return PhosphorIconsLight.user;
      case 'contact':
        return PhosphorIconsLight.addressBook;
      case 'settings':
        return PhosphorIconsLight.gear;
      case 'bank / cash':
      case 'bank':
        return PhosphorIconsLight.bank;
      default:
        return PhosphorIconsLight.list;
    }
  }

  List<Widget> _buildMenu(
    List<PermissionModel> tabs,
    String currentRoute,
    String activeTabId, {
    bool isChild = false,
  }) {
    final List<Widget> items = [];

    for (final tab in tabs) {
      if (!tab.view) continue;

      if (tab.children.isNotEmpty) {
        // ── Parent / group node ──
        final childWidgets = _buildMenu(
          tab.children,
          currentRoute,
          activeTabId,
          isChild: true,
        );
        if (childWidgets.isNotEmpty) {
          items.add(
            _ExpandableSection(
              icon: _getIconForTab(tab.tabName),
              label: tab.displayName,
              children: childWidgets,
            ),
          );
        }
      } else {
        // ── Leaf node ──
        // RouteResolver.resolve() returns the correct GetX route for this tab,
        // handling collisions where multiple tabs share the same tabUrl.
        // If the tab has no mapping and no tabUrl it is not navigable (skip it).
        if (!RouteResolver.isNavigable(tab)) continue;

        final resolvedRoute = RouteResolver.resolve(tab);

        // Active check uses the tab's unique _id, not the route string.
        // This prevents two tabs with the same tabUrl both lighting up.
        final isActive = activeTabId.isNotEmpty
            ? activeTabId == tab.id
            : currentRoute == resolvedRoute;

        items.add(
          _NavItem(
            tabId: tab.id,
            icon: isChild ? null : _getIconForTab(tab.tabName),
            label: tab.displayName,
            route: resolvedRoute, // ← the GetX route that will actually open
            isActive: isActive,
            isChild: isChild,
          ),
        );
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = ThemeService().isDarkMode;
    final permissionService = PermissionService.to;

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
              child: Obx(() {
                if (permissionService.permittedTabs.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // activeTabId drives which item is highlighted.
                // _NavItem.onTap writes to this; cleared when route changes externally.
                final activeTabId = permissionService.activeTabId.value;
                final currentRoute = Get.currentRoute;

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ..._buildMenu(
                      permissionService.permittedTabs,
                      currentRoute,
                      activeTabId,
                    ),
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListTile(
                        onTap: () => _showLogoutDialog(context),
                        leading: const Icon(
                          PhosphorIconsLight.signOut,
                          color: Colors.red,
                          size: 22,
                        ),
                        title: Text(
                          'Logout',
                          style: TextHelper.bodyMedium.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Gap(24),
                  ],
                );
              }),
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

// ── Nav Item ──────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final String tabId;
  final IconData? icon;
  final String label;
  final String route; // the resolved GetX route — what actually opens
  final bool isActive;
  final bool isChild;

  const _NavItem({
    required this.tabId,
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
        if (route.isNotEmpty) {
          // Store which tab was tapped so the drawer can highlight exactly
          // this item — even when two tabs resolve to different routes but
          // share the same tabUrl.
          PermissionService.to.activeTabId.value = tabId;
          Get.toNamed(route);
        }
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
              ? (isDark ? context.appColors.primary : AppDrawer._activeBg)
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
            Expanded(
              child: Text(
                label,
                style: TextHelper.bodyMedium.copyWith(
                  color: isActive
                      ? (isDark ? Colors.white : AppDrawer._activeFg)
                      : colors.textSecondary,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Expandable Section ────────────────────────────────────────────────────────

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

// ── Social Icon ───────────────────────────────────────────────────────────────

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
        border: Border.all(color: colors.border.withValues(alpha: 0.5)),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Icon(
        icon,
        color: isDark ? Colors.white : context.appColors.primary,
        size: 20,
      ),
    );
  }
}
