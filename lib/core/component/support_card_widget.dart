import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';

class SupportCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const SupportCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle, required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: onTap,
      child: Container(
        height: 20.h,
        width: 35.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                iconPath,
                height: 45,
              ),
            ),
            SizedBox(height: 1.h),
            AppTextWidget(text:
              title,
              styleType: StyleType.subHeading,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.px,),
            AppTextWidget(text:
              subtitle,
              styleType: StyleType.subTitle,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
