import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_constants.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/logo_text_widget.dart';
import 'package:smart_construction_calculator/core/controller/auth_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import 'package:smart_construction_calculator/core/controller/otp_controller.dart';
import '../../../config/routes/routes_name.dart';
import '../../../core/component/custom_rich_text.dart';

class ConfirmOtpScreen extends StatelessWidget {
  ConfirmOtpScreen({super.key});

  final otpC = Get.find<OTPController>();

  final defaultPinTheme = PinTheme(
    width: 16.w,
    height: 8.h,
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GlobalLoader(
      child: Scaffold(
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
                  color: const Color(0xff61677D),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: Pinput(
                    controller: otpC.otpC,
                    length: 4,
                    showCursor: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.blueColor, width: 2),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.themeColor, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                AppButtonWidget(
                  text: 'Confirm',
                  height: 6.h,
                  width: 100.w,
                  buttonColor: AppColors.blueColor,
                  onPressed: () {
                    if (otpC.verifyOTP()) {
                      authC.verifyOTPAndSaveUser(context);
                    }
                  },
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.center,
                  child: Obx(() {
                    return StyledText(
                      segments: [
                        TextSegment(
                          text: otpC.isOtpTimerRunning
                              ? "Resend OTP in ${otpC.remainingTime}s"
                              : "Did not Receive an OTP? ",
                          color: AppColors.blackColor,
                        ),
                        if (!otpC.isOtpTimerRunning)
                          TextSegment(
                            text: 'Resend OTP!',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            onTap: () async {
                              await otpC.resendOTP(context);
                            },
                          ),
                      ],
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
