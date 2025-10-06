import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_color.dart';
import '../../config/res/app_text_style.dart';
import '../../config/res/statics.dart';
import 'app_text_widget.dart';

class AppTextField extends StatelessWidget {
  final String? heading;
  final String hintText;
  final String? prefix;
  final String? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final int? maxlines,maxLength;

  final double borderRadius;
  final Color borderColor;
  final Color? fillColor;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onSuffixTap;

  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final AutovalidateMode autovalidateMode;

  const AppTextField({
    super.key,
    this.maxlines = 1,
    this.maxLength,
    this.heading,
    required this.hintText,
    this.prefix,
    this.suffix,
    this.controller,
    this.onSuffixTap,
    this.obscureText = false,
    this.borderRadius = 12.0,
    this.borderColor = Colors.transparent,
    this.fillColor,
    this.boxShadow,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  Widget? _buildIcon(dynamic input) {
    if (input == null) return null;

    if (input is Icon) {
      return input;
    } else if (input is String && input.endsWith('.svg')) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SvgPicture.asset(input, height: 20, width: 20),
      );
    } else if (input is String &&
        (input.endsWith('.png') || input.endsWith('.jpg'))) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Image.asset(input, height: 20, width: 2),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final shadow = boxShadow ??
        [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 0,
            offset: Offset(0, 0),
          ),
        ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null) ...[
          AppTextWidget(
            text:  heading!,
            styleType: StyleType.subHeading,
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: shadow,
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxlines,
            maxLength: maxLength,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            autovalidateMode: autovalidateMode,
            onChanged: onChanged,
            style: AppTextStyle().bodyText(context: context),
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              hintText: hintText,
              hintStyle: AppTextStyle().bodyText(context: context,color: AppColors.greyColor),
              prefixIcon: prefix != null ?
              SizedBox(
                height: 20,
                width: 20,
                child: Center(child: _buildIcon(prefix)),
              ):null,
              suffixIcon: Container(
                width: Statics().iconMediumLargeSize,
                height: Statics().iconMediumLargeSize,
                child: suffix != null
                    ? InkWell(
                  onTap: onSuffixTap,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(child: _buildIcon(suffix)),
                  ),
                )
                    : null,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor, width: 1.5),
              ),
              filled: true,
              fillColor: fillColor ?? AppColors.baseColor,
            ),
          ),
        ),
      ],
    );
  }
}