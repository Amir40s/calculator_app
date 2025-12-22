import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/door_windows/door_shutter_wood_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/model/door_windows_model/door_shutter_model.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/app_button_widget.dart';

class DoorShutterWoodScreen extends StatelessWidget {
  final String itemName;
  final controller = Get.put(DoorShutterWoodController());

  DoorShutterWoodScreen({super.key, required this.itemName});
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
                text: "Door Shutter Wood Estimator",
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
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => RadioListTile<String>(
                                title: AppTextWidget(
                                    text: controller.doorTypes[0]),
                                value: controller.doorTypes[0].toLowerCase(),
                                groupValue: door.selectedDoorType.value,
                                activeColor: AppColors.blueColor,
                                onChanged: (value) {
                                  if (value != null) {
                                    door.selectedDoorType.value = value;
                                  }
                                },
                              )),
                        ),
                        Expanded(
                          child: Obx(() => RadioListTile<String>(
                                title: AppTextWidget(
                                    text: controller.doorTypes[1]),
                                value: controller.doorTypes[1].toLowerCase(),
                                groupValue: door.selectedDoorType.value,
                                activeColor: AppColors.blueColor,
                                onChanged: (value) {
                                  if (value != null) {
                                    door.selectedDoorType.value = value;
                                  }
                                },
                              )),
                        ),
                      ],
                    ),
                    buildRowWithField(
                      heading: "Height",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                          door.selectedHeightUnit.value = v,
                      selectedValue: door.selectedHeightUnit,
                      controller: door.heightController,
                    ),
                    buildRowWithField(
                      heading: "Width",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                          door.selectedWidthUnit.value = v,
                      selectedValue: door.selectedWidthUnit,
                      controller: door.widthController,
                    ),
                    buildRowWithField(
                      heading: "Thickness",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                          door.selectedThicknessUnit.value = v,
                      selectedValue: door.selectedThicknessUnit,
                      controller: door.thicknessController,
                    ),
                    buildRowWithField(
                      heading: "Stile Width",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                          door.selectedStileWidthUnit.value = v,
                      selectedValue: door.selectedStileWidthUnit,
                      controller: door.stileWidthController,
                    ),
                    buildRowWithField(
                      heading: "Top Rail",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                          door.selectedTopRailUnit.value = v,
                      selectedValue: door.selectedTopRailUnit,
                      controller: door.topRailController,
                    ),
                    buildRowWithField(
                      heading: "Mid Rail",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                          door.selectedMidRailUnit.value = v,
                      selectedValue: door.selectedMidRailUnit,
                      controller: door.midRailController,
                    ),
                    buildRowWithField(
                      heading: "Bottom Rail",
                      hint2: "Feet (ft)",
                      itemsList: controller.measuringType,
                      onChangedCallback: (v) =>
                          door.selectedBottomRailUnit.value = v,
                      selectedValue: door.selectedBottomRailUnit,
                      controller: door.bottomRailController,
                    ),
                    TwoFieldsWidget(
                      heading1: "Quantity",
                      heading2: "Panels",
                      controller1: door.quantityController,
                      controller2: door.panelsController,
                    ),
                  ],
                );
              }).toList(),

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
                onPressed: controller.calculateVolume,
              ),              SizedBox(height: 1.h),

              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final model = controller.result.value;

                  final doors = controller.doors;
                  final price = double.tryParse(controller.priceController.text) ?? 0.0;

                  if (model == null) {
                    Get.snackbar("Error", "Please calculate valid results first.");
                    return;
                  }
                  final totalVolume = AppUtils().toRoundedDouble(model.totals.totalFt3);
                  final totalCost = AppUtils().toRoundedDouble(totalVolume * price);

                  await PdfHelper.generateAndOpenPdf(
                    context: Get.context!,
                    title: "DOOR VOLUME ESTIMATION",
                    inputData: {
                      "Price per ft³:": controller.priceController.text,

                    },
                    tables: [
                      {
                        'title': "Door Details",
                        'headers': ["Door #", "Total (ft³)", "Cost (Rs)"],
                        'rows': [
                          for (int i = 0; i < doors.length; i++)
                            [
                              (i + 1).toString(),
                              "${AppUtils().toRoundedDouble(model.results[i].totalFt3).toStringAsFixed(0)}",
                              ((AppUtils().toRoundedDouble(model.results[i].totalFt3) *
                                  AppUtils().toRoundedDouble(double.parse(
                                      controller.priceController.text)))
                                  .toStringAsFixed(0))                            ],
                        ],
                      },
                      {
                        'title': "Summary",
                        'headers': ["Item", "Value"],
                        'rows': [
                          ["Total Volume (ft³)", totalVolume.toStringAsFixed(0)],
                          ["Total Cost (Rs)", totalCost.toStringAsFixed(0)],
                        ],
                      },
                    ],
                    fileName: "wood_volume_report.pdf",
                  );
                },),
              SizedBox(
                height: 2.h,
              ),
              Obx(() {
                final model = controller.result.value;

                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }
                if (controller.result.value == null) {
                  return  Center(child: AppTextWidget( text: "No results yet. Enter door details and click Calculate."));
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
                      headers: [
                        "Door No",
                        "Total (ft³)",
                        "Cost (Rs)",
                      ],
                      rows: model?.results.asMap().entries.map((entry) {
                            final index = entry.key + 1;
                            final DoorShutterResult door = entry.value;
                            return [
                              "Door $index",
                              door.totalFt3.toStringAsFixed(0),
                              ((AppUtils().toRoundedDouble(door.totalFt3) *
                                      AppUtils().toRoundedDouble(double.parse(
                                          controller.priceController.text)))
                                  .toStringAsFixed(0))
                            ];
                          }).toList() ??
                          [],
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
                      rows: model != null
                          ? [
                              [
                                "${AppUtils().toRoundedDouble(model.totals.totalFt3).toStringAsFixed(0)}",
                                ((AppUtils().toRoundedDouble(model.totals.totalFt3) *
                                    AppUtils().toRoundedDouble(double.parse(
                                        controller.priceController.text)))
                                    .toStringAsFixed(0))
                              ]
                            ]
                          : [],
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

  Row buildRowWithField({
    required TextEditingController controller,
    required RxString selectedValue,
    required RxList<String> itemsList,
    required String hint2,
    heading,
    required void Function(String) onChangedCallback,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: AppTextField(
            hintText: "0",
            heading: heading,
            controller: controller,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ReusableDropdown(
            selectedValue: selectedValue,
            itemsList: itemsList,
            hintText: hint2,
            alignWithTextFieldHeading: true,
            onChangedCallback: onChangedCallback,
          ),
        ),
      ],
    );
  }
}
