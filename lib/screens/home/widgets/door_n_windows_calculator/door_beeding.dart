import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import '../../../../config/model/door_windows_model/door_shutter_model.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/textFieldWithDropdown.dart';
import '../../../../core/controller/calculators/door_windows/door_beeding_controller.dart';

class DoorBeadingScreen extends StatelessWidget {
  final String itemName;
  final controller = Get.put(DoorBeadingWoodController());

  DoorBeadingScreen({super.key, required this.itemName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: "Door Beading Wood Estimator",
                styleType: StyleType.heading,
              ),
              AppTextField(
                heading: "Price per ft³ (Rs)",
                hintText: "Enter price per cubic ft",
                controller: controller.priceController,
              ),

              // Dynamic list of doors
              ...controller.doors.asMap().entries.map((entry) {
                final index = entry.key;
                final door = entry.value;
                return Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index > 0) const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text: "Door ${index + 1}",
                          styleType: StyleType.dialogHeading,
                        ),
                        if (controller.doors.length > 1)
                          TextButton(
                            onPressed: () => controller.removeDoor(index),
                            child: AppTextWidget(
                              text: "Delete",
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),

                    TextFieldWithDropdown(
                      heading: "Door Length",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                      door.selectedLengthUnit.value = v,
                      selectedValue: door.selectedLengthUnit,
                      controller: door.lengthController,
                    ),
                    TextFieldWithDropdown(
                      heading: "Door Width",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                      door.selectedWidthUnit.value = v,
                      selectedValue: door.selectedWidthUnit,
                      controller: door.widthController,
                    ),
                    TextFieldWithDropdown(
                      heading: "Beading Width",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType2,
                      onChangedCallback: (v) =>
                      door.selectedBeadingWidthUnit.value = v,
                      selectedValue: door.selectedBeadingWidthUnit,
                      controller: door.beadingWidthController,
                    ),
                    TextFieldWithDropdown(
                      heading: "Beading Thickness",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType2,
                      onChangedCallback: (v) =>
                      door.selectedBeadingThicknessUnit.value = v,
                      selectedValue: door.selectedBeadingThicknessUnit,
                      controller: door.beadingThicknessController,
                    ),
                    AppTextField(
                      heading: "Quantity",
                      hintText: "0",
                      controller: door.quantityController,
                    ),
                  ],
                );
              }),

              SizedBox(height: 2.h),
              AppButtonWidget(
                text: "+ Add Door",
                width: 100.w,
                height: 5.h,
                onPressed: controller.addDoor,
              ),
              SizedBox(height: 1.h),
              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.calculateBeading,
              ),
              SizedBox(height: 2.h),
              Obx(() {
                final model = controller.result.value;

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // ✅ No result yet
                if (controller.result.value == null) {
                  return const Center(child: Text("No results yet"));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: "Total Volume Results",
                      styleType: StyleType.heading,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    DynamicTable(
                      headers: ["Door","Total (ft³)", "Cost (Rs)"],
                      rows: model!.results.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final result = entry.value;

                        return [
                          "Door $index",
                          AppUtils().toRoundedDouble(result.totalFt3).toStringAsFixed(0),
                          "${AppUtils().toRoundedDouble(model.totals.totalFt3).toStringAsFixed(0)} ft³"
                        ];
                      }).toList(),
                    ),


                    SizedBox(
                      height: 1.h,
                    ),
                    AppTextWidget(
                      text: "Total Wood Required",
                      styleType: StyleType.heading,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    DynamicTable(
                      headers: [
                        "Total Volume (ft³)",
                        "Total Cost (Rs)",
                      ],
                      rows: [
                        [
                          model.totals.totalFt3.toStringAsFixed(0),
                          (model.totals.totalFt3 *
                              double.parse(
                                  controller.priceController.text))
                              .toStringAsFixed(0),
                        ]
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
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
