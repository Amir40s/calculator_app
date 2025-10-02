
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_text_style.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  int? maxLine;
  final bool softWrap;
  final Color? color;
  final ValueKey? keyValue;
  double? lineHeight;
  TextDecoration? textDecoration;
  TextOverflow? overflow;
  TextStyle? textStyle;
  StyleType styleType;
  VoidCallback? onTap;
  AppTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w500,
    this.color,
    this.textAlign = TextAlign.start,
    this.textDecoration,
    this.fontSize = 14,
    this.softWrap = true,
    this.keyValue,
    this.overflow,
    this.maxLine,
    this.lineHeight,
    this.textStyle,
    this.onTap,
    this.styleType = StyleType.body,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        key: keyValue,
        text.tr,
        textAlign: textAlign,
        softWrap: softWrap,
        maxLines: maxLine,
        style: textStyle ?? _type(type: styleType, context: context,color: color,fontWeight: fontWeight,textDecoration: textDecoration),
      ),
    );
  }

  TextStyle _type({required StyleType type,
    required BuildContext context, Color? color,
    required FontWeight fontWeight,
    TextDecoration? textDecoration
  }){
    switch (type){
      case StyleType.heading:
        return AppTextStyle().heading(context: context,color: color,textDecoration: textDecoration);
      case StyleType.subHeading:
        return AppTextStyle().subHeading(context: context,color: color,textDecoration: textDecoration);
      case StyleType.subTitle:
        return AppTextStyle().subTitle(context: context,color: color,textDecoration: textDecoration);
      case StyleType.body:
        return AppTextStyle().bodyText(context: context,color: color,textDecoration: textDecoration);
      case StyleType.premiumSize:
        return AppTextStyle().premiumSize(context: context,color: color,textDecoration: textDecoration);
      case StyleType.dialogHeading:
        return AppTextStyle().dialogHeading(context: context,color: color,fontWeight: fontWeight,textDecoration: textDecoration);
    }
  }
}