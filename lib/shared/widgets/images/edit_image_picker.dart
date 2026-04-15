import 'dart:io';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
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
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
                child: imagePath == null
                    ? Icon(
                        PhosphorIconsLight.plus,
                        size: 32,
                        color: Colors.grey,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Sizes.borderRadiusM,
                        ),
                        child: GetPlatform.isWeb
                            ? Image.network(imagePath!, fit: BoxFit.cover)
                            : Image.file(File(imagePath!), fit: BoxFit.cover),
                      ),
              ),
            ),
            const Gap(Sizes.defHorizontalSpace),
            if (imagePath != null)
              IconButton(
                onPressed: onRemoveImage,
                icon: Icon(PhosphorIconsLight.trash, color: Colors.red),
              ),
          ],
        ),
        const Gap(Sizes.paddingS),
        Text(
          imagePath == null
              ? (label ?? "Tap to select an image")
              : "Tap to change image",
          style: TextHelper.bodySmall,
        ),
      ],
    );
  }
}
