import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/slab_concrete_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class SlabConcreteScreen extends StatelessWidget {
  final String itemName;
  SlabConcreteScreen({super.key, required this.itemName});

  final controller = Get.put(SlabConcreteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: "Concrete Input", styleType: StyleType.heading),
              SizedBox(height: 1.h),

              // 🔁 Loop through slabs
              for (int i = 0; i < controller.slabs.length; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: "Slab ${i + 1}",
                      styleType: StyleType.subHeading,
                    ),
                    if (controller.slabs.length > 1)
                      AppButtonWidget(
                        text: "Delete",
                        buttonColor: Colors.red,
                        radius: 2.w,
                        width: 20.w,
                        height: 3.h,
                        onPressed: () => controller.deleteSlab(i),
                      ),
                  ],
                ),
                TwoFieldsWidget(
                  heading1: "Grid",
                  heading2: "Slab Tag",
                  controller1: controller.slabs[i]['grid']!,
                  controller2: controller.slabs[i]['tag']!,
                ),
                TwoFieldsWidget(
                  heading1: "Length (ft'in\")",
                  heading2: "Width (ft'in\")",
                  hint: "e.g., 4'6\"",
                  hint2: "e.g., 4'6\"",
                  keyboardType: TextInputType.numberWithOptions(),
                  keyboardType2: TextInputType.numberWithOptions(),
                  controller1: controller.slabs[i]['length']!,
                  controller2: controller.slabs[i]['width']!,
                ),
                AppTextField(
                  hintText: "e.g., 8'0\"",
                  heading: "Thickness (ft'in\")",
                  controller: controller.slabs[i]['thickness'],
                ),
                AppTextWidget(
                  text: "Concrete Ratio (cement:sand:crush)",
                  styleType: StyleType.subHeading,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        hintText: "0",
                        heading: "Cement",
                        controller: controller.slabs[i]['cement'],
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: AppTextField(
                        hintText: "0",
                        heading: "Sand",
                        controller: controller.slabs[i]['sand'],
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: AppTextField(
                        hintText: "0",
                        heading: "Crush",
                        controller: controller.slabs[i]['crush'],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
              SizedBox(height: 2.h),

              AppButtonWidget(
                text: "+ Add Slab",
                width: 100.w,
                height: 5.h,
                onPressed: controller.addNewSlab,
              ),
              SizedBox(height: 1.h),

              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.calculate,
              ), SizedBox(height: 1.h),

              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final res = controller.slabResult.value;

                  if (res == null || res.results == null) {
                    Get.snackbar("Error", "Please calculate first before downloading PDF.");
                    return;
                  }

                  final slabs = res.results!.slabVolumes ?? [];

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {
                      'Total Volume': "${res.results?.totalFt3?.toStringAsFixed(2) ?? '0'} ft³",
                      'Total Formwork': "${res.results?.totalFormwork?.toStringAsFixed(2) ?? '0'} ft²",
                      'Cement (bags)': "${res.results?.cementBags?.toStringAsFixed(2) ?? '0'}",
                      'Crush (ft³)': "${res.results?.crushVolume?.toStringAsFixed(2) ?? '0'}",
                      'Water (liters)': "${res.results?.waterLiters?.toStringAsFixed(2) ?? '0'}",
                    },
                    tables: [
                      for (int i = 0; i < slabs.length; i++)
                        {
                          'title': "Slab ${i + 1}",
                          'headers': ['Item', 'Value'],
                          'rows': [
                            ['Grid', slabs[i].grid ?? 'N/A'],
                            ['Slab Tag', slabs[i].tag ?? 'N/A'],
                            ['Wet Volume (ft³)', slabs[i].volume?.toStringAsFixed(2) ?? '0.00'],
                            ['Formwork (ft²)', slabs[i].formwork?.toStringAsFixed(2) ?? '0.00'],
                            ['Dry Volume (ft³)', slabs[i].slabDryVolume?.toStringAsFixed(2) ?? '0.00'],
                            ['Cement Bags', slabs[i].slabCementBags?.toStringAsFixed(2) ?? '0.00'],
                            ['Sand Volume (ft³)', slabs[i].slabSandVolume?.toStringAsFixed(2) ?? '0.00'],
                            ['Crush Volume (ft³)', slabs[i].slabCrushVolume?.toStringAsFixed(2) ?? '0.00'],
                          ],
                        },

                      // ✅ Summary table
                      {
                        'title': 'Summary',
                        'headers': ['Item', 'Value'],
                        'rows': [
                          ['Total Volume (ft³)', res.results?.totalFt3?.toStringAsFixed(0) ?? '0.00'],
                          ['Total Formwork (ft²)', res.results?.totalFormwork?.toStringAsFixed(0) ?? '0.00'],
                          ['Cement (bags)', res.results?.cementBags?.toStringAsFixed(0) ?? '0.00'],
                          ['Crush (ft³)', res.results?.crushVolume?.toStringAsFixed(0) ?? '0.00'],
                          ['Water (liters)', res.results?.waterLiters?.toStringAsFixed(0) ?? '0.00'],
                        ],
                      },
                    ],
                    fileName: '${itemName}_report.pdf',
                  );
                },
              ),

              SizedBox(height: 2.h),

              // 🧮 Results Section
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }

                final res = controller.slabResult.value;
                if (res == null) {
                  return AppTextWidget(
                    color: AppColors.greyColor,
                    text:
                    "No results yet. Enter slab details (e.g., 4'6\" 8'0\", 0'6\") and click Calculate",
                  );
                }

                final slabs = res.results?.slabVolumes ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: "Concrete Results",
                      styleType: StyleType.heading,
                    ),
                    SizedBox(height: 1.h),

                    for (int i = 0; i < slabs.length; i++) ...[
                      AppTextWidget(
                        text: "Slab ${i + 1}",
                        styleType: StyleType.heading,
                      ),
                      SizedBox(height: 1.h),
                      DynamicTable(
                        headers: ['Item', 'Value'],
                        rows: [
                          ['Grid', slabs[i].grid ?? 'N/A'],
                          ['Slab Tag', slabs[i].tag ?? 'N/A'],
                          ['Wet Volume (ft³)',
                            slabs[i].volume?.toStringAsFixed(2) ?? '0.00'],
                          ['Formwork (ft²)',
                            slabs[i].formwork?.toStringAsFixed(2) ?? '0.00'],
                          ['Dry Volume (ft³)',
                            slabs[i].slabDryVolume?.toStringAsFixed(2) ?? '0.00'],
                          ['Cement Bags',
                            slabs[i].slabCementBags?.toStringAsFixed(2) ?? '0.00'],
                          ['Sand Volume (ft³)',
                            slabs[i].slabSandVolume?.toStringAsFixed(2) ?? '0.00'],
                          ['Crush Volume (ft³)',
                            slabs[i].slabCrushVolume?.toStringAsFixed(2) ?? '0.00'],
                        ],
                      ),
                      SizedBox(height: 2.h),
                      AppTextWidget(
                        text: "Summary",
                        styleType: StyleType.heading,
                      ),
                      SizedBox(height: 1.h),
                      DynamicTable(headers: ['Item', 'Value'],
                          rows: [
                            ['Total Volume (ft³)',res.results?.totalFt3?.toStringAsFixed(0) ?? '0.00'],
                            ['Total formwork (ft²)',res.results?.totalFormwork?.toStringAsFixed(0) ?? '0.00'],
                            ['Cement (bags)',res.results?.cementBags?.toStringAsFixed(0) ?? '0.00'],
                            ['Crush (ft³)',res.results?.crushVolume?.toStringAsFixed(0) ?? '0.00'],
                            ['Water (liters)	',res.results?.waterLiters?.toStringAsFixed(0) ?? '0.00'],
                          ]),
                      SizedBox(height: 2.h),

                    ],
                  ],
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
