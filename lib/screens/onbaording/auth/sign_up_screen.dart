import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/config/utility/validators.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../core/component/custom_rich_text.dart';
import '../../../core/component/logo_text_widget.dart';
import '../../../core/controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GlobalLoader(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 26.px, horizontal: 3.px),
          child: StyledText(
            segments: [
              const TextSegment(
                  text: 'Copyright: ',
                  color: AppColors.themeColor,
                  fontSize: 13),
              const TextSegment(
                  text: 'Unique Home Construction and Management',
                  color: Colors.black,
                  fontSize: 13),
            ],
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  LogoTextWidget(),
                  SizedBox(height: 4.h),
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
                          controller: authC.signUpFirstNameC,
                          validator: Validators.required,
                        ),
                      ),
                      Expanded(
                        child: TitleWithField(
                          title: "Last Name",
                          hint: 'Last Name',
                          controller: authC.signUpLastNameC,
                          validator: Validators.required,
                          prefix: AppIcons.userTwo,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TitleWithField(
                    title: "Email",
                    hint: 'Enter your email',
                    prefix: AppIcons.outMail,
                    controller: authC.signUpEmailC,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),
                  TitleWithField(
                    title: "Password",
                    hint: '******',
                    obscureText: true,
                    prefix: AppIcons.lockSvg,
                    controller: authC.signUpPasswordC,
                    validator: Validators.strongPassword,
                  ),
                  SizedBox(height: 2.4.h),
                  AppButtonWidget(
                    text: 'Sign Up',
                    height: 6.h,
                    width: 100.w,
                    buttonColor: AppColors.blueColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        authC.signup(context: context);
                      }
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
                  GestureDetector(
                    onTap: () {
                      authC.continueWithGoogle(context: context);
                    },
                    child: SmoothContainerWidget(
                      width: double.infinity,
                      height: 6.5.h,
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
