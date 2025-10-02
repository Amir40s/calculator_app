import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_icons.dart';
import 'app_text_field.dart';
import 'app_text_widget.dart';

class TitleWithField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint,title,prefix,suffix;
  final Alignment alignment;
  final bool obscureText;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  const TitleWithField({super.key, this.controller,
    this.hint, this.title, this.prefix, this.suffix,    this.obscureText = false,

    this.alignment = Alignment.centerLeft, this.onTap, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: alignment,
          child: AppTextWidget(
            text: title.toString(),
            styleType: StyleType.dialogHeading,
          ),
        ),
        SizedBox(height: 1.h),
        AppTextField(
          hintText: hint.toString(),
          prefix: prefix,
          suffix: suffix,onSuffixTap: onTap,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
