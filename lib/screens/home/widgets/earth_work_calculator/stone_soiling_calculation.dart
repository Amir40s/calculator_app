import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/formula_widget.dart';
import '../../../../core/controller/calculators/earth_work/stone_soiling_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class StoneSoilingCalculatorScreen extends StatelessWidget {
  final String itemName;
  StoneSoilingCalculatorScreen({super.key, required this.itemName});

  final controller = Get.put(StoneSoilingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: "Add Area", styleType: StyleType.heading),
              SizedBox(height: 2.h),

              ...List.generate(controller.areas.length, (index) {
                final area = controller.areas[index];
                return Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text: "Area ${index + 1}",
                        ),
                        if (controller.areas.length > 1)
                          AppButtonWidget(
                            text: "Delete",
                            width: 30.w,
                            height: 3.h,
                            buttonColor: Colors.red,
                            onPressed: () => controller.removeArea(index),
                          ),
                      ],
                    ),
                    AppTextField(
                      heading: "Area Name",
                      hintText: "Enter area name",
                      controller: area['name']!,
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            hintText: "0",
                            heading: "Length (ft)",
                            keyboardType: TextInputType.number,
                            controller: area['length']!,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: AppTextField(
                            hintText: "0",
                            heading: "Width (ft)",
                            keyboardType: TextInputType.number,
                            controller: area['width']!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                    AppTextField(
                      hintText: "0",
                      heading: "Thickness (in)",
                      keyboardType: TextInputType.number,
                      controller: area['thickness']!,
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 2.h,
              ),
              // Add Area Button
              AppButtonWidget(
                text: '+ Add Area',
                width: 100.w,
                height: 6.h,
                onPressed: controller.addArea,
              ),
              SizedBox(height: 2.h),

              // Calculate Button
              AppButtonWidget(
                text: 'Calculate',
                width: 100.w,
                height: 6.h,
                onPressed: controller.calculate,
              ),
              SizedBox(height: 1.h),
              // Download PDF Button
              Obx(() {
                final dataAvailable = controller.result.value != null;

                return AppButtonWidget(
                    text: 'Download PDF',
                    width: 100.w,
                    height: 6.h,
                    buttonColor: dataAvailable
                        ? AppColors.blueColor
                        : AppColors.greyColor.withOpacity(0.5),
                    onPressed: () async {
                      final data = controller.result.value;

                      if (data == null) {
                        Get.snackbar("Error",
                            "Please calculate first before downloading PDF.");
                        return;
                      }

                      final result = data.results;
                      final areaRows = controller.areas.map((area) {
                        final name = area['name']!.text.isNotEmpty
                            ? area['name']!.text
                            : 'Unnamed';
                        final length =
                            double.tryParse(area['length']!.text) ?? 0.0;
                        final width = double.tryParse(area['width']!.text) ?? 0.0;
                        final thickness =
                            double.tryParse(area['thickness']!.text) ?? 0.0;

                        final volume = length * width * (thickness / 12);
                        return [
                          name,
                          length.toStringAsFixed(2),
                          width.toStringAsFixed(2),
                          thickness.toStringAsFixed(2),
                          volume.toStringAsFixed(2),
                        ];
                      }).toList();
                      await PdfHelper.generateAndOpenPdf(
                        context: context,
                        title: itemName,
                        inputData: {
                          'Areas': "${controller.areas.length}",
                        },

                        fileName: 'Stone_soiling.pdf',
                        tables: [
                          {
                            'title': 'Area Details',
                            'headers': ['Name', 'Length (ft)', 'Width (ft)', 'Thickness (in)', 'Volume (ft³)'],
                            'rows': areaRows,
                          }, {
                            'title': 'Results',
                            'headers': ['Description', 'Value'],
                            'rows': [
                              ['Total Volume (ft³) ', result.totalFt3.toStringAsFixed(0)],
                              ['`Total Volume (m³)`', result.totalM3.toStringAsFixed(0)],
                              ['`Estimated Weight (tons)`',  "${AppUtils().toRoundedDouble(result.minTons).toStringAsFixed(0)} - "
                                  "${AppUtils().toRoundedDouble(result.maxTons).toStringAsFixed(0)}",
                              ],
                            ],
                          },
                        ]
                      );

                    });
              }),

              SizedBox(height: 3.h),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }

                final result = controller.result.value;

                if (result == null) {
                  return const Center(
                    child: Text('No results yet. Enter values and calculate'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    AppTextWidget(
                      text: "Results",
                      styleType: StyleType.heading,
                    ),
                    SizedBox(height: 1.h),

                    // 🔹 Table showing total volume & weight
                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        [
                          "Total Volume (ft³)",
                          AppUtils()
                              .toRoundedDouble(result.results.totalFt3)
                              .toStringAsFixed(0),
                        ],
                        [
                          "Estimated Weight (tons)",
                          "${AppUtils().toRoundedDouble(result.results.minTons).toStringAsFixed(0)} - "
                              "${AppUtils().toRoundedDouble(result.results.maxTons).toStringAsFixed(0)}",
                        ],
                      ],
                    ),
                  ],
                );
              }),

              SizedBox(height: 3.h),

              FormulaWidget(
                text:
                    "Formula:\n• Volume = L × W × (Thickness / 12)\n• 1 ft³ = 0.0283168 m³",
              ),
            ],
          ),
        );
      }),
    );
  }
}
