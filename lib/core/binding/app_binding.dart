import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/category_calulator_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import 'package:smart_construction_calculator/core/controller/otp_controller.dart';
import 'package:smart_construction_calculator/core/controller/user_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/common_controller.dart';
import '../controller/nav_controller.dart';
import '../controller/theme_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoaderController());
    Get.put(AuthController());
    Get.put(OTPController());
    Get.put(UserController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<NavController>(() => NavController());
    Get.lazyPut<CommonController>(() => CommonController());
    Get.lazyPut<CategoryCalculatorController>(
        () => CategoryCalculatorController());
  }
}
