import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/utility/validators.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/logo_text_widget.dart';
import 'package:smart_construction_calculator/core/controller/auth_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return GlobalLoader(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  const LogoTextWidget(),
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
                  SizedBox(height: 2.h),
      
                  /// Email field
                  AppTextField(
                    heading: 'Email',
                    hintText: 'Enter your email',
                    prefix: AppIcons.outMail,
                    controller: controller.loginEmailC, 
                    validator: Validators.email,
                  ),
                  SizedBox(height: 3.h),
      
                  /// Send Code button
                  AppButtonWidget(
                    text: 'Send Code',
                    height: 6.h,
                    width: 100.w,
                    buttonColor: AppColors.blueColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.sendPasswordResetEmail(context: context); 
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
