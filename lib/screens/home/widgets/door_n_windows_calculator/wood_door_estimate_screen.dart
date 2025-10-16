import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';

import '../../../../core/component/app_text_field.dart';
import '../../../../core/controller/calculators/door_windows/door_windows_controller.dart';

class WoodDoorEstimateScreen extends StatelessWidget {
  final String itemName;
  WoodDoorEstimateScreen({super.key, required this.itemName});

  final controller = Get.put(DoorWindowsController());
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
              AppTextWidget(
                text: "Wood Volume Calculator",
                styleType: StyleType.heading,
              ),
              AppTextField(
                hintText: "Enter Price per cubic ft",
                heading: "Price per ft³ (Rs)",
                controller: controller.pricePerFtController,
              ),
              AppTextField(
                hintText: "0",
                heading: "Frame Width",
                controller: controller.frameWidthController,
              ),
              ReusableDropdown(
                selectedValue: controller.selectedFrameWidthUnit,
                itemsList: controller.measuringType,
                hintText: "Select Measuring Type",
                onChangedCallback: controller.onFrameWidthUnitChanged,
              ),
              AppTextField(
                hintText: "0",
                heading: "Frame Thickness",
                controller: controller.frameThicknessController,
              ),
              ReusableDropdown(
                selectedValue: controller.selectedFrameThicknessUnit,
                itemsList: controller.measuringType,
                hintText: "Select Measuring Type",
                onChangedCallback: controller.onFrameThicknessUnitChanged,
              ),
              Obx(() => Column(
                children: [
                  for (int i = 0; i < controller.doors.length; i++)
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextWidget(
                                text: 'Door ${i + 1}',
                                styleType: StyleType.dialogHeading,
                              ),
                              if (controller.doors.length > 1)
                                if (i > 0)
                                  GestureDetector(
                                      onTap: () {
                                        controller.removeDoor(i);
                                      },
                                      child: AppTextWidget(text: "Delete",textDecoration:TextDecoration.underline,color: Colors.red,)),
                            ],
                          ),
                          TwoFieldsWidget(
                            heading1: "Height (ft)",
                            heading2: "Width (ft)",
                            controller1: controller.doors[i].heightController,
                            controller2: controller.doors[i].widthController,
                          ),
                          AppTextField(
                            hintText: "0",
                            heading: "Quantity",
                            controller: controller.doors[i].quantityController,
                          ),
                        ],
                      ),
                    ),
                  AppButtonWidget(
                    text: "+ Add Door",
                    width: 100.w,
                    height: 5.h,
                    onPressed: controller.addDoor,
                  ),
                ],
              )),
              SizedBox(height: 2.h,),
              AppButtonWidget(text: "Calculate",width: 100.w,height: 5.h,
              onPressed: controller.convert,
              ),
              SizedBox(height: 2.h,),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(text: "Wood Volume Results",styleType: StyleType.heading,),
                    DynamicTable(headers: [
                      "Door #",
                      "Volume (ft³)",
                      "Cost (Rs)",
                    ], rows:
                    [
                      for (int i = 0; i < controller.doors.length; i++)
                      [
                        (i + 1).toString(),
                        controller.totalVolume.value.toStringAsFixed(0),
                        controller.totalCost.value.toStringAsFixed(0),
                      ],

                    ]
                    ),
                    SizedBox(height: 2.h,),
                    if (controller.totalVolume.value > 0)
                      AppTextWidget(
                        text: "Total Volume: ${controller.totalVolume.value.toStringAsFixed(0)} ft³",
                        styleType: StyleType.dialogHeading,
                      ),
                    if (controller.totalCost.value > 0)
                      AppTextWidget(
                        text: "Total Cost: Rs ${controller.totalCost.value.toStringAsFixed(0)}",
                        styleType: StyleType.dialogHeading,
                        color: Colors.green,
                      ),
                    SizedBox(height: 2.h,),

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
