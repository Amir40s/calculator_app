
import 'package:flutter/material.dart';

class AppColors {

  static const Color themeColor = Color(0xff155dfc);
  static const Color scaffoldColor = Color(0xffF3F4F6);
  static const Color blueColor = Color(0xff155dfc);
  static const Color darkThemeColor = Color(0xff155dfc);
  static const Color lightThemeColor = Color(0xff155dfc);
  static const Color lightBg = Color(0xffffffff);
  static const Color whiteColor = Color(0xffffffff);
  static const Color blackColor = Colors.black;
  static const Color greyColor = Color(0xffa4a4a4);
  static const Color lightGrey = Color(0xffD9D9D9);
  static const Color darkBg = Color(0xff121212);
  static const Color baseColor = Color(0xffFFF7F5);

  static const Color lightTextColor = Color(0xff212121);
  static const Color darkTextColor = Color(0xffffffff);


  static const firstGradientColor = Color(0xff155dfc);
  static const secondGradientColor = Color(0xff0D1C39);

  static const gradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomCenter,
    colors: [
      // AppColors.firstGradientColor,
      AppColors.whiteColor,
      AppColors.firstGradientColor,

    ],
  );

  static const disable = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.greyColor,
      AppColors.greyColor,
    ],
  );



  static const Color darkCardColor = Color(0xff1E1E1E);
  static const Color lightCardColor = Color(0xffffffff);

  static const Color premiumColor = Color(0xff1447E6);

}