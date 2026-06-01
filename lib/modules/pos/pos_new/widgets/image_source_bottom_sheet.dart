import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final Function(ImageSource) onSourceSelected;
  final VoidCallback? onRemove;
  final bool hasImage;

  const ImageSourceBottomSheet({
    super.key,
    required this.onSourceSelected,
    this.onRemove,
    this.hasImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.borderRadiusXL),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Image Source",
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
          const Gap(24),
          Row(
            children: [
              Expanded(
                child: _buildSourceOption(
                  context,
                  icon: Icons.photo_library_outlined,
                  label: "Select Image",
                  onTap: () {
                    Get.back();
                    onSourceSelected(ImageSource.gallery);
                  },
                ),
              ),
              const Gap(16),
              Expanded(
                child: _buildSourceOption(
                  context,
                  icon: Icons.camera_alt_outlined,
                  label: "Take a Picture",
                  onTap: () {
                    Get.back();
                    onSourceSelected(ImageSource.camera);
                  },
                ),
              ),
            ],
          ),
          if (hasImage && onRemove != null) ...[
            const Gap(16),
            const Divider(),
            const Gap(8),
            TextButton.icon(
              onPressed: () {
                Get.back();
                onRemove!();
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text(
                "Remove Image",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSourceOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          border: Border.all(color: context.appColors.border),
          color: context.appColors.primary.withValues(alpha: 0.02),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: context.appColors.primary),
            const Gap(12),
            Text(
              label,
              style: TextHelper.bodyMediumStyle(context).copyWith(
                fontWeight: FontWeight.w600,
                color: context.appColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
