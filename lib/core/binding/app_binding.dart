import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/category_calulator_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/common_controller.dart';
import '../controller/nav_controller.dart';
import '../controller/theme_controller.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<NavController>(() => NavController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<CommonController>(() => CommonController());
    Get.lazyPut<CategoryCalculatorController>(() => CategoryCalculatorController());
  }


}