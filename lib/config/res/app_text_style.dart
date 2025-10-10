import 'package:flutter/material.dart';
import 'package:smart_construction_calculator/config/res/statics.dart';

class AppTextStyle {
  final Statics static = Statics();

  static const String defaultFont = "Nunito Sans";

  TextStyle _getTextStyle({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
    String fontFamily = defaultFont,
    TextDecoration? textDecoration = TextDecoration.none,
    double height = 1.4,
    Color? backgroundColor,
    double letterSpacing = 0.0,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
      decoration: textDecoration,
      height: height,
      decorationThickness: 0.7,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
    );
  }


  TextStyle heading({
    required BuildContext context,
    Color? color,
    double? size,
    TextDecoration? textDecoration,
    FontWeight fontWeight = FontWeight.w700,
    String fontFamily = defaultFont,
  }) {
    return _getTextStyle(
        fontSize: size ?? static.mainHeadingSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        textDecoration: textDecoration
    );
  }

  TextStyle subHeading({
    required BuildContext context,
    Color? color,
    double? size,
    TextDecoration? textDecoration,
    FontWeight fontWeight = FontWeight.w500,
    String fontFamily = defaultFont,
  }) {
    return _getTextStyle(
        fontSize: size ?? static.subHeadingSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        textDecoration: textDecoration
    );
  }

  TextStyle bodyText({
    required BuildContext context,
    Color? color,
    double? size,
    TextDecoration? textDecoration,
    FontWeight fontWeight = FontWeight.w400,
    String fontFamily = defaultFont,
  }) {
    return _getTextStyle(
        fontSize: size ?? static.bodyTextSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        textDecoration: textDecoration
    );
  }

  TextStyle mediumBodyText({
    required BuildContext context,
    Color? color,
    double? size,
    TextDecoration? textDecoration,
    FontWeight fontWeight = FontWeight.w600,
    String fontFamily = defaultFont,
  }) {
    return _getTextStyle(
        fontSize: size ?? static.bodyTextSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        textDecoration: textDecoration
    );
  }

  TextStyle subTitle({
    required BuildContext context,
    Color? color,
    double? size,
    TextDecoration? textDecoration,
    FontWeight fontWeight = FontWeight.w400,
    String fontFamily = defaultFont,
  }) {
    return _getTextStyle(
        fontSize: size ?? static.subtitleTextSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        textDecoration: textDecoration
    );
  }

  TextStyle premiumSize({
    required BuildContext context,
    Color? color,
    double? size,
    TextDecoration? textDecoration,
    FontWeight fontWeight = FontWeight.w700,
    String fontFamily = defaultFont,
  }) {
    return _getTextStyle(
        fontSize: size ??static.premiumTextSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        textDecoration: textDecoration
    );
  }

  TextStyle dialogHeading({
    required BuildContext context,
    Color? color,
    double? size,
    TextDecoration? textDecoration,
    FontWeight fontWeight = FontWeight.w600,
    String fontFamily = defaultFont,
  }) {
    return _getTextStyle(
        fontSize: size ??static.dialogHeadingSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        textDecoration: textDecoration
    );
  }

}