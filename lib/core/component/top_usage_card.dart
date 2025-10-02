import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_text_widget.dart';

/// Top Usage Card
class TopUsageCard extends StatelessWidget {
  final String title;
  final Color color;
  final String icon;
  const TopUsageCard({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      margin:  EdgeInsets.only(right: 1.2.w,top: 1.h),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.w),
              color: color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(icon,),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(child: AppTextWidget(text: title,overflow: TextOverflow.ellipsis,
            softWrap: true,maxLine: 2,)),
        ],
      ),
    );
  }
}
