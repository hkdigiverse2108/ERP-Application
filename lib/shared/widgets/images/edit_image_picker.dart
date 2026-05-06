import 'dart:io';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/dialogs/confirm_dialog.dart';
import 'package:ai_setu/shared/widgets/images/image_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditImagePicker extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final String? label;

  const EditImagePicker({
    super.key,
    this.imagePath,
    required this.onPickImage,
    required this.onRemoveImage,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onPickImage,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: context.appColors.background,
                  border: Border.all(color: context.appColors.border),
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
                child: imagePath == null
                    ? Icon(
                        PhosphorIconsLight.plus,
                        size: 32,
                        color: context.appColors.textSecondary,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Sizes.borderRadiusM,
                        ),
                        child: Hero(
                          tag: imagePath!,
                          child: imagePath!.startsWith('http')
                              ? Image.network(imagePath!, fit: BoxFit.cover)
                              : Image.file(File(imagePath!), fit: BoxFit.cover),
                        ),
                      ),
              ),
            ),
            const Gap(Sizes.defHorizontalSpace),
            if (imagePath != null) ...[
              IconButton(
                onPressed: () => Get.to(
                  () => ImageViewerPage(
                    imageUrl: imagePath!,
                    title: label ?? "Preview",
                  ),
                ),
                icon: Icon(
                  PhosphorIconsLight.eye,
                  color: context.appColors.primary,
                ),
                tooltip: "Preview Image",
              ),
              IconButton(
                onPressed: () {
                  ConfirmDialog.show(
                    title: "Remove Image",
                    message: "Are you sure you want to remove this image?",
                    confirmText: "Remove",
                    confirmColor: Colors.red,
                    onConfirm: onRemoveImage,
                  );
                },
                icon: const Icon(PhosphorIconsLight.trash, color: Colors.red),
                tooltip: "Remove Image",
              ),
            ],
          ],
        ),
        const Gap(Sizes.paddingS),
        Text(
          imagePath == null
              ? (label ?? "Tap to select an image")
              : "Tap to change image",
          style: TextHelper.bodySmallStyle(
            context,
          ).copyWith(color: context.appColors.textSecondary),
        ),
      ],
    );
  }
}
