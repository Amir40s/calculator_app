import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';

import 'app_button_widget.dart';

class ReusableButtonRow extends StatelessWidget {
  final String firstButtonText;
  final String secondButtonText;
  final void Function() firstButtonAction;
  final void Function() secondButtonAction;
  final Color? firstButtonColor;
  final Color? secondButtonColor,borderColor;
  final Color? firstButtonTextColor;
  final Color? secondButtonTextColor;

  // Constructor to pass button properties
  const ReusableButtonRow({
    Key? key,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.firstButtonAction,
    required this.secondButtonAction,
     this.firstButtonColor = Colors.transparent,
     this.secondButtonColor,
     this.firstButtonTextColor = AppColors.blueColor,
     this.secondButtonTextColor,
    this.borderColor = AppColors.blueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButtonWidget(
            text: firstButtonText,
            width: 40.w,
            height: 5.h,
            buttonColor: firstButtonColor,
            borderColor: borderColor ,
            radius: 2.w,
            textColor: firstButtonTextColor,
            onPressed: firstButtonAction,
          ),
          AppButtonWidget(
            text: secondButtonText,
            width: 40.w,
            height: 5.h,
            buttonColor: secondButtonColor,
            borderColor: secondButtonColor,
            radius: 2.w,
            textColor: secondButtonTextColor,
            onPressed: secondButtonAction,
          ),
        ],
      ),
    );
  }
}
