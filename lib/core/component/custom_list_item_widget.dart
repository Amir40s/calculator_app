
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_color.dart';
import 'app_text_widget.dart';

class CustomListTileWidget extends StatelessWidget {
  final String? prefix;
  final Widget? postfix;
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? iconColor;
  final double borderRadius;
  final BoxBorder? border;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const CustomListTileWidget({
    Key? key,
    this.prefix,
    this.postfix,
    required this.title,
    this.subtitle,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = 12.0,
    this.border,
    this.titleColor,
    this.subTitleColor,
    this.iconColor,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border ?? Border.all(color: Colors.transparent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefix != null) ...[
      Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(blurRadius: 2,offset: Offset(0, 2),color: AppColors.greyColor.withOpacity(0.5)),
        ],
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(prefix!,height: 35.px,),
    ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text:  title,
                    textStyle: TextStyle(
                        color: titleColor,
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: AppTextWidget(
                        text:  subtitle!,
                        textStyle: TextStyle(
                          color: subTitleColor ?? AppColors.greyColor,
                          fontSize: 13
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // postfix ?? Icon(Icons.arrow_forward_ios,size: 18.px,color: iconColor ?? Theme.of(context).primaryColorDark,)
            if (postfix != null) ...[
              const SizedBox(width: 12),
              postfix!,
            ],
          ],
        ),
      ),
    );
  }



}