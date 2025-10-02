import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../controller/nav_controller.dart';


class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final NavController controller = Get.put(NavController());

  final List<Widget> items = const [
    Icon(Icons.home, size: 30, color: Colors.white),
    Icon(Icons.science_outlined, size: 30, color: Colors.white),
    Icon(Icons.bookmark_border, size: 30, color: Colors.white),
    Icon(Icons.person_outline, size: 30, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CurvedNavigationBar(
        index: controller.currentIndex.value,
        height: 60,
        color: const Color(0xFF0D1A3A), // navy blue
        buttonBackgroundColor: Colors.yellow,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: items,
        onTap: controller.changeScreen,
      );
    });
  }
}
