import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/logo_text_widget.dart';
import 'package:pinput/pinput.dart';
import '../../../config/routes/routes_name.dart';
import '../../../core/component/custom_rich_text.dart';

class ConfirmOtpScreen extends StatelessWidget {
   ConfirmOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              LogoTextWidget(),
              SizedBox(height: 4.h),

              AppTextWidget(
                text: 'Confirm OTP',
                styleType: StyleType.heading,
              ),
              SizedBox(height: 1.h),
              AppTextWidget(
                text: "We have sent an OTP your Email",
                color: Color(0xff61677D),
              ),
              SizedBox(height: 2.h),

              Center(
                child: Pinput(
                  length: 4,
                  enableInteractiveSelection: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.blueColor, width: 2),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.themeColor, width: 2),
                    ),
                  ),
                  showCursor: true,
                  onCompleted: (pin) {
                    print("Entered OTP: $pin");
                  },
                ),
              ),
              SizedBox(height: 3.h),

              AppButtonWidget(
                text: 'Confirm',
                height: 6.h,
                width: 100.w,
                buttonColor: AppColors.blueColor,
                onPressed: () {
                  Get.toNamed(RoutesName.newPassword);
                },
              ),
              SizedBox(height: 1.h,),
              Align(
                alignment: Alignment.center,
                child: StyledText(
                  segments: [
                    const TextSegment(
                      text: 'Did not Receive an OTP? ',
                      color: AppColors.blackColor,
                    ),
                    TextSegment(
                      text: 'Resend OTP!',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      onTap: () {
                      },
                    ),
                  ],
                  textAlign: TextAlign.center,
                
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final defaultPinTheme = PinTheme(
    width: 16.w,
    height: 8.h,
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade400),
    ),
  );
}
