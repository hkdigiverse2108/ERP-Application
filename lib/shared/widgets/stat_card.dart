import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final int value;
  final String title;
  final String? tag;
  final Color? color;

  const StatCard({
    super.key,
    required this.value,
    required this.title,
    this.tag,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cardColor =
          color ??
          context.responsive(
            light: AppColors.lightBackground,
            dark: AppColors.darkBackground,
          );
      return Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (tag == null) ? value.toString() : "$tag $value",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(title, style: TextHelper.bodyMedium),
            ],
          ),
        ),
      );
    });
  }
}
