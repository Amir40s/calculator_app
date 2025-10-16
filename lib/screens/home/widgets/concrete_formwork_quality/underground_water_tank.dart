import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/app_utils.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/underground_water_tank_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class UndergroundWaterTankScreen extends StatelessWidget {
  final String itemName;
  UndergroundWaterTankScreen({super.key, required this.itemName});
  final controller = Get.put(UndergroundWaterTankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: "Input Parameters",
                styleType: StyleType.heading,
              ),
              AppTextWidget(
                text: "Tank Internal Dimensions",
                styleType: StyleType.dialogHeading,
              ),
              AppTextField(
                hintText: "e.g., 1'2",
                heading: "Length (Internal)",
                controller: controller.lengthInternalController,
              ),
              TwoFieldsWidget(
                  heading1: "Width (Internal)",
                  heading2: "Height (Internal)",
                  hint: "e.g., 0'1",
                  hint2: "e.g., 1'4",
                  controller1: controller.widthInternalController,
                  controller2: controller.heightInternalController),
              TwoFieldsWidget(
                  heading1: "Wall Thickness",
                  heading2: "Bottom Thickness", hint: "e.g., 0'1",
                  hint2: "e.g., 1'4",

                  controller1: controller.wallThicknessController,
                  controller2: controller.bottomThicknessController),
              TwoFieldsWidget(
                  heading1: "Roof Thickness",
                  heading2: "Manhole Width", hint: "e.g., 0'1",
                  hint2: "e.g., 1'4",
                  controller1: controller.roofThicknessController,
                  controller2: controller.manholeWidthController),
              AppTextField(
                hintText: "e.g., 4'0",
                heading: "Manhole Length",
                controller: controller.manholeLengthController,
              ),
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
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: Loader());
            }
            if (controller.result.value == null) {
              return  Center(child: AppTextWidget(
                  color: AppColors.greyColor,
                  text: "No results yet. Enter dimensions (e.g., 30'6\", 20'0\", 0'6\") and click Calculate."));
            }

            final res = controller.result.value!;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 1.h,
                children: [
                  AppTextWidget(
                    text: "Calculation Results",
                    styleType: StyleType.heading,
                  ),
                  DynamicTable(headers: ["Component","Volume (ft³)"], rows: [
                    ["Tank Walls",res.wallVolume.toStringAsFixed(2)],
                    ["Tank Bottom",res.bottomVolume.toStringAsFixed(2)],
                    ["Tank Roof (Net)",res.roofVolume.toStringAsFixed(2)],

                  ]),
                  SizedBox(height: 2.h,),
                  AppTextWidget(text: "Summary",styleType: StyleType.subHeading,),
                  DynamicTable(headers: ["Item","Value"], rows: [
                    ["Total Volume (ft³)",AppUtils().toRoundedDouble(res.totalFt3).toStringAsFixed(0)],
                    ["Cement (bags)",AppUtils().toRoundedDouble(res.cementBags).toStringAsFixed(0)],
                    ["Sand (ft³)",AppUtils().toRoundedDouble(res.sandVolume).toStringAsFixed(0)],
                    ["Crush (ft³)",AppUtils().toRoundedDouble(res.crushVolume).toStringAsFixed(0)],
                    ["Water (liters)",AppUtils().toRoundedDouble(res.waterLiters).toStringAsFixed(0)],

                  ]),
                  SizedBox(height: 2.h,)


                ]);})
          ]
      ),
    )));
  }
}
