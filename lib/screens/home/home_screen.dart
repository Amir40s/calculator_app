import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/icon_box_widget.dart';
import 'package:smart_construction_calculator/core/component/success_dialog.dart';
import 'package:smart_construction_calculator/core/controller/calculators/all_calculators.dart';
import 'package:smart_construction_calculator/screens/home/widgets/length_distance.dart';
import 'package:smart_construction_calculator/screens/home/widgets/showAllCalculators.dart';
import '../../config/base/base_url.dart';
import '../../core/component/category_card.dart';
import '../../core/component/history_tile.dart';
import '../../core/component/top_usage_card.dart';
import '../../core/controller/category_calulator_controller.dart';
import '../notification/notification_screen.dart';
import 'category_details/category_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerOf = Get.put(CalculatorController());
    controllerOf.fetchCalculators();
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
                        onTap: () {
                          SuccessDialog.show(context, message: "Added Successfully");
                        },
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
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ShowAllCalculatorsScreen(calculators: controllerOf.data.value ?? []));

                    },
                    child: AppTextWidget(
                      text: "See all",
                      styleType: StyleType.dialogHeading,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                color: Colors.white,
                height: 16.h,
                child: Obx(() {
                  if (controllerOf.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final calculators = controllerOf.data.value ?? [];
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: calculators.length,
                      itemBuilder: (context, index) {
                        final calc = calculators[index];
                        log('calculators length ${calc.title}');

                        return CategoryCard(
                          title: calc.title,
                          color: AppUtils().randomColor(),
                          icon: calc.iconWidget,
                          onTap: () {
                            print("🚀 Going to detail screen with:");
                            print("title: ${calc.title}");
                            print("routeKey: ${calc.routeKey}");

                            Get.to(CategoryDetailScreen(
                              title: calc.title,
                                category: calc.routeKey));
                            // // Get.to(LengthConversionScreen());
                            // ScreenMapper.navigateToScreen(calc.routeKey);

                          },
                        );
                      },
                    );
                  }
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
