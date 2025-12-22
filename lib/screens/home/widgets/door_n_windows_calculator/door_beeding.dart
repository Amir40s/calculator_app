import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/model/door_windows_model/door_shutter_model.dart';
import '../../../../config/utility/pdf_helper.dart';
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
              SizedBox(height: 1.h),
              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final model = controller.result.value;

                  if (model == null) {
                    Get.snackbar("Error", "Please calculate valid results first.");
                    return;
                  }

                  final doors = controller.doors;
                  final pricePerFt3 = AppUtils().toRoundedDouble(
                    double.tryParse(controller.priceController.text) ?? 0,
                  );

                  final totalVolume = AppUtils().toRoundedDouble(model.totals.totalFt3);
                  final totalCost = AppUtils().toRoundedDouble(totalVolume * pricePerFt3);

                  await PdfHelper.generateAndOpenPdf(
                    context: Get.context!,
                    title: "DOOR BEADING WOOD ESTIMATION",
                    inputData: {
                      "Price per ft³ (Rs)": controller.priceController.text,
                    },
                    tables: [
                      for (int i = 0; i < model.results.length; i++)
                        {
                          'title': "Door ${i + 1} Details",
                          'headers': ["Property", "Value"],
                          'rows': [
                            [
                              "Length",
                              "${controller.doors[i].lengthController.text} ${controller.doors[i].selectedLengthUnit.value}"
                            ],
                            ["Unit", "${controller.doors[i].selectedLengthUnit}"],
                            [
                              "Width",
                              "${controller.doors[i].widthController.text} ${controller.doors[i].selectedWidthUnit.value}"
                            ],["Unit", "${controller.doors[i].selectedBeadingWidthUnit}"],
                            [
                              "Beading Width",
                              "${controller.doors[i].beadingWidthController.text} ${controller.doors[i].selectedBeadingWidthUnit.value}"
                            ],["Unit", "${controller.doors[i].selectedBeadingWidthUnit}"],
                            [
                              "Beading Thickness",
                              "${controller.doors[i].beadingThicknessController.text} ${controller.doors[i].selectedBeadingThicknessUnit.value}"
                            ],["Unit", "${controller.doors[i].selectedBeadingThicknessUnit}"],
                            ["Qty", controller.doors[i].quantityController.text.toString()],
                            [
                              "Total (ft³)",
                              AppUtils()
                                  .toRoundedDouble(model.results[i].totalFt3)
                                  .toStringAsFixed(2)
                            ],
                            [
                              "Cost (Rs)",
                              (AppUtils().toRoundedDouble(model.results[i].totalFt3) *
                                  double.parse(controller.priceController.text))
                                  .toStringAsFixed(2)
                            ],
                          ],
                        },
                      {
                        'title': "Summary",
                        'headers': ["Item", "Value"],
                        'rows': [
                          [
                            "Total Volume (ft³)",
                            AppUtils()
                                .toRoundedDouble(model.totals.totalFt3)
                                .toStringAsFixed(2)
                          ],
                          [
                            "Total Cost (Rs)",
                            (AppUtils().toRoundedDouble(model.totals.totalFt3) *
                                double.parse(controller.priceController.text))
                                .toStringAsFixed(2)
                          ],
                        ],
                      },
                    ],


                    fileName: "door_beading_wood_report.pdf",
                  );
                },
              ),

              SizedBox(height: 2.h),
              Obx(() {
                final model = controller.result.value;

                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }

                if (controller.result.value == null) {
                  return  Center(child: AppTextWidget(text: "No results yet"));
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
