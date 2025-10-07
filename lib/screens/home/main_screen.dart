import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/component/custom_navbar.dart';
import '../../core/controller/nav_controller.dart';
import '../history/history_screen.dart';
import '../saved_calculator/saved_calculator_screen.dart';
import '../settings/setting_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final  controller = Get.put(NavController());

  final List<Widget> screens = [
    const HomeScreen(),
    HistoryScreen(),
     SavedCalculatorScreen(),
     SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: Obx(() => screens[controller.currentIndex.value]),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
