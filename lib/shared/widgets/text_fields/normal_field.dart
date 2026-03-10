import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NormalField extends StatelessWidget {
  final String labelText;
  final bool labelFloating;
  final String? hintText;

  final TextEditingController? controller;
  final bool obscureText;
  final bool enabled;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const NormalField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.labelFloating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (labelFloating)
            ? Text(labelText, style: TextHelper.bodyMedium)
            : SizedBox.shrink(),

        Gap(Sizes.smallSpace),

        SizedBox(
          height: 48,
          child: TextFormField(
            enabled: enabled,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            style: TextHelper.bodyMedium,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              labelText: labelFloating ? null : labelText,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
