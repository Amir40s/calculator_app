import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/res/app_color.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/overhead_water_tank_formwork_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class OverheadWaterTankFormworkScreen extends StatelessWidget {
  final String itemName;
  final controller = Get.put(OverheadWaterTankFormworkController());

  OverheadWaterTankFormworkScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: "Tank Inputs", styleType: StyleType.heading),
              AppTextWidget(text: "Tank Internal Dimensions", styleType: StyleType.subHeading),

              TwoFieldsWidget(
                heading1: "Length (Internal)",
                heading2: "Width (Internal)",
                hint: "e.g., 30'6\"",
                hint2: "e.g., 30'6\"",
                controller1: controller.lengthInternalController,
                controller2: controller.widthInternalController,
              ),
              TwoFieldsWidget(
                heading1: "Height (Internal)",
                heading2: "Wall Thickness",
                hint: "e.g., 2'1\"",
                hint2: "e.g., 2'6\"",
                controller1: controller.heightInternalController,
                controller2: controller.wallThicknessController,
              ),
              TwoFieldsWidget(
                heading1: "Bottom Thickness",
                heading2: "Roof Thickness",
                hint: "e.g., 0'2\"",
                hint2: "e.g., 0'3\"",
                controller1: controller.bottomThicknessController,
                controller2: controller.roofThicknessController,
              ),

              AppTextWidget(text: "Manhole Opening", styleType: StyleType.subHeading),
              TwoFieldsWidget(
                heading1: "Manhole Length",
                heading2: "Manhole Width",
                hint: "e.g., 0'2\"",
                hint2: "e.g., 0'3\"",
                controller1: controller.manholeLengthController,
                controller2: controller.manholeWidthController,
              ),

              AppTextWidget(text: "Pickup Columns", styleType: StyleType.subHeading),

              // 🔘 Radio Buttons
              Obx(() => Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: AppTextWidget(text: "Same Size"),
                      value: "Same Size",
                      activeColor: AppColors.blueColor,
                      contentPadding: EdgeInsets.zero,
                      groupValue: controller.pickupColumnType.value,
                      onChanged: (value) => controller.pickupColumnType.value = value!,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title:  AppTextWidget(text: "Different"),
                      value: "Different",
                      activeColor: AppColors.blueColor,
                      contentPadding: EdgeInsets.zero,
                      groupValue: controller.pickupColumnType.value,
                      onChanged: (value) => controller.pickupColumnType.value = value!,
                    ),
                  ),
                ],
              )),

              Obx(() {
                if (controller.pickupColumnType.value == "Same Size") {
                  // 👇 Single Column Input (Same for all 4)
                  return Column(
                    spacing: 1.h,
                    children: [
                      TwoFieldsWidget(
                        heading1: "Column Length",
                        heading2: "Column Width",
                        hint: "e.g., 0'2\"",
                        hint2: "e.g., 0'3\"",
                        controller1: controller.columnLengthController,
                        controller2: controller.columnWidthController,
                      ),
                      AppTextField(
                        heading: "Column Height",
                        hintText: "e.g., 0'3\"",
                        controller: controller.columnHeightController,
                      ),
                    ],
                  );
                } else {
                  // 👇 4 Unique Columns
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(controller.columnList.length, (index) {
                      final col = controller.columnList[index];
                      return Column(
                        spacing: 1.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: "Column ${index + 1}",
                            styleType: StyleType.dialogHeading,
                          ),
                          TwoFieldsWidget(
                            heading1: "Length",
                            heading2: "Width",
                            hint: "e.g., 0'2\"",
                            hint2: "e.g., 0'3\"",
                            controller1: col['length']!,
                            controller2: col['width']!,
                          ),
                          AppTextField(
                            heading: "Height",
                            hintText: "e.g., 0'3\"",
                            controller: col['height']!,
                          ),
                          SizedBox(height: 1.h),
                        ],
                      );
                    }),
                  );
                }
              }),

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
                  return const Center(child: Loader());
                }
                if (controller.tankResult.value == null) {
                  return  Center(child: AppTextWidget(
                      color: AppColors.greyColor,
                      text: "No results yet. Enter details (e.g., 4.5, 0.5) and click Calculate."));
                }

                final res = controller.tankResult.value!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1.h,
                  children: [
                    AppTextWidget(
                      text: "Calculation Results",
                      styleType: StyleType.heading,
                    ),
                    AppTextWidget(text: "Concrete Volume",styleType: StyleType.subHeading,),
                    DynamicTable(headers: ["Component","Volume (ft³)"], rows: [
                      ["Bottom Slab",res.bottomVolume.toStringAsFixed(2)],
                      ["Walls",res.wallVolume.toStringAsFixed(2)],
                      ["Roof (Net)",res.roofVolume.toStringAsFixed(2)],
                      ["Columns",res.columnVolume.toStringAsFixed(2)],
                      ["Total Concrete Volume",res.totalVolume.toStringAsFixed(0)],

                    ]),
                    SizedBox(height: 2.h,),
                    AppTextWidget(text: "Shuttering",styleType: StyleType.subHeading,),
                    DynamicTable(headers: ["Component","Shuttering Area (ft²)"], rows: [
                      ["Tank Walls (External + Internal)",res.totalShuttering.toStringAsFixed(2)],
                      ["Roof Slab + Side Shuttering + Manhole",res.cementBags.toStringAsFixed(2)],
                      ["Columns",res.sandVolume.toStringAsFixed(2)],
                      ["Total Shuttering",res.totalShuttering.toStringAsFixed(0)],
                    ]),
                    SizedBox(height: 2.h,),
                    AppTextWidget(text: "Material Requirements",styleType: StyleType.subHeading,),
                    DynamicTable(headers: ["Material","Quantity"], rows: [
                      ["Cement","${res.cementBags.toStringAsFixed(0)} bags"],
                      ["Sand","${res.sandVolume.toStringAsFixed(0)} ft³"],
                      ["Crush","${res.crushVolume.toStringAsFixed(0)} ft³"],
                      ["Water","${res.waterLiters.toStringAsFixed(0)} liters"],
                    ]),
                    SizedBox(height: 2.h,)


                  ],
                );

              }),
            ],
          ),
        ),
      ),
    );
  }
}
