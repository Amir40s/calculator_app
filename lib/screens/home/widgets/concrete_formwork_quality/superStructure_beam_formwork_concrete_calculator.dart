import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/enum/style_type.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dropdown_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/SuperstructureBeamFormworkConcreteController.dart';
import '../../../../core/controller/loader_controller.dart';

class SuperstructureBeamFormworkConcreteCalculator extends StatelessWidget {
  final String itemName;
  SuperstructureBeamFormworkConcreteCalculator(
      {super.key, required this.itemName});

  final controller = Get.put(SuperstructureBeamFormworkConcreteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Obx(() {
          return Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                  text: "Concrete Inputs", styleType: StyleType.heading),
              SizedBox(height: 1.h),
              for (int i = 0; i < controller.foundations.length; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: "Beam ${i + 1}",
                      styleType: StyleType.dialogHeading,
                    ),
                    if (controller.foundations.length > 1)
                      AppButtonWidget(
                        text: "Delete",
                        buttonColor: Colors.red,
                        radius: 2.w,
                        width: 20.w,
                        height: 3.h,
                        onPressed: () => controller.deleteColumn(i),
                      ),
                  ],
                ),
                TwoFieldsWidget(
                  heading1: "Grid",
                  heading2: "Width (ft'in\")",
                  hint: "e.g., A-1",
                  hint2: "e.g., 8'0\"",
                  controller1: controller.foundations[i]['grid']!,
                  controller2: controller.foundations[i]['width']!,
                ),
                TwoFieldsWidget(
                  heading1: "Height (ft'in\")",
                  heading2: "Length (ft'in\")",
                  hint: "e.g., 4'6\"",
                  hint2: "e.g., 8'0\"",
                  controller1: controller.foundations[i]['height']!,
                  controller2: controller.foundations[i]['length']!,
                ),
                AppTextField(
                  heading: "SuperStructure Tag",
                  hintText: "e.g., PB1",
                  controller: controller.foundations[i]['superStrucTag']!,
                ),
                AppTextWidget(
                  text: "Concrete Ratio (cement:sand:crush)",
                  styleType: StyleType.subHeading,
                ),
                Row(
                  children: [
                    Expanded(child: AppTextField(hintText: "0",                  keyboardType: TextInputType.numberWithOptions(),
                        controller: controller.foundations[i]['cement']!)),
                    SizedBox(width: 1.w),
                    Expanded(child: AppTextField(hintText: "0",                   keyboardType: TextInputType.numberWithOptions(),
                        controller: controller.foundations[i]['sand']!)),
                    SizedBox(width: 1.w),
                    Expanded(child: AppTextField(hintText: "0",                  keyboardType: TextInputType.numberWithOptions(),
                        controller: controller.foundations[i]['crush']!)),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
              AppButtonWidget(
                text: "+ Add Beam",
                width: 100.w,
                height: 5.h,
                onPressed: controller.addNewColumn,
              ),
              SizedBox(height: 1.h),
              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.calculate,
              ),
              SizedBox(height: 1.h),
              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final res = controller.superStructureBeamResult.value;
                  if (res == null) {
                    Get.snackbar("Error","Please calculate results first.");
                    return;
                  }

                  final beams = res.beams ?? [];

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {
                      'Total Volume (ft³)': res.totalVolume.toStringAsFixed(2) ?? '0',
                      'Total Formwork (ft²)': res.totalFormwork.toStringAsFixed(2) ?? '0',
                    },
                    tables: [
                      for (int i = 0; i < beams.length; i++)
                        {
                          'title': "Beam ${i + 1}",
                          'headers': ['Item', 'Value'],
                          'rows': [
                            ['Grid', beams[i].grid ?? 'N/A'],
                            ['SuperStructure Tag', beams[i].tag ?? 'N/A'],
                            ['Volume (ft³)', beams[i].volFt3.toStringAsFixed(2) ?? '0.00'],
                            ['Cement Bags', beams[i].cementBags.toStringAsFixed(2) ?? '0.00'],
                            ['Sand Volume (ft³)', beams[i].sandVolume.toStringAsFixed(2) ?? '0.00'],
                            ['Crush Volume (ft³)', beams[i].crushVolume.toStringAsFixed(2) ?? '0.00'],
                            ['Water (L)', beams[i].waterLiter.toStringAsFixed(2) ?? '0.00'],
                          ],
                        },

                      {
                        'title': 'Summary',
                        'headers': ['Material', 'Quantity'],
                        'rows': [
                          ['Cement (bags)', res.cementBags.toStringAsFixed(0) ?? '0.00'],
                          ['Sand (ft³)', res.sandVolume.toStringAsFixed(0) ?? '0.00'],
                          ['Crush (ft³)', res.crushVolume.toStringAsFixed(0) ?? '0.00'],
                          ['Water (liters)', res.waterLiter.toStringAsFixed(0) ?? '0.00'],
                        ],
                      },
                    ],
                    fileName: '${itemName}_report.pdf',
                  );
                },

              ),
              SizedBox(height: 2.h),

              if (controller.isLoading.value)
                const Center(child: Loader())
              else
                _buildResults(controller),
            ],
          );
        }),
      ),
    );
  }
  Widget _buildResults(SuperstructureBeamFormworkConcreteController controller) {
    final res = controller.superStructureBeamResult.value;
    if (res == null) {
      return AppTextWidget(
        color: AppColors.greyColor,
        text: "No results yet. Enter beam details and click Calculate.",
      );
    }

    final beams = res.beams ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(text: "Concrete Results", styleType: StyleType.heading),
        SizedBox(height: 1.h),
        for (int i = 0; i < beams.length; i++) ...[
          AppTextWidget(text: "Beam ${i + 1}", styleType: StyleType.subHeading),
          SizedBox(height: 1.h),
          DynamicTable(
            headers: ['Item', 'Value'],
            rows: [
              ['Grid', beams[i]?.grid ?? 'N/A'],
              ['PB Tag', beams[i]?.tag ?? 'N/A'],
              ['Formwork (ft²)', beams[i].formworkFt2?.toStringAsFixed(2) ?? '0.00'],
              ['Volume (ft³)', beams[i].volFt3?.toStringAsFixed(2) ?? '0.00'],
              ['Cement Bags', beams[i].cementBags?.toStringAsFixed(2) ?? '0.00'],
              ['Sand Volume (ft³)', beams[i].sandVolume?.toStringAsFixed(2) ?? '0.00'],
              ['Crush Volume (ft³)', beams[i].crushVolume?.toStringAsFixed(2) ?? '0.00'],
              ['Water (L)', beams[i].waterLiter?.toStringAsFixed(2) ?? '0.00'],
            ],
          ),
          SizedBox(height: 2.h),
        ],
        AppTextWidget(text: "Summary", styleType: StyleType.subHeading),
        SizedBox(height: 1.h),
        DynamicTable(
          headers: ['Material', 'Quantity'],
          rows: [
            ['Cement (bags)', res.cementBags?.toStringAsFixed(0) ?? '0.00'],
            ['Sand (ft³)', res.sandVolume?.toStringAsFixed(0) ?? '0.00'],
            ['Crush (ft³)', res.crushVolume?.toStringAsFixed(0) ?? '0.00'],
            ['Water (liters)', res.waterLiter?.toStringAsFixed(0) ?? '0.00'],
          ],
        ),
        SizedBox(height: 2.h,),
      ],
    );
  }

}
