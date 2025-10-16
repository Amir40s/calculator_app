import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/overhead_water_tank_formwork_controller.dart';

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
                      title: const Text("Same Size"),
                      value: "Same Size",
                      groupValue: controller.pickupColumnType.value,
                      onChanged: (value) => controller.pickupColumnType.value = value!,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Different"),
                      value: "Different",
                      groupValue: controller.pickupColumnType.value,
                      onChanged: (value) => controller.pickupColumnType.value = value!,
                    ),
                  ),
                ],
              )),

              TwoFieldsWidget(
                heading1: "Column Length",
                heading2: "Column Width",
                hint: "e.g., 0'2\"",
                hint2: "e.g., 0'3\"",
                controller1: controller.columnLengthController,
                controller2: controller.columnWidthController,
              ),
              AppTextField(
                hintText: "e.g., 0'2\"",
                heading: "Column Height",
                controller: controller.columnHeightController,
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
            ],
          ),
        ),
      ),
    );
  }
}
