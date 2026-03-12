import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DateSection extends StatelessWidget {
  const DateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          _dateButton(context: context, date: "11-02-2024"),
          Container(width: 1, height: 20, color: Colors.grey),
          _dateButton(context: context, date: "11-02-2024"),
        ],
      ),
    );
  }
}

Widget _dateButton({
  required BuildContext context,
  required String date,
  VoidCallback? onPressed,
}) {
  return Obx(
    () => Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            icon: Icon(
              PhosphorIconsLight.calendarDots,
              color: context.responsive(
                light: AppColors.primaryLight,
                dark: AppColors.darkIconSecondary,
              ),
            ),
          ),
          Text(date, style: TextHelper.bodyBoldStyle(context)),
        ],
      ),
    ),
  );
}
