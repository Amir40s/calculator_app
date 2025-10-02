import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/icon_box_widget.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';
import 'package:smart_construction_calculator/screens/home/category_details/category_detail_screen.dart';

import '../../core/component/category_card.dart';
import '../../core/component/history_tile.dart';
import '../../core/component/top_usage_card.dart';
import '../../core/controller/category_calulator_controller.dart';
import '../notification/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryCalculatorController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "Welcome 👋",
                        styleType: StyleType.heading,
                      ),
                      SizedBox(height: 4),
                      AppTextWidget(
                        text: "Need a helping hand today?",
                        styleType: StyleType.subTitle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconBoxWidget(
                        assetPath: AppIcons.search,
                        fit: BoxFit.contain,
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      IconBoxWidget(
                        assetPath: AppIcons.notification,
                        fit: BoxFit.contain,
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        onTap: () {
                          Get.to(NotificationScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: "All Categories",
                    styleType: StyleType.dialogHeading,
                  ),
                  AppTextWidget(
                    text: "See all",
                    styleType: StyleType.dialogHeading,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 16.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];

                    return CategoryCard(
                      title: category.title,
                      color: category.color,
                      innerColor: Color(0xffFAC7C7),
                      icon: category.icon,
                      onTap: () {
                        Get.to(CategoryDetailScreen(category: category));
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              /// Top Usage Calculator
              AppTextWidget(
                text: "Top Usage Calculator",
                styleType: StyleType.dialogHeading,
              ),
              // const SizedBox(height: 12),
              SizedBox(
                height: 13.h,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    TopUsageCard(
                      title: "Grey Structure Calculator",
                      color: Colors.amber,
                      icon: AppIcons.greyStructureBoq,
                    ),
                    TopUsageCard(
                      title: "Excavation Calculator",
                      color: Colors.blue,
                      icon: AppIcons.excavation,
                    ),
                    TopUsageCard(
                      title: "Termite Treat Cost Estimate",
                      color: Colors.pink,
                      icon: AppIcons.termiteTreat,
                    ),
                    TopUsageCard(
                      title: "Wood Calculator",
                      color: Colors.pink,
                      icon: AppIcons.woodCalculator,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.baseColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    /// Recent History
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text: "Recent History",
                          styleType: StyleType.subHeading,
                        ),
                        AppTextWidget(
                          text: "See all",
                          styleType: StyleType.subHeading,
                        ),
                      ],
                    ),
                    HistoryTile(
                      title: "Grey Structure Calculator",
                      time: "Today 3:16 PM",
                      icon: AppIcons.greyStructureBoq,
                    ),
                    HistoryTile(
                      title: "Wardrobe Material Estimation",
                      time: "Today 3:16 PM",
                      icon: AppIcons.greyStructureBoq,
                    ),
                    HistoryTile(
                      title: "UGWT Excavation Calculator",
                      time: "Today 3:16 PM",
                      icon: AppIcons.greyStructureBoq,
                    ),
                    HistoryTile(
                      title: "Termite Treatment Cost",
                      time: "Today 3:16 PM",
                      icon: AppIcons.greyStructureBoq,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
