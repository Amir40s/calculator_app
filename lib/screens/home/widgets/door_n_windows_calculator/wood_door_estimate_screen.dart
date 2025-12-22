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
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';

import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
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

              buildRowWithField(
                heading: "Frame Width",
                hint2: "Inches(in)",
                itemsList: controller.measuringType,
                onChangedCallback: controller.onFrameWidthUnitChanged,
                selectedValue: controller.selectedFrameWidthUnit,
                controller: controller.frameWidthController,
              ),   buildRowWithField(
                heading: "Frame Thickness",
                hint2: "Inches(in)",
                itemsList: controller.measuringType,
                onChangedCallback: controller.onFrameThicknessUnitChanged,
                selectedValue: controller.selectedFrameThicknessUnit,
                controller: controller.frameThicknessController,
              ),

              Obx(() => Column(
                    children: [
                      for (int i = 0; i < controller.doors.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          child: AppTextWidget(
                                            text: "Delete",
                                            textDecoration:
                                                TextDecoration.underline,
                                            color: Colors.red,
                                          )),
                                ],
                              ),
                              TwoFieldsWidget(
                                heading1: "Height (ft)",
                                heading2: "Width (ft)",
                                controller1:
                                    controller.doors[i].heightController,
                                controller2:
                                    controller.doors[i].widthController,
                              ),
                              AppTextField(
                                hintText: "0",
                                heading: "Quantity",
                                controller:
                                    controller.doors[i].quantityController,
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 1.h,
                      ),
                      AppButtonWidget(
                        text: "+ Add Door",
                        width: 100.w,
                        height: 5.h,
                        onPressed: controller.addDoor,
                      ),
                    ],
                  )), SizedBox(
                height: 1.h,
              ),
              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.convert,
              ),
              SizedBox(
                height: 1.h,
              ),
          AppButtonWidget(
            text: "Download PDF",
            width: 100.w,
            height: 5.h,
            onPressed: () async {
              final totalCost = controller.totalCost.value;
              final totalVolume = controller.totalVolume.value;
              final doors = controller.doors;

              if (totalVolume <= 0 || totalCost <= 0) {
                Get.snackbar("Error", "Please calculate valid results first.");
                return;
              }

              await PdfHelper.generateAndOpenPdf(
                context: Get.context!,
                title: "Wood Volume Report",
                inputData: {
                  "Frame Width:": controller.frameWidthController.text,
                  "Frame Thickness:": controller.frameThicknessController.text,
                  "Price per ft³:": controller.pricePerFtController.text,

                },
                tables: [
                  {
                    'title': "Door Details",
                    'headers': ["Door #", "Volume (ft³)", "Cost (Rs)"],
                    'rows': [
                      for (int i = 0; i < doors.length; i++)
                        [
                          (i + 1).toString(),
                          totalVolume.toStringAsFixed(2),
                          totalCost.toStringAsFixed(2),
                        ],
                    ],
                  },
                  {
                    'title': "Summary",
                    'headers': ["Item", "Value"],
                    'rows': [
                      ["Total Volume (ft³)", totalVolume.toStringAsFixed(2)],
                      ["Total Cost (Rs)", totalCost.toStringAsFixed(2)],
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
                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }
                if (controller.totalCost.value <= 0 ||
                    controller.totalVolume.value <= 0) {
                  return Center(
                    child: AppTextWidget(
                      color: AppColors.greyColor,
                      text:
                      "No results yet. Enter frame and door details and click Calculate.",
                    ),
                  );
                }

                final totalCost = controller.totalCost.value;
                final totalVolume = controller.totalVolume.value;
                final doors = controller.doors;

                return Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: "Wood Volume Results",
                      styleType: StyleType.heading,
                    ),
                    DynamicTable(headers: [
                      "Door #",
                      "Volume (ft³)",
                      "Cost (Rs)",
                    ], rows: [
                      for (int i = 0; i < doors.length; i++)
                        [
                          (i + 1).toString(),
                          totalVolume.toStringAsFixed(0),
                          totalCost.toStringAsFixed(0),
                        ],
                    ]),
                    SizedBox(
                      height: 2.h,
                    ),
                      AppTextWidget(
                        text:
                            "Total Volume: ${totalVolume.toStringAsFixed(0)} ft³",
                        styleType: StyleType.dialogHeading,
                      ),
                      AppTextWidget(
                        text:
                            "Total Cost: Rs ${totalCost.toStringAsFixed(0)}",
                        styleType: StyleType.dialogHeading,
                        color: Colors.green,
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
