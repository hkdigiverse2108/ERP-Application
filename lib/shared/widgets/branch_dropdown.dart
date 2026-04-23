import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BranchDropdown extends StatelessWidget {
  final ValueChanged<BranchDropdownModel?>? onChanged;

  const BranchDropdown({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BranchController>();

    return Obx(() {
      if (!controller.isMainBranch) return const SizedBox.shrink();

      final selectedBranchName =
          controller.selectedBranch.value?.name ?? "All Branches";
      final availableBranches = controller.availableBranches;

      return PopupMenuButton<BranchDropdownModel?>(
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (BranchDropdownModel? value) {
          controller.selectBranch(value);
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            enabled: false,
            child: Text(
              "Select Branch",
              style: context.textTheme.labelSmall?.copyWith(
                color: context.appColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<BranchDropdownModel?>(
            value: null,
            child: Row(
              children: [
                const Icon(PhosphorIconsLight.storefront, size: 18),
                const SizedBox(width: 10),
                const Text(
                  "All Branches",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          if (availableBranches.isEmpty && controller.isLoading.value)
            const PopupMenuItem(
              enabled: false,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else if (availableBranches.isEmpty)
            const PopupMenuItem(
              enabled: false,
              child: Text("No branches available"),
            ),
          ...availableBranches.map((e) => _buildPopupItem(e)),
        ],
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.paddingS,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                PhosphorIconsFill.storefront,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(width: Sizes.paddingS),
              Flexible(
                child: Text(
                  selectedBranchName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.textSizeM,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: Sizes.paddingS / 2),
              const Icon(
                PhosphorIconsFill.caretDown,
                size: 14,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      );
    });
  }

  PopupMenuItem<BranchDropdownModel> _buildPopupItem(
    BranchDropdownModel branch,
  ) {
    return PopupMenuItem<BranchDropdownModel>(
      value: branch,
      child: Row(
        children: [
          const Icon(PhosphorIconsLight.storefront, size: 18),
          const SizedBox(width: 10),
          Text(
            branch.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
