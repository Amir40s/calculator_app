import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/formula_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../core/component/textFieldWithDropdown.dart';
import '../../../../core/controller/calculators/finishin_interior_estimator/paint_quantity_controller.dart';

class PaintQuantityCalculatorScreen extends StatelessWidget {
  final String itemName;
  PaintQuantityCalculatorScreen({super.key, required this.itemName});

  final controller = Get.put(PaintQuantityController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1.h,
              children: [
                AppTextWidget(
                  text: "Wall/Roof Input",
                  styleType: StyleType.heading,
                ),
                AppTextWidget(
                  text: "Walls/Roofs",
                  styleType: StyleType.subHeading,
                ),
                ...List.generate(controller.walls.length, (index) {
                  final wall = controller.walls[index];
                  return Column(
                    spacing: 1.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),

                      if (controller.walls.length > 1)
                        Align(
                          alignment: Alignment.centerRight,
                          child: AppButtonWidget(
                            onPressed: () => controller.removeWall(index),
                            text: "Delete",
                            alignment: Alignment.centerRight,
                            buttonColor: Colors.red,
                            radius: 10.px,
                          ),
                        ),
                      TextFieldWithDropdown(
                        controller: wall.tagController,
                        heading: "Tag:",
                        hint2: "",
                        itemsList: controller.typeList,
                        onChangedCallback: (val) =>
                            wall.selectedType.value = val,
                        selectedValue: wall.selectedType,
                      ),
                      TwoFieldsWidget(
                        heading1: "Length (ft):",
                        heading2: "Height (ft):",
                        controller1: wall.heightController,
                        controller2: wall.widthController,
                      ),

                      TwoFieldsWidget(
                        heading1: "Number of Windows:",
                        heading2: "Number of Doors:",
                        controller1: wall.noOfWindowsController,
                        controller2: wall.noOfDoorsController,
                      ),
                      // --- Dynamic window fields ---
                      if (wall.windowFields.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: "Window Details:",
                              styleType: StyleType.dialogHeading,
                            ),
                            ...List.generate(wall.windowFields.length, (i) {
                              final win = wall.windowFields[i];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.5.h, horizontal: 2.w),
                                child: TwoFieldsWidget(
                                  heading1: "Window ${i + 1} Length (ft):",
                                  heading2: "Window ${i + 1} Width (ft):",
                                  controller1: win['length']!,
                                  controller2: win['width']!,
                                ),
                              );
                            }),
                          ],
                        ),

                      // --- Dynamic door fields ---
                      if (wall.doorFields.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: "Door Details:",
                              styleType: StyleType.dialogHeading,
                            ),
                            ...List.generate(wall.doorFields.length, (i) {
                              final door = wall.doorFields[i];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.5.h, horizontal: 2.w),
                                child: TwoFieldsWidget(
                                  heading1: "Door ${i + 1} Length (ft):",
                                  heading2: "Door ${i + 1} Width (ft):",
                                  controller1: door['length']!,
                                  controller2: door['width']!,
                                ),
                              );
                            }),
                          ],
                        ),

                      AppTextField(
                        hintText: '0',
                        heading: "Number of Primer Coats:",
                        controller: wall.noOfPrimeController,
                      ),
                      AppTextField(
                        hintText: '0',
                        heading: "Number of Putty Coats:",
                        controller: wall.noOfPuttyController,
                      ),
                      AppTextField(
                        hintText: '0',
                        heading: "Number of Paint Coats:",
                        controller: wall.noOfPaintController,
                      ),
                      ReusableDropdown(
                        selectedValue: wall.selectedPaintType,
                        itemsList: controller.paintType,
                        hintText: 'Paint Type:',
                        onChangedCallback: (val) =>
                            wall.selectedPaintType.value = val,
                      ),
                      if (controller.walls.length > 1) const Divider(),
                    ],
                  );
                }),
                SizedBox(
                  height: 2.h,
                ),
                AppButtonWidget(
                  text: '+ Add Wall',
                  width: 100.w,
                  height: 5.h,
                  onPressed: controller.addWall,
                ),
                AppButtonWidget(
                    text: 'Calculate',
                    width: 100.w,
                    height: 5.h,
                    onPressed: () {
                      controller.convert();
                    }),
                SizedBox(
                  height: 2.h,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: Loader());
                  }
                  final result = controller.result.value;
                  if (result == null) {
                    return const Center(child: Text('Please calculate again.'));
                  }
                  final summary = result.summary;
                  final walls = result.walls ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 1.h,
                    children: [
                      AppTextWidget(
                        text: "Paint Results",
                        styleType: StyleType.heading,
                      ),
                      AppTextWidget(
                        text: "Summary",
                        styleType: StyleType.subHeading,
                      ),
                      DynamicTable(headers: [
                        "Description",
                        "Value"
                      ], rows: [
                        [
                          "Total Primer:",
                          "${summary!.primer!.toStringAsFixed(2)} L"
                        ],
                        [
                          "Total Putty:",
                          "${summary.putty!.toStringAsFixed(2)} Kg"
                        ],
                        ["Total SPD:", "${summary.spd!.toStringAsFixed(2)} L"],
                        [
                          "Total Emulsion:",
                          "${summary.emulsion!.toStringAsFixed(2)} L"
                        ],
                        [
                          "Total Weather Coat:",
                          "${summary.weatherCoat!.toStringAsFixed(2)} L"
                        ],
                      ]),
                      ...walls.asMap().entries.map((entry) {
                        final index = entry.key;
                        final wall = entry.value;

                        final wallRows = [
                          ["Type", wall.wallType ?? '-'],
                          ["Length", wall.wallLength?.toStringAsFixed(2) ?? '-'],
                          ["Height", wall.wallHeight?.toStringAsFixed(2) ?? '-'],
                          ["Window Area (ft²)", wall.windowArea?.toStringAsFixed(2) ?? '-'],
                          ["Door Area (ft²)", wall.doorArea?.toStringAsFixed(2) ?? '-'],
                          ["Net Area (ft²)", wall.areaFt?.toStringAsFixed(2) ?? '-'],
                          ["Net Area (m²)", wall.areaM2?.toStringAsFixed(2) ?? '-'],
                          ["Primer (L)", wall.primerQty?.toStringAsFixed(2) ?? '-'],
                          ["Putty (kg)", wall.puttyQty?.toStringAsFixed(2) ?? '-'],
                          ["Paint Type", wall.paintType ?? '-'],
                          ["Paint (L)", wall.paintQty?.toStringAsFixed(2) ?? '-'],
                        ];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 1.h,
                          children: [
                            AppTextWidget(
                              text: "Wall ${index + 1}",
                              styleType: StyleType.subHeading,
                            ),
                            DynamicTable(
                              headers: ["Description", "Value"],
                              rows: wallRows,
                            ),
                            SizedBox(height: 2.h),
                            FormulaWidget(text: "Application Rates (Berger)"
                                "\nPrimer: 12–14 m²/L | Putty: 5–7 m²/kg | SPD: 13–15 m²/L | Emulsion: 14–16 m²/L | Weather Coat: 12–13 m²/L"),
                            SizedBox(height: 2.h),

                          ],
                        );
                      }),
                    ],
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
