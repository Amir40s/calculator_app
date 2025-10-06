import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';

import 'app_text_widget.dart';

/// Category Card
class CategoryCard extends StatelessWidget {
  final String title;
  final Color? color;
  final Widget  icon;
  final VoidCallback onTap;
  const CategoryCard({
    super.key,
    required this.title,
     this.color,
    required this.icon,
      required this.onTap,
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
            icon,
            SizedBox(height: 1.h,),
            Flexible(child: AppTextWidget(text: title,overflow: TextOverflow.ellipsis,maxLine: 2,textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }

}