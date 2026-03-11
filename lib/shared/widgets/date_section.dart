import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DateSection extends StatelessWidget {
  const DateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          _dateButton(date: "11-02-2024"),
          Container(width: 1, height: 20, color: Colors.grey),
          _dateButton(date: "11-02-2024"),
        ],
      ),
    );
  }
}

Widget _dateButton({required String date, VoidCallback? onPressed}) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(
            PhosphorIconsLight.calendarDots,
            color: ThemeService().isDarkMode
                ? AppColors.primaryDark
                : AppColors.primaryLight,
          ),
        ),
        Text(date, style: TextHelper.bodyBold),
      ],
    ),
  );
}
