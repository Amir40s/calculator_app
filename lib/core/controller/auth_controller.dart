import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_construction_calculator/config/model/user_model.dart';
import 'package:smart_construction_calculator/config/res/app_constants.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/controller/otp_controller.dart';
import 'package:smart_construction_calculator/core/repository/auth_repository.dart';

class AuthController extends GetxController {
  final _authRepository = AuthRepository.instance;

  TextEditingController? _signUpEmailC;
  TextEditingController? _signUpFirstNameC;
  TextEditingController? _signUpLastNameC;
  TextEditingController? _signUpPasswordC;
  TextEditingController? _loginEmailC;
  TextEditingController? _loginPasswordC;

  TextEditingController? get signUpFirstNameC => _signUpFirstNameC;
  TextEditingController? get signUpLastNameC => _signUpLastNameC;
  TextEditingController? get signUpEmailC => _signUpEmailC;
  TextEditingController? get signUpPasswordC => _signUpPasswordC;
  TextEditingController? get loginEmailC => _loginEmailC;
  TextEditingController? get loginPasswordC => _loginPasswordC;

  @override
  void onInit() {
    _signUpEmailC = TextEditingController();
    _signUpFirstNameC = TextEditingController();
    _signUpLastNameC = TextEditingController();
    _signUpPasswordC = TextEditingController();
    _loginEmailC = TextEditingController();
    _loginPasswordC = TextEditingController();
    super.onInit();
  }

  String? _pendingUserId;

  Future<void> continueWithGoogle({required BuildContext context}) async {
    loaderC.showLoader();
    await GoogleSignIn().signOut();

    final response = await _authRepository.continueWithGoogle();

    response.fold(
      (error) {
        AppUtils.showToast(text: error.message, bgColor: Colors.red);
      },
      (user) async {
        await userC.loadCurrentUser();
        AppUtils.showToast(text: 'Login Successful', bgColor: Colors.green);
        Get.offAllNamed(RoutesName.mainScreen);
      },
    );

    loaderC.hideLoader();
  }

  Future<void> sendPasswordResetEmail({required BuildContext context}) async {
    if (_loginEmailC!.text.trim().isEmpty) {
      AppUtils.showToast(text: 'Please enter your email', bgColor: Colors.red);
      return;
    }

    loaderC.showLoader();
    final response = await _authRepository.sendPasswordResetEmail(
      email: _loginEmailC!.text.trim(),
    );

    response.fold(
      (error) => AppUtils.showToast(text: error.message, bgColor: Colors.red),
      (_) => AppUtils.showToast(
          text: 'Password reset email sent', bgColor: Colors.green),
    );

    loaderC.hideLoader();
  }

  Future<void> signup({required BuildContext context}) async {
    loaderC.showLoader();
  await Future.delayed(Duration.zero); 
    try {
     final response = await _authRepository.signup(
  user: UserModel(
    firstName: _signUpFirstNameC!.text.trim(),
    lastName: _signUpLastNameC!.text.trim(),
    email: _signUpEmailC!.text.trim(),
    password: _signUpPasswordC!.text.trim(),
  ),
);

response.fold(
  (error) {
    AppUtils.showToast(text: error.message, bgColor: Colors.red);
    loaderC.hideLoader();
  },
  (user) async {
    _pendingUserId = user.id;

    if (_pendingUserId == null) {
      AppUtils.showToast(
          text: 'Signup failed, please try again.', bgColor: Colors.red);
      loaderC.hideLoader();
      return;
    }

    final otpController = Get.find<OTPController>();
    await otpController.sendOTP(context);
    Get.toNamed(RoutesName.confirmOtp);
  },
);

    } catch (error) {
      AppUtils.showToast(text: error.toString(), bgColor: Colors.red);
    } finally {
      loaderC.hideLoader();
    }
  }

  Future<void> checkEmailExist({required BuildContext context}) async {
    loaderC.showLoader();
    final response = await _authRepository.checkEmailExist(
        email: _signUpEmailC?.text.trim() ?? '');

    response.fold(
      (error) {
        AppUtils.showToast(text: error.message, bgColor: Colors.red);
        loaderC.hideLoader();
      },
      (isEmailExist) async {
        if (isEmailExist) {
          AppUtils.showToast(text: 'Email already exist', bgColor: Colors.red);
        } else {
          await otpC.sendOTP(context);
          Get.toNamed(RoutesName.confirmOtp);
        }
        loaderC.hideLoader();
      },
    );
  }

 Future<void> verifyOTPAndSaveUser(BuildContext context) async {
  print('🔍 VERIFY OTP CALLED');

  if (_pendingUserId == null) {
    AppUtils.showToast(
      text: 'User ID missing. Please sign up again.',
      bgColor: Colors.red,
    );
    return;
  }

  loaderC.showLoader(); 

  final user = UserModel(
    id: _pendingUserId!,
    firstName: _signUpFirstNameC?.text.trim() ?? '',
    lastName: _signUpLastNameC?.text.trim() ?? '',
    email: _signUpEmailC?.text.trim() ?? '',
    password: _signUpPasswordC?.text.trim() ?? '',
  );

  try {
    await _authRepository.saveUserToFirestore(user);

    AppUtils.showToast(
      text: 'Signup successful!',
      bgColor: Colors.green,
    );

    Get.offAllNamed(RoutesName.mainScreen);
  } catch (e, st) {
    print('🔥 ERROR while saving user: $e\n$st');

    AppUtils.showToast(
      text: 'Failed to verify OTP. Please try again.',
      bgColor: Colors.red,
    );
  } finally {
    loaderC.hideLoader();
  }
}




  Future<void> deleteUnverifiedUser() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    await currentUser.delete();
  }
}


  Future<void> login({required BuildContext context}) async {
    loaderC.showLoader();
    final response = await _authRepository.login(
      user: UserModel(
        email: _loginEmailC!.text.trim(),
        password: _loginPasswordC!.text.trim(),
      ),
    );

    response.fold(
      (error) => AppUtils.showToast(text: error.message, bgColor: Colors.red),
      (user) async {
        AppUtils.showToast(text: 'Login Successful', bgColor: Colors.green);
        Get.offAllNamed(RoutesName.mainScreen);
      },
    );

    loaderC.hideLoader();
  }

  Future<void> logout() async {
    loaderC.showLoader();
    await _authRepository.logout();
    loaderC.hideLoader();
    Get.offAllNamed(RoutesName.splash,);
  }

  @override
  void dispose() {
    _signUpEmailC?.dispose();
    _signUpFirstNameC?.dispose();
    _signUpLastNameC?.dispose();
    _signUpPasswordC?.dispose();
    _loginEmailC?.dispose();
    _loginPasswordC?.dispose();
    super.dispose();
  }
}
