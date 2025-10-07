import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';
import 'package:smart_construction_calculator/core/controller/auth_controller.dart';

import '../../config/res/app_assets.dart';
import '../../core/component/custom_rich_text.dart';
import '../../core/component/logo_text_widget.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    // Get screen height for responsive positioning
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: _buildCopyrightText(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image with Dark Overlay
          _buildBackgroundImage(),

          // 2. Main Content (Logo and Text) - Top Half
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: _buildTopContent(context),
          ),

          // 3. Bottom Sheet with Buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // Height is set to cover approximately the bottom 40-45% of the screen
            child: Container(
              height: screenHeight * 0.40,
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              child: _buildButtonContent(context),
            ),
          ),

          // 4. Copyright Text - Very Bottom
          // Positioned(
          //   bottom: 12,
          //   left: 0,
          //   right: 0,
          //   child: _buildCopyrightText(),
          // ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.splash),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.15)),
      ),
    );
  }

  Widget _buildTopContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LogoTextWidget(
          color: AppColors.whiteColor,
        ),
        const SizedBox(height: 30.0),
        // Main Headline
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: AppTextWidget(
            text: '#1 Most Downloaded\nUHCONST Calculator App',
            textAlign: TextAlign.center,
            color: AppColors.whiteColor,
            styleType: StyleType.heading,
          ),
        ),
        const SizedBox(height: 16.0),

        // Subtext
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: AppTextWidget(
            text:
                'Sign in to save your projects & access them anytime, anywhere.',
            textAlign: TextAlign.center,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SmoothContainerWidget(
          height: 0.8.h,
          width: 18.w,
          color: AppColors.greyColor.withOpacity(0.4),
        ),
        SizedBox(height: 5.h),
        _buildSocialButton(
          text: 'Continue with Google',
          icon: SvgPicture.asset(AppIcons.google),
          color: AppColors.themeColor,
          textColor: Colors.white,
          onTap: () {
            authC.continueWithGoogle(context: context);
          },
        ),
        SizedBox(height: 1.6.h),

        // Continue with Email Button
        _buildSocialButton(
          text: 'Continue with Apple',
          icon: SvgPicture.asset(AppIcons.apple),
          color: AppColors.blueColor,
          textColor: Colors.white,
          onTap: () {},
        ),
        SizedBox(height: 2.h),

        // Separator Text
        Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: AppTextWidget(
                text: 'or continue to',
                color: AppColors.greyColor,
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: 4.h),
        // Login Link/Button
        _buildLoginButton(
          text: 'Login to your account',
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String text,
    required Widget icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return AppButtonWidget(
      width: 100.w,
      height: 6.h,
      onPressed: onTap,
      text: text,
      prefixIcon: icon,
      buttonColor: color,
      textColor: textColor,
      styleType: StyleType.subHeading,
    );
  }

  Widget _buildLoginButton({required String text}) {
    return AppButtonWidget(
      width: 100.w,
      height: 6.h,
      textColor: Colors.black,
      styleType: StyleType.subHeading,
      buttonColor: AppColors.baseColor,
      onPressed: () {
        Get.toNamed(RoutesName.login);
      },
      text: 'Login to your account',
    );
  }

  Widget _buildCopyrightText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
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
    );
  }
}
