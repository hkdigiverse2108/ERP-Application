import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/quick_action/controllers/quick_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class QuickSearchView extends GetView<QuickSearchController> {
  const QuickSearchView({super.key});

  IconData _getIconForSection(String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'dashboard':
        return PhosphorIconsFill.houseLine;
      case 'inventory':
        return PhosphorIconsFill.package;
      case 'accounting':
        return PhosphorIconsFill.calculator;
      case 'pos':
        return PhosphorIconsFill.cashRegister;
      case 'purchase':
        return PhosphorIconsFill.shoppingCart;
      case 'crm':
        return PhosphorIconsFill.users;
      case 'sales':
        return PhosphorIconsFill.chartLine;
      case 'user':
        return PhosphorIconsFill.user;
      case 'contact':
        return PhosphorIconsFill.addressBook;
      case 'settings':
        return PhosphorIconsFill.gear;
      default:
        return PhosphorIconsFill.list;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = ThemeService().isDarkMode;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: colors.background,
          elevation: 0,
          leading: IconButton(
            icon: Icon(PhosphorIconsBold.caretLeft, color: colors.textPrimary),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Quick Navigation',
            style: TextHelper.h3.copyWith(color: colors.textPrimary),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // ── Search Bar ──
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? colors.surface : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.5),
                  ),
                ),
                child: TextField(
                  autofocus: true,
                  style: TextHelper.bodyMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                  onChanged: (value) => controller.searchQuery.value = value,
                  decoration: InputDecoration(
                    hintText: 'Search for pages, reports, tools...',
                    hintStyle: TextHelper.bodyMedium.copyWith(
                      color: colors.textSecondary,
                    ),
                    prefixIcon: Icon(
                      PhosphorIconsBold.magnifyingGlass,
                      color: colors.textSecondary,
                      size: 20,
                    ),
                    suffixIcon: Obx(
                      () => controller.searchQuery.value.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                PhosphorIconsFill.xCircle,
                                color: colors.textSecondary,
                              ),
                              onPressed: () => controller.clearSearch(),
                            )
                          : const SizedBox.shrink(),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // ── Results List ──
            Expanded(
              child: Obx(() {
                if (controller.groupedResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsLight.magnifyingGlass,
                          size: 64,
                          color: colors.textSecondary.withValues(alpha: 0.3),
                        ),
                        const Gap(16),
                        Text(
                          'No results found',
                          style: TextHelper.h4.copyWith(
                            color: colors.textSecondary.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final groups = controller.groupedResults.keys.toList();
                groups.sort(); // Consistent order

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final groupName = groups[index];
                    final items = controller.groupedResults[groupName]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Header
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 8,
                            left: 4,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getIconForSection(groupName),
                                size: 18,
                                color: colors.primary,
                              ),
                              const Gap(8),
                              Text(
                                groupName.toUpperCase(),
                                style: TextHelper.caption.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Section Items
                        ...items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => controller.navigateTo(item),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: colors.border.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.displayName,
                                              style: TextHelper.bodyLarge
                                                  .copyWith(
                                                    color: colors.textPrimary,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            if (item.parentName.isNotEmpty)
                                              Text(
                                                'In ${item.parentName}',
                                                style: TextHelper.caption
                                                    .copyWith(
                                                      color:
                                                          colors.textSecondary,
                                                    ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        PhosphorIconsBold.caretRight,
                                        size: 16,
                                        color: colors.textSecondary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(8),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
