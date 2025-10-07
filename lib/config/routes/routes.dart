
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/screens/onbaording/auth/sign_up_screen.dart';
import 'package:smart_construction_calculator/screens/onbaording/forget_password/confirm_otp.dart';
import 'package:smart_construction_calculator/screens/onbaording/splash.dart';
import '../../screens/home/main_screen.dart';
import '../../screens/onbaording/auth/login_screen.dart';
import '../../screens/onbaording/forget_password/forget_password_screen.dart';
import '../../screens/onbaording/forget_password/new_password_screen.dart';
import '../../screens/onbaording/onboarding_screen.dart';



class Routes{
  static final routes = [
    GetPage(name: RoutesName.splash, page: ()=>  SplashScreen()),
    GetPage(name: RoutesName.onboarding, page: ()=>  OnboardingScreen()),
    GetPage(name: RoutesName.login, page: ()=>  LoginScreen()),
    GetPage(name: RoutesName.signUp, page: ()=>  SignUpScreen()),
    GetPage(name: RoutesName.forgetPassword, page: ()=>  ForgetPasswordScreen()),
    GetPage(name: RoutesName.confirmOtp, page: ()=>  ConfirmOtpScreen()),
    GetPage(name: RoutesName.newPassword, page: ()=>  NewPasswordScreen()),
    GetPage(name: RoutesName.mainScreen, page: ()=>  MainScreen()),
  ];
}