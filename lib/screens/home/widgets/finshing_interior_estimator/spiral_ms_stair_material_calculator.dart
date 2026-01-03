import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/model/finishing_interior_estimate/spiral_stair_model.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/finishin_interior_estimator/spiral_stair_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class SpiralMsStairMaterialCalculator extends StatelessWidget {
  final String itemName;
   SpiralMsStairMaterialCalculator({super.key, required this.itemName});

  final controller = Get.put(SpiralStairController());

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
              text: "Inputs",
              styleType: StyleType.heading,
            ),
            SizedBox(height: 2.h),

            // Left Column - Right Column layout using TwoFieldsWidget
            TwoFieldsWidget(
              heading1: "Center Column Outer Radius R (ft'in\")",
              heading2: "Center Column Height H (ft'in\")",
              hint: "0'2\"",
              hint2: "23'0\"",
              keyboardType: TextInputType.text,
              keyboardType2: TextInputType.text,
              controller1: controller.centerColumnOuterRadiusController,
              controller2: controller.centerColumnHeightController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Column Thickness T (mm)",
              heading2: "Material Density D (Kg/m³)",
              hint: "4",
              hint2: "7840",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.numberWithOptions(decimal: true),
              controller1: controller.columnThicknessController,
              controller2: controller.materialDensityController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Riser Height h (ft'in\")",
              heading2: "Stair Outer Radius r (ft'in\")",
              hint: "0'7\"",
              hint2: "2'3\"",
              keyboardType: TextInputType.text,
              keyboardType2: TextInputType.text,
              controller1: controller.riserHeightController,
              controller2: controller.stairOuterRadiusController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Tread Angle Web width w (mm)",
              heading2: "Tread Angle Web length l (mm)",
              hint: "25",
              hint2: "25",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.numberWithOptions(decimal: true),
              controller1: controller.treadAngleWebWidthController,
              controller2: controller.treadAngleWebLengthController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Tread Angle thickness t (mm)",
              heading2: "Tread Base Plate thickness t' (mm)",
              hint: "4",
              hint2: "1.2",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.numberWithOptions(decimal: true),
              controller1: controller.treadAngleThicknessController,
              controller2: controller.treadBasePlateThicknessController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Landing Length L (ft'in\")",
              heading2: "Landing Width W (ft'in\")",
              hint: "3'0\"",
              hint2: "3'0\"",
              keyboardType: TextInputType.text,
              keyboardType2: TextInputType.text,
              controller1: controller.landingLengthController,
              controller2: controller.landingWidthController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Landing Plate thickness Lt (mm)",
              heading2: "Handrail Pipe Dia d (mm)",
              hint: "1.2",
              hint2: "40",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.numberWithOptions(decimal: true),
              controller1: controller.landingPlateThicknessController,
              controller2: controller.handrailPipeDiaController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Handrail Pipe Thickness th (mm)",
              heading2: "Baluster Spacing on Landing k (ft'in\")",
              hint: "1.2",
              hint2: "0'8\"",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.text,
              controller1: controller.handrailPipeThicknessController,
              controller2: controller.balusterSpacingOnLandingController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Baluster Height l' (ft'in\")",
              heading2: "Balusters per Stair Tread",
              hint: "3'2\"",
              hint2: "2",
              keyboardType: TextInputType.text,
              keyboardType2: TextInputType.numberWithOptions(decimal: false),
              controller1: controller.balusterHeightController,
              controller2: controller.balustersPerStairTreadController,
            ),
            SizedBox(height: 2.h),

            TwoFieldsWidget(
              heading1: "Landing Railing Sides (1-4)",
              heading2: "Currency Symbol",
              hint: "3",
              hint2: "PKR",
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              keyboardType2: TextInputType.text,
              controller1: controller.landingRailingSidesController,
              controller2: controller.currencySymbolController,
            ),
            SizedBox(height: 2.h),
            TwoFieldsWidget(
              heading1: "Center Column Price",
              heading2: "Tread Frame Angle Price",
              hint: "0",
              hint2: "0",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.numberWithOptions(decimal: true),
              controller1: controller.centerColumnPriceController,
              controller2: controller.treadFrameAnglePriceController,
            ),
            SizedBox(height: 2.h),
            TwoFieldsWidget(
              heading1: "Tread Base Plate Price",
              heading2: "Landing Base Plate Price",
              hint: "0",
              hint2: "0",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.numberWithOptions(decimal: true),
              controller1: controller.treadBasePlatePriceController,
              controller2: controller.landingBasePlatePriceController,
            ),
            SizedBox(height: 2.h),
            TwoFieldsWidget(
              heading1: "Landing Base Frame Price",
              heading2: "Handrail Pipe Price",
              hint: "0",
              hint2: "0",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType2: TextInputType.numberWithOptions(decimal: true),
              controller1: controller.landingBaseFramePriceController,
              controller2: controller.handrailPipePriceController,
            ),
            SizedBox(height: 2.h),
            AppTextField(
              hintText: "0",
              heading: "Baluster Pipes Price",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: controller.balusterPipesPriceController,
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
                    'Center Column Outer Radius R': controller.centerColumnOuterRadiusController.text,
                    'Column Thickness T': '${controller.columnThicknessController.text} mm',
                    'Riser Height h': controller.riserHeightController.text,
                    'Tread Angle Web width w': '${controller.treadAngleWebWidthController.text} mm',
                    'Tread Angle thickness t': '${controller.treadAngleThicknessController.text} mm',
                    'Landing Length L': controller.landingLengthController.text,
                    'Landing Plate thickness Lt': '${controller.landingPlateThicknessController.text} mm',
                    'Handrail Pipe Thickness th': '${controller.handrailPipeThicknessController.text} mm',
                    'Baluster Height l\'': controller.balusterHeightController.text,
                    'Landing Railing Sides': controller.landingRailingSidesController.text,
                    'Center Column Height H': controller.centerColumnHeightController.text,
                    'Material Density D': '${controller.materialDensityController.text} Kg/m³',
                    'Stair Outer Radius r': controller.stairOuterRadiusController.text,
                    'Tread Angle Web length l': '${controller.treadAngleWebLengthController.text} mm',
                    'Tread Base Plate thickness t\'': '${controller.treadBasePlateThicknessController.text} mm',
                    'Landing Width W': controller.landingWidthController.text,
                    'Handrail Pipe Dia d': '${controller.handrailPipeDiaController.text} mm',
                    'Baluster Spacing on Landing k': controller.balusterSpacingOnLandingController.text,
                    'Balusters per Stair Tread': controller.balustersPerStairTreadController.text,
                    'Currency Symbol': controller.currencySymbolController.text.isEmpty 
                        ? 'PKR' 
                        : controller.currencySymbolController.text,
                  },
                  tables: _buildResultTables(res),
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
              final currency = controller.currencySymbolController.text.trim().isEmpty
                  ? 'PKR'
                  : controller.currencySymbolController.text.trim();

              double totalCost = 0;
              for (var item in res.results.items) {
                final rate = controller.getPriceForItem(item.desc);
                totalCost += rate * item.weight;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: "Calculation Results",
                    styleType: StyleType.heading,
                  ),
                  SizedBox(height: 2.h),
                  
                  // Items Table
                  AppTextWidget(
                    text: "Material Items",
                    styleType: StyleType.subHeading,
                  ),
                  SizedBox(height: 1.h),
                  DynamicTable(
                      headers: ['Description', 'Length/Area', 'Weight (kg)', 'Cost($currency)'],
                      rows: res.results.items.map((item) {
                        final rate = controller.getPriceForItem(item.desc);
                        final cost = rate * item.weight;
                        return [
                          item.desc,
                          item.lenArea.toStringAsFixed(2),
                          item.weight.toStringAsFixed(1),
                          cost.toStringAsFixed(1),
                         // "{ 'Total Cost', '$totalCost $currency'}",
                        ];
                      }).toList(),
                    ),
                  SizedBox(height: 2.h),
                ],
              );
            }),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildResultTables(SpiralStairModel result) {
    final currency = controller.currencySymbolController.text.trim().isEmpty 
        ? 'PKR' 
        : controller.currencySymbolController.text.trim();
    
    // Calculate total cost
    double totalCost = 0;
    for (var item in result.results.items) {
      final rate = controller.getPriceForItem(item.desc);
      totalCost += rate * item.weight;
    }

    return [
      {
        'title': 'Material Items',
        'headers': ['Description', 'Length/Area', 'Weight (kg)', 'Rate($currency/Kg)', 'Cost($currency)'],
        'rows': result.results.items.map((item) {
          final rate = controller.getPriceForItem(item.desc);
          final cost = rate * item.weight;
          return [
            item.desc,
            item.lenArea.toStringAsFixed(2),
            item.weight.toStringAsFixed(2),
            rate.toStringAsFixed(2),
            cost.toStringAsFixed(2),
          ];
        }).toList(),
      },
      {
        'title': 'Summary',
        'headers': ['Item', 'Value'],
        'rows': [
          ['Number of Treads', result.results.numTreads.toString()],
          ['Total Weight', '${result.results.totalWeight.toStringAsFixed(2)} kg'],
          ['Total Cost', '${totalCost.toStringAsFixed(0)} $currency'],
        ],
      },
    ];
  }
}
