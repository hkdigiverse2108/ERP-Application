import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/permission_model.dart';
import 'package:ai_setu/modules/user/permission/controllers/user_permission_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UserPermissionView extends GetView<UserPermissionController> {
  const UserPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        bottomNavigationBar: _buildBottomActions(context),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final grouped = controller.groupedPermissions;

          return Column(
            children: [
              const QuickAction(),
              const Gap(Sizes.paddingS),
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(Sizes.paddingM),
                child: AppSearchBar(
                  hint: "Search tabs or categories...",
                  onChanged: (val) => controller.searchQuery.value = val,
                ),
              ),
              _buildBulkToggleActions(context),
              Expanded(
                child: grouped.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.paddingM,
                          vertical: Sizes.paddingS,
                        ),
                        itemCount: grouped.length,
                        itemBuilder: (context, index) {
                          final category = grouped.keys.elementAt(index);
                          final items = grouped[category]!;
                          return _buildCategorySection(
                            context,
                            category,
                            items,
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsLight.magnifyingGlass,
            size: 48,
            color: context.appColors.textSecondary.withValues(alpha: 0.5),
          ),
          const Gap(Sizes.paddingS),
          Text(
            "No results found for \"${controller.searchQuery.value}\"",
            style: TextHelper.bodyMediumStyle(
              context,
            ).copyWith(color: context.appColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.appColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
            ),
            child: Icon(
              PhosphorIconsLight.shieldCheck,
              color: context.appColors.primary,
              size: 28,
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Permissions",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Managing: ${controller.user?.fullName ?? 'User'}",
                  style: TextHelper.captionStyle(
                    context,
                  ).copyWith(color: context.appColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkToggleActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      padding: const EdgeInsets.all(Sizes.paddingS),
      decoration: BoxDecoration(
        color: context.appColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        border: Border.all(
          color: context.appColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBulkButton(context, "View", 'view'),
          _buildBulkButton(context, "Add", 'add'),
          _buildBulkButton(context, "Edit", 'edit'),
          _buildBulkButton(context, "Delete", 'delete'),
        ],
      ),
    );
  }

  Widget _buildBulkButton(BuildContext context, String label, String type) {
    return PopupMenuButton<bool>(
      offset: const Offset(0, 40),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextHelper.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.primary,
            ),
          ),
          Icon(
            PhosphorIconsLight.caretDown,
            size: 14,
            color: context.appColors.primary,
          ),
        ],
      ),
      onSelected: (val) => controller.toggleAll(type, val),
      itemBuilder: (context) => [
        const PopupMenuItem(value: true, child: Text("Allow All")),
        const PopupMenuItem(value: false, child: Text("Deny All")),
      ],
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String category,
    List<PermissionModel> items,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.paddingS),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  decoration: BoxDecoration(
                    color: context.appColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Gap(8),
                Text(
                  category.toUpperCase(),
                  style: TextHelper.bodySmall.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: context.appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          BorderContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildTableHeader(context),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return _buildPermissionRow(context, items[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: Sizes.paddingS,
      ),
      decoration: BoxDecoration(
        color: context.appColors.surface.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.borderRadiusM),
        ),
      ),
      child: Row(
        children: [
          const Expanded(flex: 3, child: SizedBox()),
          _buildHeaderIcon(PhosphorIconsLight.eye, "View"),
          _buildHeaderIcon(PhosphorIconsLight.plus, "Add"),
          _buildHeaderIcon(PhosphorIconsLight.pencilSimple, "Edit"),
          _buildHeaderIcon(PhosphorIconsLight.trash, "Delete"),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, String tooltip) {
    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: Icon(
          icon,
          size: 18,
          color: Get.context!.appColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildPermissionRow(BuildContext context, PermissionModel permission) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: Sizes.paddingS,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  permission.displayName,
                  style: TextHelper.bodyMediumStyle(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  permission.tabUrl,
                  style: TextHelper.captionStyle(context).copyWith(
                    color: context.appColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          _buildCheckbox(permission.id, 'view', permission.view),
          _buildCheckbox(permission.id, 'add', permission.add),
          _buildCheckbox(permission.id, 'edit', permission.edit),
          _buildCheckbox(permission.id, 'delete', permission.delete),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String id, String type, bool value) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: () => controller.togglePermission(id, type, !value),
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: value
                  ? Get.context!.appColors.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              value ? PhosphorIconsFill.checkSquare : PhosphorIconsLight.square,
              size: 24,
              color: value
                  ? Get.context!.appColors.primary
                  : Get.context!.appColors.textSecondary.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(top: BorderSide(color: context.appColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: Text(
                "Discard Changes",
                style: TextHelper.bodyMediumStyle(context).copyWith(
                  color: context.appColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : () => controller.savePermissions(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                ),
                child: controller.isSaving.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(PhosphorIconsFill.floppyDisk, size: 18),
                          const Gap(8),
                          Text(
                            "Save Changes",
                            style: TextHelper.bodyMediumStyle(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
