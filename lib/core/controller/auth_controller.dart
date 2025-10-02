import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes_name.dart';

class AuthController extends GetxController {
  // Form Key
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final newPasswordFormKey = GlobalKey<FormState>();
  // Text Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final forgetPasswordController = TextEditingController();

  // Reactive password visibility
  var isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Toggle password visibility
  void togglePasswordVisibility() => isPasswordVisible.toggle();

  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  // Validate and Login
  Future<void> login() async {
    Get.toNamed(RoutesName.mainScreen);

    // if (loginFormKey.currentState?.validate() ?? false) {
    //   Get.snackbar("Success", "Login Successful");
    //   Get.toNamed(RoutesName.mainScreen);
    //   emailController.clear();
    //   passwordController.clear();
    // } else {
    //   Get.snackbar("Error", "Please fix errors");
    // }
  }

  Future<void> signup() async {
    if (signupFormKey.currentState?.validate() ?? false) {
      // ✅ Valid form, perform login logic
      Get.snackbar("Success", "Login Successful");
      emailController.clear();
      passwordController.clear();
      firstNameController.clear();
      lastNameController.clear();
    } else {
      Get.snackbar("Error", "Please fix errors");
    }
  }

  Future<void> sendCode() async {
    if (forgetPasswordFormKey.currentState?.validate() ?? false) {
      Get.toNamed(RoutesName.confirmOtp);

      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
      );

      forgetPasswordController.clear();
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all required fields",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> changePassword() async {
    if (newPasswordFormKey.currentState?.validate() ?? false) {
      // Check if both password fields match
      if (passwordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        Get.snackbar(
          "Success",
          "Password Changed Successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        passwordController.clear();
        confirmPasswordController.clear();

        Get.offAllNamed(RoutesName.login);
      } else {
        Get.snackbar(
          "Error",
          "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all required fields",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
