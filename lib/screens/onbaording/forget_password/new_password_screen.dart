import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:smart_construction_calculator/config/enum/style_type.dart';
// import 'package:smart_construction_calculator/config/res/app_color.dart';
// import 'package:smart_construction_calculator/config/res/app_icons.dart';
// import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
// import 'package:smart_construction_calculator/core/component/app_text_field.dart';
// import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
// import 'package:smart_construction_calculator/core/controller/auth_controller.dart';
// import '../../../config/utility/validators.dart';
// import '../../../core/component/custom_rich_text.dart';
// import '../../../core/component/logo_text_widget.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<AuthController>();

    return Scaffold(

//       // body: SafeArea(
//       //   child: SingleChildScrollView(
//       //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       //     child: Form(
//       //       key: controller.newPasswordFormKey,
//       //       child: Column(
//       //         crossAxisAlignment: CrossAxisAlignment.center,
//       //         children: [
//       //           const SizedBox(height: 40),
//       //           /// Logo
//       //           LogoTextWidget(),

//       //           SizedBox(height: 4.h),

//       //           /// Title & subtitle
//       //           Align(
//       //             alignment: Alignment.centerLeft,
//       //             child: AppTextWidget(
//       //               text: "New Password",
//       //               styleType: StyleType.heading,
//       //             ),
//       //           ),
//       //           const SizedBox(height: 4),
//       //           Align(
//       //             alignment: Alignment.centerLeft,
//       //             child: AppTextWidget(
//       //               text: "Enter the Password and Continue",
//       //               color: Color(0xff61677D),
//       //             ),
//       //           ),

//       //           const SizedBox(height: 20),

//       //           /// Email field
//       //           Obx(() {
//       //             return TitleWithField(
//       //               title: "Password",
//       //               hint: '******',
//       //               obscureText: !controller.isPasswordVisible.value,
//       //               suffix: controller.isPasswordVisible.value
//       //                   ? AppIcons.viewOn
//       //                   : AppIcons.viewOff,
//       //               prefix: AppIcons.lockSvg,
//       //               controller: controller.passwordController,
//       //               validator: Validators.strongPassword,
//       //               onTap: controller.togglePasswordVisibility,
//                 /// Email field
//                 Obx(() {
//                   return AppTextField(
//                     heading: "Password",
//                     hintText: '******',
//                     obscureText: !controller.isPasswordVisible.value,
//                     suffix: controller.isPasswordVisible.value
//                         ? AppIcons.viewOn
//                         : AppIcons.viewOff,
//                     prefix: AppIcons.lockSvg,
//                     controller: controller.passwordController,
//                     validator: Validators.strongPassword,
//                     onChanged: (val) {
//                   controller.togglePasswordVisibility();
//                     },

//       //             );
//       //           }
//       //           ),
//       //           const SizedBox(height: 16),

//       //           /// Password field
//       //           Obx(() {
//       //             return TitleWithField(
//       //               title: "Confirm Password",
//       //               hint: '******',
//       //               obscureText: !controller.isConfirmPasswordVisible.value,
//       //               suffix: controller.isConfirmPasswordVisible.value
//       //                   ? AppIcons.viewOn
//       //                   : AppIcons.viewOff,
//       //               prefix: AppIcons.lockSvg,
//       //               controller: controller.confirmPasswordController,
//       //               validator: Validators.strongPassword,
//       //               onTap: controller.toggleConfirmPasswordVisibility,
//                 /// Password field
//                 Obx(() {
//                   return AppTextField(
//                     heading: "Confirm Password",
//                     hintText: '******',
//                     obscureText: !controller.isConfirmPasswordVisible.value,
//                     suffix: controller.isConfirmPasswordVisible.value
//                         ? AppIcons.viewOn
//                         : AppIcons.viewOff,
//                     prefix: AppIcons.lockSvg,
//                     controller: controller.confirmPasswordController,
//                     validator: Validators.strongPassword,
//                     onSuffixTap: controller.toggleConfirmPasswordVisibility,

//       //             );
//       //           }
//       //           ),

//       //           SizedBox(height: 3.h),

//       //           /// Log In Button
//       //           AppButtonWidget(
//       //             text: 'Save Password',
//       //             height: 5.h,
//       //             width: 100.w,
//       //             buttonColor: AppColors.blueColor,
//       //             onPressed: () {
//       //               controller.changePassword();
//       //             },
//       //           ),

//       //           const SizedBox(height: 16),
//       //         ],
//       //       ),
//       //     ),
//       //   ),
//       // ),
    );
  }
}
