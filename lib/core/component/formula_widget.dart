import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_color.dart';
import 'app_text_widget.dart';

class FormulaWidget extends StatelessWidget {
  final String text;
  const FormulaWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppTextWidget(
        text: text,
        styleType: StyleType.subTitle,
        color: AppColors.greyColor,
      ),
    );
  }
}
