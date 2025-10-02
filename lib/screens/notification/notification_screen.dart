import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          AppBarWidget(text: 'Notifications',showDivider: true,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20.px,
              children: [
                SvgPicture.asset(AppIcons.noNotifications,height: 50.px,),
                AppTextWidget(text: 'No Notifications',styleType: StyleType.subTitle,),
                AppTextWidget(text: 'We’ll let you know when there will be something to update you.',styleType: StyleType.subTitle,color: AppColors.greyColor,),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
