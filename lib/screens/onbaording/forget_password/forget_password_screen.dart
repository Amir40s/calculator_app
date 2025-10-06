import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/config/utility/validators.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/logo_text_widget.dart';
import 'package:smart_construction_calculator/core/controller/auth_controller.dart';

import '../../../core/component/app_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          child: Form(
            key: controller.forgetPasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                LogoTextWidget(),
                SizedBox(height: 4.h),

                AppTextWidget(
                  text: 'Forget Password',
                  styleType: StyleType.heading,
                ),
                SizedBox(height: 1.h),
                AppTextWidget(
                  text: "Reset your Password to Continue",
                  color: Color(0xff61677D),
                ),
                SizedBox(height: 1.h),

                AppTextField(
                 heading: 'Email',
                  hintText: 'Enter your email',
                  prefix: AppIcons.outMail,
                  controller: controller.forgetPasswordController,
                  validator: Validators.email,
                ),
                SizedBox(height: 3.h),

                AppButtonWidget(
                  text: 'Send Code',
                  height: 6.h,
                  width: 100.w,
                  buttonColor: AppColors.blueColor,
                  onPressed: () {controller.sendCode();

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
