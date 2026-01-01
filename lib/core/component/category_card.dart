import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_assets.dart';
import '../../config/res/app_color.dart';
import 'app_text_widget.dart';

class HomeCalculatorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color tint;
  final VoidCallback onTap;

  const HomeCalculatorCard({
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageHeight = constraints.maxHeight * 0.4;
          final contentHeight = constraints.maxHeight * 0.6;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withOpacity(0.06)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AppAssets.splash,
                        fit: BoxFit.cover,
                      ),
                      Container(color: tint.withOpacity(0.35)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 0.5.h,
                      left: 2.w,
                      right: 2.w,
                      bottom: 41,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: AppTextWidget(
                            text: title,
                            styleType: StyleType.subHeading,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 3.px),
                        Flexible(
                          child: AppTextWidget(
                            text: subtitle,
                            styleType: StyleType.subTitle,
                            color: AppColors.greyColor,
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
