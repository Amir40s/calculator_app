import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/component/title_with_field.dart';

import '../../../config/res/app_color.dart';
import '../../../core/component/Camera_widget.dart';
import '../../../core/component/app_text_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(text: 'Edit Profile', showDivider: true),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.center,
                    child: EditableProfilePicture(imageUrl: AppAssets.logo),
                  ),
                  TitleWithField(
                    title: 'First name',
                    hint: 'name',
                    suffix: AppIcons.userTwo,
                  ),
                  TitleWithField(
                    title: 'Email',
                    hint: 'email',
                    suffix: AppIcons.mail,
                  ),
                  SizedBox(height: 6.h),
                  AppButtonWidget(
                    text: 'Save',
                    width: 100.w,
                    height: 6.h,
                    buttonColor: AppColors.blueColor,
                    textColor: AppColors.whiteColor,
                    radius: 2.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
