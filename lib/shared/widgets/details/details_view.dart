import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DetailAction {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  DetailAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });
}

class DetailSection {
  final String title;
  final List<Widget> children;
  final Widget? trailing;

  DetailSection({required this.title, required this.children, this.trailing});
}

class DetailsView extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? status;
  final Color? statusColor;
  final IconData? heroIcon;
  final List<DetailAction>? actions;
  final List<DetailSection> sections;
  final Widget? bottomWidget;

  const DetailsView({
    super.key,
    required this.title,
    this.subtitle,
    this.status,
    this.statusColor,
    this.heroIcon,
    this.actions,
    required this.sections,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final surfaceColor = context.responsive(
      light: AppColors.lightSurface,
      dark: AppColors.darkSurface,
    );
    final borderColor = context.responsive(
      light: AppColors.lightBorder,
      dark: AppColors.darkBorder,
    );

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const DefAppBar(),
        body: Column(
          children: [
            const QuickAction(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(24),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildPremiumBanner(context, isDark),
                        Positioned(
                          bottom: -40,
                          left: Sizes.paddingM,
                          right: Sizes.paddingM,
                          child: _buildHeroCard(context, isDark),
                        ),
                      ],
                    ),
                    const Gap(40), // Account for the floating card overlap
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.paddingM,
                      ),
                      child: Column(
                        children: [
                          ...sections.map(
                            (section) => _buildSection(
                              context,
                              section,
                              surfaceColor,
                              borderColor,
                            ),
                          ),
                          if (bottomWidget != null) ...[
                            const Gap(Sizes.paddingL),
                            bottomWidget!,
                          ],
                        ],
                      ),
                    ),
                    const Gap(Sizes.paddingL),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBanner(BuildContext context, bool isDark) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  context.appColors.primary.withValues(alpha: 0.8),
                  context.appColors.primary.withValues(alpha: 0.4),
                ]
              : [
                  context.appColors.primary,
                  context.appColors.primary.withValues(alpha: 0.7),
                ],
        ),
      ),
      child: Stack(
        children: [
          if (heroIcon != null)
            Positioned(
              right: -30,
              top: -30,
              child: Icon(
                heroIcon,
                size: 220,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, bool isDark) {
    final surfaceColor = isDark
        ? context.appColors.surface
        : context.appColors.background;
    final borderColor = context.appColors.primary.withValues(alpha: 0.1);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (status != null) ...[
                _buildStatusBadge(context),
                const Gap(16),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextHelper.h3.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: context.appColors.textPrimary,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const Gap(6),
                          Text(
                            subtitle!,
                            style: TextHelper.bodyMedium.copyWith(
                              color: context.appColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (heroIcon != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.appColors.primary.withValues(
                          alpha: 0.08,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        heroIcon,
                        size: 32,
                        color: context.appColors.primary,
                      ),
                    ),
                ],
              ),
              if (actions != null && actions!.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(
                    height: 1,
                    color: context.appColors.textPrimary.withValues(alpha: 0.1),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: actions!
                      .map((action) => _buildActionButton(action, context))
                      .toList(),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final color = statusColor ?? context.appColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Text(
        status!.toUpperCase(),
        style: TextHelper.caption.copyWith(
          color: statusColor ?? context.appColors.primary,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildActionButton(DetailAction action, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: (action.color ?? context.appColors.primary).withValues(
              alpha: 0.1,
            ),
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
            border: Border.all(
              color: (action.color ?? context.appColors.primary).withValues(
                alpha: 0.3,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                action.icon,
                size: 18,
                color: action.color ?? context.appColors.primary,
              ),
              const Gap(8),
              Text(
                action.label,
                style: TextHelper.bodySmall.copyWith(
                  color: action.color ?? context.appColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    DetailSection section,
    Color surfaceColor,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12, top: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section.title,
                style: TextHelper.h4.copyWith(fontWeight: FontWeight.w900),
              ),
              if (section.trailing != null) section.trailing!,
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Sizes.paddingM),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
            border: Border.all(color: borderColor.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: section.children,
          ),
        ),
      ],
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? color;
  final bool isCopyable;

  const DetailItem({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.color,
    this.isCopyable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: context.appColors.primary.withValues(alpha: 0.6),
              ),
            ),
            const Gap(12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextHelper.caption.copyWith(
                    color: context.appColors.textSecondary.withValues(
                      alpha: 0.7,
                    ),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    fontSize: 9,
                  ),
                ),
                const Gap(4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: TextHelper.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: color ?? context.appColors.textPrimary,
                          height: 1.3,
                        ),
                      ),
                    ),
                    if (isCopyable)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Copy to clipboard logic
                            Get.snackbar(
                              'Copied',
                              '$label copied to clipboard',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: context.appColors.primary,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 1),
                              margin: const EdgeInsets.all(16),
                            );
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              PhosphorIconsLight.copy,
                              size: 14,
                              color: context.appColors.primary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataGrid extends StatelessWidget {
  final List<DetailItem> items;
  final int crossAxisCount;

  const DataGrid({super.key, required this.items, this.crossAxisCount = 2});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth < 600 ? 1 : crossAxisCount;
        return Wrap(
          children: items.map((item) {
            return SizedBox(width: constraints.maxWidth / count, child: item);
          }).toList(),
        );
      },
    );
  }
}
