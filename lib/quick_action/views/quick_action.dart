import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: Text("Quick Action", style: TextHelper.h3),
          ),
          Icon(PhosphorIconsBold.funnelSimple),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(PhosphorIconsLight.magnifyingGlass),
            ),
          ),
          Gap(8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(PhosphorIconsLight.moon),
            ),
          ),
          Gap(8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppIcons.cashCounter),
            ),
          ),
        ],
      ),
    );
  }
}
