import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/model/earth_cost/excavation_model.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/formula_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/earth_work/excavation_calculator_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';

import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/component/pdf/pdf_generator.dart';
import '../../../../core/component/pdf/pdf_screen.dart';

class ExcavationCalculatorScreen extends StatelessWidget {
  final String itemName;
   ExcavationCalculatorScreen({super.key, required this.itemName});

   final controller = Get.put(ExcavationCalculatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: "Excavation Calculator",styleType: StyleType.heading,),
              AppTextField(hintText: "0",heading: "Length L (ft)",controller: controller.lengthController,),
              TwoFieldsWidget(heading1: "Width W (ft)",
                  heading2: "Depth D (ft)",
                  controller1: controller.widthController ,
                  controller2: controller.depthController),
              AppTextWidget(text: "Show Cubic Yards",styleType: StyleType.subHeading,),
              ReusableDropdown(selectedValue: controller.selectedQuality,
                  itemsList: controller.availableQuality,
                  hintText: "Show Cubic Yards",
                  onChangedCallback: controller.onUnitChanged),
              AppTextWidget(text: "Show Cubic Yards",styleType: StyleType.subHeading,),
          Obx(() => CheckboxListTile(
            
            title:  AppTextWidget(text: "Use Extensions"),
            value: controller.isChecked.value,
            onChanged: controller.toggleCheckbox,
            activeColor: AppColors.blueColor,
            controlAffinity: ListTileControlAffinity.leading,
          )),
              AppTextWidget(text: "Effective length = L + 2×l · Effective width = W + 2×w",styleType: StyleType.subTitle,),
          
              AppTextField(hintText: "0",heading: "Length Extension l (ft per side)",controller: controller.lengthExtensionController,),
              AppTextField(hintText: "0",heading: "Width Extension w (ft per side)",controller: controller.widthExtensionController,),
              SizedBox(height: 2.h,),
              AppButtonWidget(text: "Calculate",width: 100.w,height: 5.h,onPressed: () {
                controller.convert();
              },),
              Obx(() {
                final dataAvailable = controller.finishingCostData.value != null;

                return AppButtonWidget(
                    text: "Download PDF",
                    width: 100.w,
                    height: 5.h,
                    buttonColor: dataAvailable ? AppColors.blueColor : AppColors.greyColor.withOpacity(0.5),
                    onPressed: () async {

                      final data = controller.finishingCostData.value;

                      if (data == null) {
                        Get.snackbar("Error", "Please calculate first before downloading PDF.");
                        return;
                      }

                      final result = data.results;

                      final headers = [
                        'Case',
                        'Effective L × W (ft)',
                        'Volume (ft³)',
                        if (result.showYards) 'Volume (yd³)',
                      ];

                      final rows = [
                        [
                          "Original",
                          "${result.l.toStringAsFixed(0)} × ${result.w.toStringAsFixed(0)}",
                          result.vorig.toStringAsFixed(2),
                          if (result.showYards) result.vorigYd.toStringAsFixed(2),
                        ],
                        [
                          "Extended",
                          "${result.effLx.toStringAsFixed(0)} × ${result.effWx.toStringAsFixed(0)}",
                          result.vext.toStringAsFixed(0),
                          if (result.showYards) result.vext.toStringAsFixed(0),
                        ],
                        if (controller.isChecked.value)
                          [
                            "Difference",
                            "-",
                            result.vdiff.toStringAsFixed(0),
                            if (result.showYards) result.vdiffYd.toStringAsFixed(2),
                          ],
                      ];

                      await PdfHelper.generateAndOpenPdf(
                        context: context,
                        title: itemName,
                        inputData: {
                          'Input': "L = ${controller.lengthController.text.isNotEmpty ? controller.lengthController.text : '0'} ft , "
                              "W = ${controller.widthController.text.isNotEmpty ? controller.widthController.text : '0'} ft , "
                              "D = ${controller.depthController.text.isNotEmpty ? controller.depthController.text : '0'} ft",
                          'Extensions': 'l= ${controller.lengthExtensionController.text.isNotEmpty ?
                          controller.lengthExtensionController.text : '0'} ft/side, '
                              'w= ${controller.widthExtensionController.text.isNotEmpty ?
                          controller.widthExtensionController.text : '0'} ft/side'
                        },
                        headers: headers,
                        rows: rows,
                        fileName: 'Excavation_Report.pdf',
                      );
                    },
                  );
                }
              ),

              SizedBox(height: 4.h,),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }

                final data = controller.finishingCostData.value;

                if (data == null) {
                  return const Center(
                    child: Text('No results yet. Enter values and calculate.'),
                  );
                }
                final result = data.results;

                log("show yard is:: ${result.showYards}");
                // Build headers dynamically
                final headers = [
                  'Case',
                  'Effective L × W (ft)',
                  'Volume (ft³)',
                  if (result.showYards) 'Volume (yd³)',
                ];

                // Build rows dynamically
                final rows = [
                  [
                    "Original",
                    "${result.l.toStringAsFixed(0)} × ${result.w.toStringAsFixed(0)}",
                    result.vorig.toStringAsFixed(2),
                    if (result.showYards) (result.vorigYd.toStringAsFixed(2)),
                  ],
                  [
                    "Extended",
                    "${result.effLx.toStringAsFixed(0)} × ${result.effWx.toStringAsFixed(0)}",
                    result.vext.toStringAsFixed(0),
                    if (result.showYards) (result.vext.toStringAsFixed(0)),
                  ],
                  if (controller.isChecked.value)
                    [
                      "Difference",
                      "-",
                      result.vdiff.toStringAsFixed(0),
                      if (result.showYards) result.vdiffYd.toStringAsFixed(2),
                    ],
                ];

                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Column(
                    spacing: 1.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      AppTextWidget(
                        text: "Excavation Results:",
                        styleType: StyleType.heading,
                      ),
                      DynamicTable(
                        headers: headers,
                        rows: rows,
                      ),
                      FormulaWidget(
                        text: "Formulas: Vorig = L·W·D, Vext = (L+2l)·(W+2w)·D",
                      ),
                    ],
                  ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
