import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/enum/style_type.dart';
import '../controller/theme_controller.dart';
import 'app_text_widget.dart';

class CustomPlatformWidget {

  static Future<void> showDefaultDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "OK",
    Color? confirmColor,
    Color? cancelColor,
    VoidCallback? onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: AppTextWidget(text:  title,textAlign: TextAlign.center,styleType: StyleType.dialogHeading,fontWeight: FontWeight.w700,),
          content: AppTextWidget(text:  message,textAlign: TextAlign.center,styleType: StyleType.subTitle,),
          actions: [
            if (cancelText != null)
              CupertinoDialogAction(
                child: AppTextWidget(
                  text:  cancelText,
                  textAlign: TextAlign.center,
                  styleType: StyleType.dialogHeading,
                  color: cancelColor,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  if (onCancel != null) onCancel();
                },
              ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: AppTextWidget(
                text:  confirmText,
                textAlign:
                TextAlign.center,
                styleType: StyleType.dialogHeading,
                color: confirmColor,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onConfirm != null) onConfirm();
              },
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: AppTextWidget(text:  title,textAlign: TextAlign.center,styleType: StyleType.dialogHeading,fontWeight: FontWeight.w700,),
          content: AppTextWidget(text:  message,textAlign: TextAlign.center,styleType: StyleType.subTitle,),
          actions: [
            if (cancelText != null)
              TextButton(
                child: AppTextWidget(
                  text:  cancelText,
                  textAlign: TextAlign.center,
                  styleType: StyleType.dialogHeading,
                  color: cancelColor,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  if (onCancel != null) onCancel();
                },
              ),
            TextButton(
              child: AppTextWidget(
                text:  confirmText,
                textAlign:
                TextAlign.center,
                styleType: StyleType.dialogHeading,
                color: confirmColor,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onConfirm != null) onConfirm();
              },
            ),
          ],
        ),
      );
    }
  }


  static void showIOSBottomSheet(BuildContext context) {
    final themeCon = Get.find<ThemeController>();

    bool isSelected = themeCon.isLightTheme();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Choose an Option'),
        message: const Text('Select one of the options below'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              themeCon.updateSelectedIndex(0);
              Navigator.pop(context);
            },
            child: const Text('System Default'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              themeCon.updateSelectedIndex(1);
              Navigator.pop(context);
            },
            child: const Text('Light Mode'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              themeCon.updateSelectedIndex(2);
              Navigator.pop(context);
            },
            child: const Text('Dark Mode'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDefaultAction: true,
          child: const Text('Cancel'),
        ),
      ),
    );
  }


}