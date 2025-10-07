import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';

class LogoutDialogBox extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onConfirm;

  const LogoutDialogBox({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.lightBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextWidget(
              color: AppColors.darkBg,
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 2.h),
            AppTextWidget(
              text: description,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: Get.back,
                    child: AppTextWidget(
                      textAlign: TextAlign.right,
                      text:'No',
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Center(
                      child: AppTextWidget(
                        textAlign: TextAlign.right,
                        text: 'Yes',
                        color: AppColors.darkBg,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
