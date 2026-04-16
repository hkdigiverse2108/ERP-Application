import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTagInput extends StatelessWidget {
  final String label;
  final RxList<String> tags;
  final TextEditingController controller;
  final String hint;

  const CustomTagInput({
    super.key,
    required this.label,
    required this.tags,
    required this.controller,
    this.hint = "Type and press enter or comma...",
  });

  void _addTag(String value) {
    String tag = value.trim();
    if (tag.endsWith(',')) {
      tag = tag.substring(0, tag.length - 1).trim();
    }
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
    }
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextHelper.bodySmallStyle(
            context,
          ).copyWith(color: context.appColors.textSecondary),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: context.appColors.surface,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
            border: Border.all(color: context.appColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => tags.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: tags.asMap().entries.map((entry) {
                            return InputChip(
                              label: Text(
                                entry.value,
                                style: TextHelper.bodySmallStyle(context)
                                    .copyWith(
                                      color: context.appColors.textPrimary,
                                    ),
                              ),
                              backgroundColor: context.appColors.primary
                                  .withValues(alpha: 0.1),
                              deleteIcon: Icon(
                                Icons.close,
                                size: 14,
                                color: context.appColors.textSecondary,
                              ),
                              onDeleted: () => tags.removeAt(entry.key),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide.none,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ),
              TextField(
                controller: controller,
                onSubmitted: _addTag,
                onChanged: (value) {
                  if (value.endsWith(',')) {
                    _addTag(value);
                  }
                },
                style: TextHelper.bodyMediumStyle(context),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextHelper.bodySmallStyle(context).copyWith(
                    color: context.appColors.textSecondary.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
