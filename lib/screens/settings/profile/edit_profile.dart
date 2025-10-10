import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/Camera_widget.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import 'package:smart_construction_calculator/core/controller/user_controller.dart';
import '../../../config/res/app_color.dart';
import '../../../config/utility/app_utils.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final UserController userC = Get.find<UserController>();
  final LoaderController loaderC = Get.find<LoaderController>();

  @override
  Widget build(BuildContext context) {
    return GlobalLoader(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Obx(() {
            final user = userC.currentUser;

            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(text: 'Edit Profile', showDivider: true),
                    SizedBox(height: 3.h),
                    Center(child: EditableProfilePicture(radius: 8.h)),
                    SizedBox(height: 4.h),

                    AppTextField(
                      heading: 'First name',
                      hintText: 'Enter name',
                      suffix: AppIcons.userTwo,
                      controller: userC.fullNameController,
                    ),

                    AppTextField(
                      heading: 'Email',
                      hintText: 'Enter email',
                      suffix: AppIcons.mail,
                      controller: userC.emailController,
                    ),

                    SizedBox(height: 6.h),

                    AppButtonWidget(
                      text: 'Save',
                      width: 100.w,
                      height: 6.h,
                      buttonColor: AppColors.blueColor,
                      textColor: AppColors.whiteColor,
                      radius: 2.w,
                      onPressed: () async {
                        loaderC.showLoader();

                        try {
                          String? uploadedImageUrl = user.image;
                          if (userC.selectedImage.value != null) {
                            uploadedImageUrl =
                                await AppUtils.uploadImageToFirebase(
                              userC.selectedImage.value!,
                              "profile_images/${user.id}",
                            );
                          }

                          final updatedUser = user.copyWith(
                            firstName: userC.fullNameController.text.trim(),
                            email: userC.emailController.text.trim(),
                            password: userC.passwordController.text.trim(),
                            image: uploadedImageUrl,
                          );

                          await userC.updateUserProfile(updatedUser);

                          AppUtils.showToast(
                            text: "Profile updated successfully!",
                            bgColor: AppColors.blueColor,
                          );
                        } catch (e) {
                          AppUtils.showToast(
                            text: "Failed to update profile. Try again.",
                            bgColor: Colors.redAccent,
                          );
                        } finally {
                          loaderC.hideLoader();
                        }
                      },
                    ),

                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
