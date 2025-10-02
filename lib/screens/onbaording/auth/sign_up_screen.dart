import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/config/utility/validators.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';

import '../../../core/component/app_text_field.dart';
import '../../../core/component/custom_rich_text.dart';
import '../../../core/component/input_field_widget.dart';
import '../../../core/component/logo_text_widget.dart';
import '../../../core/component/title_with_field.dart';
import '../../../core/controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 22.px),
        child: StyledText(
          segments: [
            const TextSegment(text: 'Copyright: ', color: AppColors.themeColor),
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
            key: controller.signupFormKey,
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
                    text: "Sign Up",
                    styleType: StyleType.heading,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppTextWidget(
                    text: "Welcome back, sign up to continue.",
                    color: Color(0xff61677D),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleWithField(
                        title: "First Name",
                        hint: 'First Name',
                        prefix: AppIcons.userTwo,
                        controller: controller.firstNameController,
                        validator: Validators.required,
                      ),
                    ),
                    Expanded(
                      child: TitleWithField(
                        title: "Last Name",
                        hint: 'Last Name',
                        controller: controller.lastNameController,
                        validator: Validators.required,
                        prefix: AppIcons.userTwo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Email field
                TitleWithField(
                  title: "Email",
                  hint: 'Enter your email',
                  prefix: AppIcons.outMail,
                  controller: controller.emailController,
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),

                /// Password field
                Obx(() {
                  return TitleWithField(
                    title: "Password",
                    hint: '******',
                    obscureText: !controller.isPasswordVisible.value,
                    suffix: controller.isPasswordVisible.value
                        ? AppIcons.viewOn
                        : AppIcons.viewOff,
                    prefix: AppIcons.lockSvg,
                    controller: controller.passwordController,
                    validator: Validators.strongPassword,
                    onTap: controller.togglePasswordVisibility,

                  );
                }
                ),
                SizedBox(height: 2.4.h),

                AppButtonWidget(
                  text: 'Sign Up',
                  height: 5.h,
                  width: 100.w,
                  buttonColor: AppColors.blueColor,
                  onPressed: () {
                    controller.signup();
                  },
                ),

                 SizedBox(height: 1.6.h),

                StyledText(
                  segments: [
                    const TextSegment(
                      text: '  Have an account? ',
                      color: AppColors.blackColor,
                    ),
                    TextSegment(
                      text: 'Log In',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      onTap: () {
                        Get.toNamed(RoutesName.login);
                      },
                    ),
                  ],
                  textAlign: TextAlign.center,
                ),

                 SizedBox(height: 1.h),

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

                 SizedBox(height: 1.6.h),

                /// Google Button
                SmoothContainerWidget(
                  width: double.infinity,
                  height: 6.h,
                  color: AppColors.baseColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.google, height: 24),
                      SizedBox(width: 3.w),
                      AppTextWidget(text: "Google"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
