import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/utils/text_styles.dart';

class LabeledTextfield extends StatelessWidget {
  const LabeledTextfield({
    super.key,
    required this.title,
    this.hintText = '',
    required this.controller,
    this.icon,
    this.readOnly = false,
    this.maxLines,
    this.validator,
  });
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget? icon;
  final bool readOnly;
  final int? maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.getBody(fontWeight: FontWeight.w600)),
        Gap(7),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,

          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: icon,
            errorMaxLines: 2,
          ),
        ),
        Gap(12),
      ],
    );
  }
}
