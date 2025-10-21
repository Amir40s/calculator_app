import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/formula_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/earth_work/soil_compaction_controller.dart';

class SoilCompactionScreen extends StatelessWidget {
  final String itemName;
  SoilCompactionScreen({super.key, required this.itemName});

  final controller = Get.put(SoilCompactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: "Soil Compaction Calculator",
              styleType: StyleType.heading,
            ),
            SizedBox(height: 2.h),

            // 🔹 Input Fields
             Column(
                children: [
                  Obx(() {
                      return AppTextField(
                        hintText: 'Enter length',
                        heading: "Length (${controller.selectedUnit.value})",
                        controller: controller.lengthController,
                      );
                    }
                  ),
                  SizedBox(height: 1.5.h),
        Obx(() {
          return TwoFieldsWidget(
                    heading1: "Width (${controller.selectedUnit.value})",
                    heading2: "Depth (${controller.selectedUnit.value})",
                    controller1: controller.widthController,
                    controller2: controller.depthController,
                  ); }
        ),
                ],
              ),

            SizedBox(height: 3.h),

            // 🔹 Material Type Dropdown
             ReactiveDropdown(
              heading: "Material Type",
              selectedValue: controller.selectedMaterial,
              itemsList: controller.materialCompactionRanges.keys.toList(),
              hintText: "Select Material",
              onChangedCallback: (val) {
                controller.selectedMaterial.value = val;
                controller.updateCompactionOptions(val);
                controller.selectedCompaction.value = '';
              }
              ),
            SizedBox(height: 2.h),

            // 🔹 Compaction Factor Dropdown
             ReactiveDropdown(
              heading: "Compaction Factor",
              selectedValue: controller.selectedCompaction,
              itemsList: controller.compactionOptions.toList(),
              hintText: "Select Compaction Factor",
              onChangedCallback: (val) {
                controller.selectedCompaction.value = val;
              },
            ),
            SizedBox(height: 2.h),

            // 🔹 Unit Dropdown
            ReactiveDropdown(
              heading: "Unit of Measurement",
              selectedValue: controller.selectedUnit,
              itemsList: ['ft', 'm'],
              hintText: "Select Unit",
              onChangedCallback: (val) {
                controller.selectedUnit.value = val;
              },
            ),

            SizedBox(height: 3.h),

            // 🔹 Calculate Button
            AppButtonWidget(
              text: 'Calculate',
              width: 100.w,
              height: 6.h,
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.calculate();
              },
            ),

            SizedBox(height: 1.h),
      Obx(() {
        final dataAvailable =  controller.compactedVolume.value.toStringAsFixed(0) != '0.0';

        return AppButtonWidget(
                  text: 'Download PDF',
                  width: 100.w,
                  height: 6.h,
                  buttonColor: dataAvailable
                      ? AppColors.blueColor
                      : AppColors.greyColor.withOpacity(0.5),
                  onPressed: () async {

                    if(controller.compactedVolume.value == 0 &&
                        controller.looseVolume.value == 0) {
                      Get.snackbar(
                        "Error",
                        "Please calculate first before downloading PDF.",
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                  final  headers= ["Description", "Value"];
                   final  rows= [
                    [
                    "Compacted Volume",
                    "${controller.compactedVolume.value.toStringAsFixed(0)} ${controller.resultUnit.value}"
                    ],
                    [
                    "Loose Volume Required",
                    "${controller.looseVolume.value.toStringAsFixed(0)} ${controller.resultUnit.value}"
                    ],
                    ];
                    await PdfHelper.generateAndOpenPdf(
                      context: context,
                      title: itemName,
                      inputData: {
                        'Input':
                        "L = ${controller.lengthController.text.isNotEmpty ? controller.lengthController.text : '0'} ft, "
                            "W = ${controller.widthController.text.isNotEmpty ? controller.widthController.text : '0'} ft, "
                            "D = ${controller.depthController.text.isNotEmpty ? controller.depthController.text : '0'} ft, ",
                        'Material': "${controller.selectedMaterial.isNotEmpty
                            ? controller.selectedMaterial
                            : 'N/A'}",
                        "Unit":
                        "${controller.selectedUnit.isNotEmpty ? controller.selectedUnit : 'N/A'} ",},

                      headers: headers,
                      rows: rows,
                      fileName: '${itemName}_Report.pdf',
                    );
                  },

                );
              }
            ),
            SizedBox(height: 4.h),

            // 🔹 Results Section
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: Loader());
              }

              if (controller.compactedVolume.value == 0 &&
                  controller.looseVolume.value == 0) {
                return const SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: "Results:",
                    styleType: StyleType.heading,
                  ),
                  SizedBox(height: 1.h),
                  DynamicTable(
                    headers: ["Description", "Value"],
                    rows: [
                      [
                        "Compacted Volume",
                        "${controller.compactedVolume.value.toStringAsFixed(0)} ${controller.resultUnit.value}"
                      ],
                      [
                        "Loose Volume Required",
                        "${controller.looseVolume.value.toStringAsFixed(0)} ${controller.resultUnit.value}"
                      ],
                    ],
                  ),
                ],
              );
            }),

            SizedBox(height: 3.h),

            // 🔹 Formula Section
            FormulaWidget(text:
            "Formula:\n• Compacted Volume = L × W × D\n• Loose Volume = Compacted Volume × Compaction Factor",),
          ],
        ),
      ),
    );
  }
}
