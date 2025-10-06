import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';

class SuccessDialog {
  static Future<void> show(BuildContext context, {required String message}) async {
    if (Platform.isIOS) {
      // ✅ Cupertino-style for iOS
      return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AppIcons.successTick,
                  color: Colors.white,
                  height: 30.px,
                ),
              ),
               SizedBox(height: 10.px),
              Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // ✅ Material-style for Android
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    AppIcons.successTick,
                    color: Colors.white,
                    height: 30.px,
                  ),
                ),
                 SizedBox(height: 15.px),
                Text(
                  message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.blueColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
