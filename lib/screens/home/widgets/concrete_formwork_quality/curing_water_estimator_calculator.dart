import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/component/textFieldWithDropdown.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/curing_water_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class CuringWaterEstimatorCalculatorScreen extends StatelessWidget {
  final String itemName;
  CuringWaterEstimatorCalculatorScreen({super.key, required this.itemName});

  final controller = Get.put(CuringWaterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              AppTextWidget(
                text: "Input Parameters",
                styleType: StyleType.heading,
              ),
              SizedBox(height: 2.h),
              
              // Surface Area with Unit Dropdown
              TextFieldWithDropdown(
                controller: controller.surfaceAreaController,
                selectedValue: controller.selectedSurfaceAreaUnit,
                itemsList: controller.surfaceAreaUnits,
                heading: "Surface Area",
                hint2: "Select Unit",
                onChangedCallback: (value) {
                  controller.selectedSurfaceAreaUnit.value = value;
                },
              ),
              SizedBox(height: 2.h),

              // Curing Duration
              AppTextField(
                heading: "Curing Duration (days)",
                hintText: "0",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: controller.curingDurationController,
              ),
              SizedBox(height: 2.h),

              TextFieldWithDropdown(
                controller: controller.waterApplicationRateController,
                selectedValue: controller.selectedWaterRateUnit,
                itemsList: controller.waterRateUnits,
                heading: "Water Application Rate",
                hint2: "Select Unit",
                onChangedCallback: (value) {
                  controller.selectedWaterRateUnit.value = value;
                },
              ),
              SizedBox(height: 2.h),

              // Calculate Button
              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.calculate,
              ),
              SizedBox(height: 1.h),

              // Download PDF Button
              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                buttonColor: AppColors.blueColor,
                onPressed: () async {
                  final res = controller.result.value;

                  if (res == null) {
                    Get.snackbar("Error", "Please calculate results first.");
                    return;
                  }

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {
                      'Surface Area': '${controller.inputSurfaceArea.value} ${controller.selectedSurfaceAreaUnit.value}',
                      'Curing Duration': '${controller.inputCuringDuration.value} days',
                      'Water Application Rate': '${controller.inputWaterRate.value} ${controller.selectedWaterRateUnit.value}',
                    },
                    tables: [
                      {
                        'title': 'Calculation Results',
                        'headers': ['Item', 'Value'],
                        'rows': [
                          ['Surface Area', '${controller.inputSurfaceArea.value} ${controller.selectedSurfaceAreaUnit.value}'],
                          ['Curing Duration', '${controller.inputCuringDuration.value} days'],
                          ['Water Application Rate', '${controller.inputWaterRate.value} ${controller.selectedWaterRateUnit.value}'],
                          ['Daily Water (liters)', res.dailyliters.toStringAsFixed(2)],
                          ['Daily Water (gallons)', res.dailyGallons.toStringAsFixed(2)],
                          ['Total Water (liters)', res.totalliters.toStringAsFixed(0)],
                          ['Total Water (gallons)', res.totalGallons.toStringAsFixed(0)],
                        ],
                      },
                    ],
                  );
                },
              ),
              SizedBox(height: 2.h),

              // Results Section
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }

                final res = controller.result.value;

                if (res == null) {
                  return AppTextWidget(
                    color: AppColors.greyColor,
                    text: "No results yet. Enter parameters and click Calculate.",
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: "Calculation Results",
                      styleType: StyleType.heading,
                    ),
                    SizedBox(height: 2.h),
                    DynamicTable(
                      headers: ['Item', 'Value'],
                      rows: [
                        [
                          'Surface Area',
                          '${controller.inputSurfaceArea.value} ${controller.selectedSurfaceAreaUnit.value}'
                        ],
                        [
                          'Curing Duration',
                          '${controller.inputCuringDuration.value} days'
                        ],
                        [
                          'Water Application Rate',
                          '${controller.inputWaterRate.value} ${controller.selectedWaterRateUnit.value}'
                        ],
                        [
                          'Daily Water (liters)',
                          res.dailyliters.toStringAsFixed(2)
                        ],
                        [
                          'Daily Water (gallons)',
                          res.dailyGallons.toStringAsFixed(2)
                        ],
                        [
                          'Total Water (liters)',
                          res.totalliters.toStringAsFixed(0)
                        ],
                        [
                          'Total Water (gallons)',
                          res.totalGallons.toStringAsFixed(0)
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                );
              }),
            ],
          ),
      ),
    );
  }
}
