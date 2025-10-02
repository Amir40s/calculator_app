import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_color.dart';
import 'app_text_widget.dart';

class AddNewButton extends StatelessWidget {
  final text;
  final VoidCallback onTap;
   AddNewButton({super.key, this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.px),
        margin: EdgeInsets.symmetric(horizontal:  15.px,vertical: 25.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.px),
          color: AppColors.themeColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(text: text,color: AppColors.themeColor,styleType: StyleType.subHeading,),
            Icon(Icons.add,color: AppColors.themeColor,)
          ],
        ),
      ),
    );
  }
}
