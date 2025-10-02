import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';

import 'app_text_widget.dart';

/// Category Card
class CategoryCard extends StatelessWidget {
  final String title;
  final Color? color, innerColor;
  final String icon;
  final VoidCallback onTap;
  const CategoryCard({
    super.key,
    required this.title,
     this.color,
    required this.icon,
     this.innerColor, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SmoothContainerWidget(
        width: 30.w,
        margin:  EdgeInsets.only(right: 3.w),
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon,height: 55.px,width: 55.px,),
            SizedBox(height: 1.h,),
            Flexible(child: AppTextWidget(text: title,overflow: TextOverflow.ellipsis,maxLine: 2,textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }
}