import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';
import 'package:smart_construction_calculator/core/controller/auth_controller.dart';

import '../../../config/utility/validators.dart';
import '../../../core/component/app_text_field.dart';
import '../../../core/component/custom_rich_text.dart';
import '../../../core/component/input_field_widget.dart';
import '../../../core/component/logo_text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      bottomNavigationBar:  Padding(
        padding:  EdgeInsets.symmetric( vertical:  22.px),
        child: StyledText(
          segments: [
            const TextSegment(
              text: 'Copyright: ',
              color: AppColors.themeColor,
            ),
            const TextSegment(
              text: 'Unique Home Construction and Management',
              color: Colors.black,
            ),
          ],
          textAlign: TextAlign.center,

        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                /// Logo
                LogoTextWidget(),

                SizedBox(height: 4.h),

                /// Title & subtitle
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppTextWidget(
                    text: "Log In",
                    styleType: StyleType.heading,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppTextWidget(
                    text: "Welcome back, sign in to continue.",
                    color: Color(0xff61677D),
                  ),
                ),

                const SizedBox(height: 20),

                /// Email field
                AppTextField(
                  heading: "Email",
                  hintText: 'Enter your email',
                  prefix: AppIcons.outMail,
                  controller: controller.emailController,
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),

                /// Password field
                Obx(() {
                    return AppTextField(
                      heading: "Password",
                      hintText: '******',
                      obscureText: !controller.isPasswordVisible.value,
                      suffix: controller.isPasswordVisible.value
                          ? AppIcons.viewOn
                          : AppIcons.viewOff,
                      prefix: AppIcons.lockSvg,
                      controller: controller.passwordController,
                      validator: Validators.strongPassword,
                      onSuffixTap: controller.togglePasswordVisibility,

                    );
                  }
                ),

                SizedBox(height: 1.6.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesName.forgetPassword);
                      },
                      child: AppTextWidget(text: 'Forget Password?',styleType: StyleType.subHeading,)),
                ),
                SizedBox(height: 2.4.h),

                /// Log In Button
                AppButtonWidget(
                    text: 'Log In',
                    height: 5.h,
                    width: 100.w,
                    buttonColor: AppColors.blueColor,
                    onPressed: () {
                      controller.login();
                    },),

                const SizedBox(height: 16),

                /// Sign up text
                StyledText(
                  segments: [
                    const TextSegment(
                      text: ' Don’t have an account? ',
                      color: AppColors.blackColor,
                    ),
                     TextSegment(
                      text: 'Sign Up',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                       onTap: () {
                         Get.toNamed(RoutesName.signUp);
                       },
                    ),
                  ],
                  textAlign: TextAlign.center,

                ),

                const SizedBox(height: 10),

                /// Divider with OR
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AppTextWidget(text: "Or"),
                    ),
                    const Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                const SizedBox(height: 16),

                /// Google Button
                SmoothContainerWidget(
                  width: double.infinity,
                  height: 6.h,
                  color: AppColors.baseColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.google,
                        height: 24,
                      ),
                       SizedBox(width:3.w,),
                       AppTextWidget(text: "Google"),
                    ],
                  )
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
