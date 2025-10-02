import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../config/res/app_color.dart';
import '../../config/res/app_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () {
            Get.back();
          },
      child: Container(
        height: 52,
        width: 52,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: -2,
              blurRadius: 17.3,
              offset: const Offset(0, 5),
            ),
          ],
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(AppIcons.back),
      ),
    );
  }
}


class CustomIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? buttonColor;
  final IconData? icon;

  const CustomIconButton({
    super.key,
    this.onTap,
    this.icon,
    this.buttonColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.2), // Semi-transparent white color
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: buttonColor,
                  size: 20, // Adjust icon size as per requirements
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
