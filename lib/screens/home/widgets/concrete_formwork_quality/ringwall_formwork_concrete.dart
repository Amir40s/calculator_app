import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/ringwall_formwork_concrete_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class RingwallFormworkConcreteScreen extends StatelessWidget {
  final String itemName;
  RingwallFormworkConcreteScreen({super.key, required this.itemName});

  final controller = Get.put(RingwallFormworkConcreteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.h,
            children: [
              AppTextWidget(
                text: "Wall Inputs",
                styleType: StyleType.heading,
              ),
              TwoFieldsWidget(
                  heading1: "Length of Plot",
                  heading2: "Width of Plot",
                  hint: "e.g., 30'6\"",
                  hint2: "e.g., 30'6\"",
                  controller1: controller.lengthOfPlotController,
                  controller2: controller.widthOfPlotController),
              TwoFieldsWidget(
                  heading1: "Width of Foundation",
                  heading2: "Thickness of Foundation",
                  hint: "e.g., 2'1\"",
                  hint2: "e.g., 2'6\"",
                  controller1: controller.widthOfFoundationController,
                  controller2: controller.thicknessOfFoundationController),
              TwoFieldsWidget(
                  heading1: "Thickness of Ring Wall",
                  heading2: "Height of Ring Wall",
                  hint: "e.g., 0'2\"",
                  hint2: "e.g., 0'3\"",
                  controller1: controller.thicknessOfRingWallController,
                  controller2: controller.heightOfRingWallController),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hintText: "0",
                      heading: "Cement",
                      controller: controller.cementController,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: AppTextField(
                      hintText: "0",
                      heading: "Sand",
                      controller: controller.sandController,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: AppTextField(
                      hintText: "0",
                      heading: "Crush",
                      controller: controller.crushController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.calculate,
              ),
              SizedBox(height: 2.h),
              Obx(
                () {
                  if(controller.isLoading.value){
                    return const Center(child: Loader(),);
                  }
                  if (controller.ringwallResult.value == null) {
                    return Center(
                        child: AppTextWidget(
                          color: AppColors.greyColor,
                            text:
                                "No results yet. Enter dimensions (e.g., 30'6\", 20'0\", 0'6\")"));
                  }
                  final res = controller.ringwallResult.value!;
                  final data = res.results;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 1.h,
                    children: [
                      AppTextWidget(
                        text: "Calculation Results",
                        styleType: StyleType.heading,
                      ),
                      DynamicTable(headers: ["Description","Quantity"],
                          rows: [
                            ["Concrete Volume (Foundation) (ft³)", (data?.volumeFoundation?.toStringAsFixed(2) ?? '')],
                            ["Concrete Volume (Ring Wall) (ft³)", (data?.volumeRingWall?.toStringAsFixed(2) ?? '')],
                            ["Total Concrete Volume (ft³)", (data?.totalVolume?.toStringAsFixed(2) ?? '')],
                            ["Formwork Area (Foundation) (ft²)", (data?.formworkFoundation?.toStringAsFixed(2) ?? '')],
                            ["Formwork Area (Ring Wall) (ft²)", (data?.formworkRingWall?.toStringAsFixed(2) ?? '')],
                            ["Total Formwork Area (ft²)", (data?.totalFormwork?.toStringAsFixed(2) ?? '')],
                            ["Cement (bags)", (data?.cementBags?.toStringAsFixed(2) ?? '')],
                            ["Sand Volume (ft³)", (data?.sandVolume?.toStringAsFixed(2) ?? '')],
                            ["Crush Volume (ft³)", (data?.crushVolume?.toStringAsFixed(2) ?? '')],
                            ["Water Required (liters)", (data?.waterRequired?.toStringAsFixed(2) ?? '')],

                      ]),
                      SizedBox(height: 2.h,),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
