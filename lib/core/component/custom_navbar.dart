import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import '../controller/nav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        bottom: true,
        child: CurvedNavigationBar(

          index: controller.currentIndex.value,
          height: 7.h,
          color: AppColors.blueColor,
          buttonBackgroundColor: AppColors.themeColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          items: [
            _buildNavItem(AppIcons.home, 0),
            _buildNavItem(AppIcons.history, 1),
            _buildNavItem(AppIcons.save, 2),
            _buildNavItem(AppIcons.userTwo, 3),
          ],
          onTap: controller.changeScreen,
        ),
      );
    });
  }

  Widget _buildNavItem(String icon, int index) {
    bool isActive = controller.currentIndex.value == index;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedScale(
        scale: isActive ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: SvgPicture.asset(
          icon,
          height: isActive ? 22 : 26,
          color: isActive ? Colors.white : AppColors.whiteColor,
        ),
      ),
    );
  }
}
