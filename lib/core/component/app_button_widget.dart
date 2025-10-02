import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../../config/enum/style_type.dart';
import '../../config/res/app_color.dart';
import 'app_text_widget.dart';

class AppButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  // Sizing
  final double? height;
  final double? width;
  final EdgeInsets? padding;

  // Radius and borders
  final double? radius;
  final double borderWidth;
  final Color? borderColor;

  // Colors
  final Color? buttonColor;
  final Color? textColor;

  // Typography
  final FontWeight fontWeight;
  final double? fontSize;
  final StyleType styleType;

  // Alignment
  final Alignment alignment;

  // Loader
  final bool loader;
  final bool isGradient,isGradientDisable;

  // Icons
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.height,
    this.width,
    this.padding,
    this.radius,
    this.borderWidth = 1,
    this.borderColor,
    this.buttonColor,
    this.textColor,
    this.fontWeight = FontWeight.w400,
    this.fontSize,
    this.styleType = StyleType.body,
    this.alignment = Alignment.center,
    this.loader = false,
    this.isGradient = false,
    this.isGradientDisable = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasBorder = borderColor != null;

    return GestureDetector(
      onTap: loader ? null : onPressed,
      child: Align(
        alignment: alignment,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 12),
          child: Container(

            decoration: BoxDecoration(
              // gradient: isGradient ? AppColors.gradient : isGradientDisable ? AppColors.disable : null,
              gradient: isGradientDisable ? AppColors.disable : isGradient ? AppColors.gradient : null,
            ),
            child: SmoothContainer(
              smoothness: 0.8,
              height: height,
              width: width,
              color: buttonColor,
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
              borderRadius: BorderRadius.circular(radius ?? 12),
              side: hasBorder ? BorderSide(
                  color: borderColor!, width: borderWidth
              ) : BorderSide.none,
              child: loader
                  ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                  strokeWidth: 2,
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: AppTextWidget(
                      text: text,
                      fontSize: fontSize ?? 16,
                      fontWeight: fontWeight,
                      color: textColor ?? AppColors.whiteColor,
                      styleType: styleType,
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    suffixIcon!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
