import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/buttons_row_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/textFieldWithDropdown.dart';
import 'package:smart_construction_calculator/core/controller/calculators/block_masonry/wall_roof_plaster_controller.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/loader_controller.dart';

class WallRoofPlasterScreen extends StatelessWidget {
  final String itemName;
  WallRoofPlasterScreen({super.key, required this.itemName});

  final controller = Get.put(WallRoofPlasterController());

  @override
  Widget build(BuildContext context) {
    final text = AppUtils().wallRoofPlaster;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              spacing: 1.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(text: 'Wall Inputs', styleType: StyleType.heading),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.w),
                  child: Image.asset(AppAssets.wallRoofPlaster),
                ),
                AppTextWidget(
                  text: text,
                  maxLine: controller.isExpanded.value ? null : 7,
                  overflow: controller.isExpanded.value
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  styleType: StyleType.subTitle,
                ),
                if (text.length > 100)
                  GestureDetector(
                    onTap: controller.toggleText,
                    child: AppTextWidget(
                      text: controller.isExpanded.value ? 'See Less' : 'See More',
                      textDecoration: TextDecoration.underline,
                      color: AppColors.blueColor,
                    ),
                  ),
                SizedBox(height: 2.h),

                // Walls Loop
                ...controller.walls.asMap().entries.map((entry) {
                  final wallIndex = entry.key;
                  final wall = entry.value;

                  return Container(
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.only(bottom: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.w),
                      border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      spacing: 1.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextWidget(
                                text: 'Wall ${wallIndex + 1}',
                                styleType: StyleType.dialogHeading),
                            AppButtonWidget(
                              text: "Delete",
                              height: 3.h,
                              alignment: Alignment.centerRight,
                              width: 25.w,
                              radius: 2.w,
                              buttonColor: Colors.red,
                              onPressed: () => controller.removeWall(wallIndex),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        TextFieldWithDropdown(
                          controller: wall.tag,
                          selectedValue:  wall.selectedType,
                          itemsList: controller.typeItems,
                          hint2: "A-1",
                          heading: "Level/Tag",
                          onChangedCallback: (value) {
                            controller.selectedType.value = value;
                          },
                        ),

                        // Wall Inputs
                        TwoFieldsWidget(
                          heading1: "Wall Height (ft)",
                          controller1: wall.wallHeight,
                          hint: "Wall-A",
                          hint2: "A-1",
                          controller2: wall.grid,
                          heading2: 'Grid Reference',
                        ),
                        TwoFieldsWidget(
                          heading1: 'Wall Thickness',
                          hint: "2",
                          hint2: "4",
                          keyboardType2: TextInputType.numberWithOptions(),
                          keyboardType: TextInputType.numberWithOptions(),
                          controller1: wall.wallThickness,
                          controller2: wall.wallLength,
                          heading2: 'Wall Length',
                        ),

                        // Windows Section
                        AppTextWidget(
                            text: 'Windows', styleType: StyleType.dialogHeading),
                        ...wall.windows.asMap().entries.map((win) {
                          final i = win.key;
                          final model = win.value;
                          return Column(
                            spacing: 1.h,
                            children: [
                              TwoFieldsWidget(
                                heading1: 'Window ${i + 1} Width (ft)',
                                controller1: model.width,
                                controller2: model.height,
                                heading2: 'Window ${i + 1} Height (ft)',
                              ),
                              AppButtonWidget(
                                text: "Delete",
                                height: 3.h,
                                width: 25.w,
                                radius: 2.w,
                                buttonColor: Colors.red,
                                alignment: Alignment.centerRight,
                                onPressed: () => controller.removeWindow(wallIndex, i),
                              ),
                            ],
                          );
                        }),
                        AppButtonWidget(
                          text: "Add Window",
                          height: 4.5.h,
                          width: 35.w,
                          radius: 2.w,
                          alignment: Alignment.centerLeft,
                          onPressed: () => controller.addWindow(wallIndex),
                        ),

                        // Doors Section
                        AppTextWidget(
                            text: 'Doors', styleType: StyleType.dialogHeading),
                        ...wall.doors.asMap().entries.map((door) {
                          final i = door.key;
                          final model = door.value;
                          return Column(
                            spacing: 1.h,
                            children: [
                              TwoFieldsWidget(
                                heading1: 'Door ${i + 1} Width (ft)',
                                controller1: model.width,
                                controller2: model.height,
                                heading2: 'Door ${i + 1} Height (ft)',
                              ),
                              AppButtonWidget(
                                text: "Delete",
                                height: 3.h,
                                width: 25.w,
                                radius: 2.w,
                                buttonColor: Colors.red,
                                alignment: Alignment.centerRight,
                                onPressed: () => controller.removeDoor(wallIndex, i),
                              ),
                            ],
                          );
                        }),
                        AppButtonWidget(
                          text: "Add Door",
                          height: 4.5.h,
                          width: 35.w,
                          radius: 2.w,
                          alignment: Alignment.centerLeft,
                          onPressed: () => controller.addDoor(wallIndex),
                        ),

                        // Block & Mortar Section
                        AppTextWidget(
                            text: 'Plaster Details',
                            styleType: StyleType.dialogHeading),
                        AppTextField(heading: 'Plaster Thickness (in)',hintText:"2",
                          controller: wall.plasterThickness,
                        ),

                        TwoFieldsWidget(
                            heading1: "Mortar Mix Ratio",
                            controller1: wall.mortarRatio,
                             hint2: "1:4",
                            controller2: wall.waterCementRatio,
                            heading2: "Water-Cement Ratio"),
                      ],
                    ),
                  );
                }),

                // Buttons
                ReusableButtonRow(
                  firstButtonText: "Add Wall",
                  secondButtonText: "Calculate",
                  firstButtonAction: controller.addWall,
                  secondButtonAction: controller.convert,
                ),

                AppButtonWidget(
                  text: "Download PDF",
                  height: 5.h,
                  width: 100.w,
                  onPressed: () async {
                    final res = controller.blackMasonry.value;

                    if (res == null) {
                      Get.snackbar("Error", "Please calculate results first.");
                      return;
                    }

                    final List<Map<String, dynamic>> pdfTables = [];

                    for (int i = 0; i < res.results.length; i++) {
                      final r = res.results[i];
                      pdfTables.add({
                        "title": "Wall ${i + 1} (${r.tag})",
                        "headers": ["Parameter", "Value"],
                        "rows": [
                          ["Type", r.type],
                          ["Tag", r.tag],
                          ["Grid", r.grid],
                          ["Wall Length (ft)", r.wallLength.toStringAsFixed(2)],
                          ["Wall Height (ft)", r.wallHeight.toStringAsFixed(2)],
                          ["Wall Area (ft²)", r.wallArea.toStringAsFixed(2)],
                          ["Window Area (ft²)", r.windowArea.toStringAsFixed(2)],
                          ["Window Jamb (ft²)", r.windowJambArea.toStringAsFixed(2)],
                          ["Door Deduction (ft²)", r.doorArea.toStringAsFixed(2)],
                          ["Net Area (ft²)", r.netWallArea.toStringAsFixed(2)],
                          ["Plaster (ft³)", r.plasterVolume.toStringAsFixed(3)],
                          ["Cement (bags)", r.cementBags.toStringAsFixed(3)],
                          ["Sand (ft³)", r.sandVol.toStringAsFixed(3)],
                          ["Water (L)", r.waterLiters.toStringAsFixed(2)],
                        ],
                      });
                    }

                    final totals = res.totals;
                    pdfTables.add({
                      "title": "Total Summary",
                      "headers": ["Parameter", "Value"],
                      "rows": [
                        ["Total Net Area (ft²)", totals.totalNetArea.toStringAsFixed(2)],
                        ["Total Plaster (ft³)", totals.totalPlaster.toStringAsFixed(3)],
                        ["Total Cement (bags)", totals.totalCementBags.toStringAsFixed(3)],
                        ["Total Sand (ft³)", totals.totalSand.toStringAsFixed(3)],
                        ["Total Water (L)", totals.totalWater.toStringAsFixed(2)],
                      ],
                    });

                    final inputData = {
                      "No. of Walls": controller.walls.length.toString(),
                      "Mix Ratio": controller.walls.first.mortarRatio.text,
                      "Water-Cement Ratio": controller.walls.first.waterCementRatio.text,
                    };

                    await PdfHelper.generateAndOpenPdf(
                      context: context,
                      title: itemName,
                      inputData: inputData,
                      tables: pdfTables,
                    );
                  },

                ),

                SizedBox(height: 2.h),

                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: Loader());
                  } else if (controller.blackMasonry.value == null) {
                    return Center(child: AppTextWidget(text: 'No data available'));
                  } else {
                    final result = controller.blackMasonry.value!;
                    final data = result.results;
                    final totals = result.totals;

                    return Column(
                      spacing: 1.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: "Calculation Results",
                          styleType: StyleType.dialogHeading,
                        ),
                        ...data.asMap().entries.map((entry) {
                          final index = entry.key;
                          final wall = entry.value;

                          return Column(
                            spacing: 1.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: "Wall ${index + 1} (${wall.tag})",
                                styleType: StyleType.dialogHeading,
                                color: AppColors.blueColor,
                              ),
                              DynamicTable(
                                headers: ["Name", "Value"],
                                rows: [
                                  ["Grid", wall.grid],
                                  ["Tag", wall.tag],
                                  ["Type", wall.type],
                                  ["Length (ft)", wall.wallLength.toStringAsFixed(2)],
                                  ["Height (ft)", wall.wallHeight.toStringAsFixed(2)],
                                  ["Wall Area (ft²)", wall.wallArea.toStringAsFixed(2)],
                                  ["Window Area (ft²)", wall.windowArea.toStringAsFixed(2)],
                                  ["Window Jamb (ft²)", wall.windowJambArea.toStringAsFixed(2)],
                                  ["Door Deduction (ft²)", wall.doorArea.toStringAsFixed(2)],
                                  ["Net Area (ft²)", wall.netWallArea.toStringAsFixed(2)],
                                  ["Plaster (ft³)", wall.plasterVolume.toStringAsFixed(3)],
                                  ["Cement (bags)", wall.cementBags.toStringAsFixed(3)],
                                  ["Sand (ft³)", wall.sandVol.toStringAsFixed(3)],
                                  ["Water (L)", wall.waterLiters.toStringAsFixed(2)],
                                ],
                              ),
                              SizedBox(height: 1.5.h),
                            ],
                          );
                        }),
                        SizedBox(height: 2.h),
                        AppTextWidget(
                          text: "Total Summary",
                          styleType: StyleType.dialogHeading,
                        ),
                        DynamicTable(
                          headers: ["Name", "Value"],
                          rows: [
                            ["Total Net Area (ft²)", totals.totalNetArea.toStringAsFixed(2)],
                            ["Total Plaster (ft³)", totals.totalPlaster.toStringAsFixed(3)],
                            ["Total Cement (bags)", totals.totalCementBags.toStringAsFixed(3)],
                            ["Total Sand (ft³)", totals.totalSand.toStringAsFixed(3)],
                            ["Total Water (L)", totals.totalWater.toStringAsFixed(2)],
                          ],
                        ),
                        SizedBox(height: 2.h),
                      ],
                    );
                  }
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
