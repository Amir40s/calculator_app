import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../res/app_color.dart';


class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.themeColor,
      primaryColorDark: AppColors.lightTextColor,
      cardColor: AppColors.lightCardColor,
      highlightColor: AppColors.themeColor,
      // colorScheme: _lightColorScheme,
      useMaterial3: true,
      secondaryHeaderColor:AppColors.darkCardColor,
      scaffoldBackgroundColor: AppColors.lightBg,
      dialogTheme: DialogThemeData(
          backgroundColor: AppColors.lightCardColor
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.lightCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.themeColor,
        brightness: Brightness.light,
        surface: AppColors.lightCardColor,
        onSurface: AppColors.lightTextColor,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.themeColor,
        scaffoldBackgroundColor: AppColors.lightBg,
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(color: AppColors.lightTextColor,fontSize: 22),
        ),
      ),
      appBarTheme: _appBarTheme(AppColors.lightBg, AppColors.lightTextColor),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkThemeColor,
      primaryColorDark: AppColors.darkTextColor,
      cardColor: AppColors.darkCardColor,
      highlightColor: Colors.black,
      // colorScheme: _darkColorScheme,
      secondaryHeaderColor:AppColors.lightCardColor,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBg,
      dialogTheme: DialogThemeData(
          backgroundColor: AppColors.darkCardColor
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkThemeColor,
        brightness: Brightness.dark,
        surface: AppColors.darkCardColor,
        onSurface: AppColors.darkTextColor,
      ),
      appBarTheme: _appBarTheme(AppColors.darkBg, AppColors.darkTextColor),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: AppColors.darkThemeColor,
        scaffoldBackgroundColor: AppColors.darkBg,
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(color: AppColors.darkTextColor,fontSize: 22),
        ),
      ),
    );
  }

  // static const ColorScheme _lightColorScheme = ColorScheme(
  //   brightness: Brightness.light,
  //   primary: AppColors.themeColor,
  //   onPrimary: Colors.white,
  //   secondary: AppColors.grammarLightCardColor,
  //   onSecondary: AppColors.bannerLightCardColor,
  //   surface: AppColors.lightCardColor,
  //   onSurface: AppColors.lightTextColor,
  //   error: AppColors.redColor,
  //   onError: Colors.white,
  // );
  //
  // static const ColorScheme _darkColorScheme = ColorScheme(
  //   brightness: Brightness.dark,
  //   primary: AppColors.themeColor,
  //   onPrimary: Colors.black,
  //   secondary: AppColors.grammarDarkCardColor,
  //   onSecondary:AppColors.bannerDarkCardColor,
  //   surface: AppColors.darkCardColor,
  //   onSurface: AppColors.darkTextColor,
  //   error: AppColors.redColor,
  //   onError: Colors.black,
  // );

  static AppBarTheme _appBarTheme(Color backgroundColor, Color textColor) {
    return AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}