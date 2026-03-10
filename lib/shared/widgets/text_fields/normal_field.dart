import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:flutter/material.dart';

class NormalField extends StatelessWidget {
  final String labelText;
  final bool labelFloating;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const NormalField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.labelFloating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (labelFloating)
            ? Text(labelText, style: TextHelper.bodySmall)
            : SizedBox.shrink(),

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
