import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/screens/settings/profile/edit_profile.dart';
import '../../core/component/custom_list_item_widget.dart';
import 'contact_us/contact_us_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20.px,
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title('Accounts'),
                CustomListTileWidget(
                  title:  "Personal Information",
                  subtitle: "Update your Personal Information",
                  prefix: AppIcons.privacy,
                  onTap: () {
                    Get.to(EditProfileScreen());
                  },
                ),
            
                CustomListTileWidget(
                  title:  "Notification",
                  subtitle: "Manage Notification Preferences",
                  prefix: AppIcons.bell,
                ),
                CustomListTileWidget(
                  title:  "Subscription",
                  subtitle: "View and Manage Subscription",
                  prefix: AppIcons.subscription,
                ),
                _title('Supports'),
                CustomListTileWidget(
                  title:  "Contact Us",
                  subtitle: "Contact Us Team Support",
                  prefix: AppIcons.call,
                  onTap: () {
                    Get.to(ContactUsScreen());
                  },
                ),
                _title('Legal'),
                CustomListTileWidget(
                  title:  "Terms and Services",
                  prefix: AppIcons.terms,
                ), CustomListTileWidget(
                  title:  "Privacy Policy",
                  prefix: AppIcons.privacy,
                ),
                SizedBox(height: 2.h,),
                AppButtonWidget(text: 'Log Out',height: 6.h,width: 100.w,buttonColor: AppColors.blueColor,),
                SizedBox(height: 2.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _title(String title) {
    return AppTextWidget(
      text: title,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,letterSpacing: 1),
    );
  }
}
