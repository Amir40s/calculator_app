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
import '../../../../core/component/dropdown_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/straight_stair_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class StairConcreteCalculator extends StatelessWidget {
  final String itemName;
   StairConcreteCalculator({super.key, required this.itemName});

  final controller = Get.put(StraightStairController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              
              // Header with Add Stair Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: "Stairs",
                    styleType: StyleType.heading,
                  ),
                  AppButtonWidget(
                    text: "+ Add Stair",
                    width: 35.w,
                    height: 4.h,
                    buttonColor: Colors.green,
                    onPressed: controller.addStair,
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Stairs Input Section
              for (int i = 0; i < controller.stairs.length; i++) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text: "Stair ${i + 1}",
                          styleType: StyleType.dialogHeading,
                        ),
                        if (controller.stairs.length > 1)
                          AppButtonWidget(
                            text: "Delete",
                            width: 20.w,
                            height: 3.h,
                            buttonColor: Colors.red,
                            radius: 2.w,
                            onPressed: () => controller.deleteStair(i),
                          ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    // Stair Type
                    ReactiveDropdown(
                      heading: "Stair Type",
                      selectedValue: controller.stairTypes[i],
                      itemsList: controller.availableStairTypes,
                      hintText: "Select Type",
                      onChangedCallback: (value) {
                        controller.stairTypes[i].value = value;
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Stair Dimensions
                    AppTextWidget(
                      text: "Stair Dimensions",
                      styleType: StyleType.subHeading,
                    ),
                    SizedBox(height: 1.h),
                    TwoFieldsWidget(
                      heading1: "Stair Width (ft'in\")",
                      heading2: "Going per step (ft'in\")",
                      hint: "e.g., 3'3\"",
                      hint2: "e.g., 0'12\"",
                      keyboardType: TextInputType.text,
                      keyboardType2: TextInputType.text,
                      controller1: controller.stairs[i]['stairWidth']!,
                      controller2: controller.stairs[i]['goingPerStep']!,
                    ),
                    SizedBox(height: 1.h),
                    TwoFieldsWidget(
                      heading1: "Riser per step (ft'in\")",
                      heading2: "Waist Thickness (ft'in\")",
                      hint: "e.g., 0'7\"",
                      hint2: "e.g., 0'6\"",
                      keyboardType: TextInputType.text,
                      keyboardType2: TextInputType.text,
                      controller1: controller.stairs[i]['riserPerStep']!,
                      controller2: controller.stairs[i]['waistThickness']!,
                    ),
                    SizedBox(height: 1.h),
                    Obx(() {
                      final stairType = controller.stairTypes[i].value;
                      
                      // Straight stair - show Number of Steps
                      if (stairType == 'Straight (with Optional Landings)') {
                        return Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                heading: "No. of Steps",
                                hintText: "12",
                                keyboardType: TextInputType.number,
                                controller: controller.stairs[i]['numberOfSteps']!,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: AppTextField(
                                heading: "Slab/landing thickness (ft'in\")",
                                hintText: "e.g., 0'6\"",
                                keyboardType: TextInputType.text,
                                controller: controller.stairs[i]['slabThickness']!,
                              ),
                            ),
                          ],
                        );
                      }
                      
                      // L/U-shaped - show Flight 1 and Flight 2 Steps
                      if (controller.needsFlightSteps(stairType)) {
                        return Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                heading: "Flight 1 Steps",
                                hintText: "8",
                                keyboardType: TextInputType.number,
                                controller: controller.stairs[i]['flight1Steps']!,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: AppTextField(
                                heading: "Flight 2 Steps",
                                hintText: "10",
                                keyboardType: TextInputType.number,
                                controller: controller.stairs[i]['flight2Steps']!,
                              ),
                            ),
                          ],
                        );
                      }
                      
                      return const SizedBox.shrink();
                    }),
                    SizedBox(height: 2.h),

                    // Winder fields (for L/U-shaped with Winder)
                    Obx(() {
                      final stairType = controller.stairTypes[i].value;
                      if (!controller.needsWinderFields(stairType)) {
                        return const SizedBox.shrink();
                      }
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: "Winder Details",
                            styleType: StyleType.subHeading,
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  heading: "Winder steps 1",
                                  hintText: "2",
                                  keyboardType: TextInputType.number,
                                  controller: controller.stairs[i]['winderSteps1']!,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: AppTextField(
                                  heading: "Winder going (ft'in\")",
                                  hintText: "e.g., 0'0\"",
                                  keyboardType: TextInputType.text,
                                  controller: controller.stairs[i]['winderGoing']!,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          ReactiveDropdown(
                            heading: "Winder Step Method",
                            selectedValue: controller.winderStepMethods[i],
                            itemsList: ['Walking-line (recommended)', 'Width/√2 (legacy)',],
                            hintText: "Select Method",
                            onChangedCallback: (value) {
                              controller.winderStepMethods[i].value = value;
                            },
                          ),
                          SizedBox(height: 2.h),
                          AppTextWidget(
                            text: "Winder Platform 1",
                            styleType: StyleType.subHeading,
                          ),
                          SizedBox(height: 1.h),
                          TwoFieldsWidget(
                            heading1: "Length (ft'in\")",
                            heading2: "Width (ft'in\")",
                            hint: "e.g., 0'0\"",
                            hint2: "e.g., 0'0\"",
                            keyboardType: TextInputType.text,
                            keyboardType2: TextInputType.text,
                            controller1: controller.stairs[i]['winderPlatform1Length']!,
                            controller2: controller.stairs[i]['winderPlatform1Width']!,
                          ),
                          if (stairType == 'U-shaped with Winder') ...[
                            SizedBox(height: 2.h),
                            AppTextWidget(
                              text: "Winder Platform 2",
                              styleType: StyleType.subHeading,
                            ),
                            SizedBox(height: 1.h),
                            TwoFieldsWidget(
                              heading1: "Length (ft'in\")",
                              heading2: "Width (ft'in\")",
                              hint: "e.g., 0'0\"",
                              hint2: "e.g., 0'0\"",
                              keyboardType: TextInputType.text,
                              keyboardType2: TextInputType.text,
                              controller1: controller.stairs[i]['winderPlatform2Length']!,
                              controller2: controller.stairs[i]['winderPlatform2Width']!,
                            ),
                          ],
                        ],
                      );
                    }),
                    SizedBox(height: 2.h),

                    // Landing/Slab thickness and Mid Landing (for L/U-shaped)
                    Obx(() {
                      final stairType = controller.stairTypes[i].value;
                      
                      if (stairType == 'Straight (with Optional Landings)') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bottom Landing Slab (Optional)
                            AppTextWidget(
                              text: "Bottom Landing Slab (Optional)",
                              styleType: StyleType.subHeading,
                            ),
                            SizedBox(height: 1.h),
                            TwoFieldsWidget(
                              heading1: "Length (ft'in\")",
                              heading2: "Width (ft'in\")",
                              hint: "e.g., 2'2\"",
                              hint2: "e.g., 2'2\"",
                              keyboardType: TextInputType.text,
                              keyboardType2: TextInputType.text,
                              controller1: controller.stairs[i]['bottomLandingLength']!,
                              controller2: controller.stairs[i]['bottomLandingWidth']!,
                            ),
                            SizedBox(height: 2.h),
                            // Top Landing Slab (Optional)
                            AppTextWidget(
                              text: "Top Landing Slab (Optional)",
                              styleType: StyleType.subHeading,
                            ),
                            SizedBox(height: 1.h),
                            TwoFieldsWidget(
                              heading1: "Length (ft'in\")",
                              heading2: "Width (ft'in\")",
                              hint: "e.g., 2'2\"",
                              hint2: "e.g., 2'2\"",
                              keyboardType: TextInputType.text,
                              keyboardType2: TextInputType.text,
                              controller1: controller.stairs[i]['topLandingLength']!,
                              controller2: controller.stairs[i]['topLandingWidth']!,
                            ),
                          ],
                        );
                      }
                      
                      if (controller.needsMidLanding(stairType)) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              heading: stairType.contains('Winder') 
                                  ? "Landing/Slab thickness (ft'in\")"
                                  : "Slab/landing thickness (ft'in\")",
                              hintText: "e.g., 0'6\"",
                              keyboardType: TextInputType.text,
                              controller: controller.stairs[i]['slabThickness']!,
                            ),
                            SizedBox(height: 2.h),
                            AppTextWidget(
                              text: "Mid Landing",
                              styleType: StyleType.subHeading,
                            ),
                            SizedBox(height: 1.h),
                            TwoFieldsWidget(
                              heading1: "Mid Landing Length (ft'in\")",
                              heading2: "Mid Landing Width (ft'in\")",
                              hint: "e.g., 0'0\"",
                              hint2: "e.g., 0'0\"",
                              keyboardType: TextInputType.text,
                              keyboardType2: TextInputType.text,
                              controller1: controller.stairs[i]['midLandingLength']!,
                              controller2: controller.stairs[i]['midLandingWidth']!,
                            ),
                          ],
                        );
                      }
                      
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ],

              SizedBox(height: 2.h),

              // Mix Ratio and Other Parameters
              AppTextWidget(
                text: "Mix Ratio and Other Parameters",
                styleType: StyleType.heading,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      heading: "Cement",
                      hintText: "1",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: controller.cementController,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: AppTextField(
                      heading: "Sand",
                      hintText: "2",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: controller.sandController,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: AppTextField(
                      heading: "Aggregate",
                      hintText: "4",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: controller.aggregateController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      heading: "Dry Factor",
                      hintText: "1.54",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: controller.dryFactorController,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: AppTextField(
                      heading: "Water-cement ratio",
                      hintText: "0.5",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: controller.waterCementRatioController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      heading: "Cement bag (kg)",
                      hintText: "50",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: controller.cementBagKgController,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: AppTextField(
                      heading: "Bag Vol (ft³)",
                      hintText: "1.25",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: controller.bagVolController,
                    ),
                  ),
                ],
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
                      'Mix Ratio': '${controller.cementController.text}:${controller.sandController.text}:${controller.aggregateController.text}',
                      'Dry Factor': controller.dryFactorController.text,
                      'Water-Cement Ratio': controller.waterCementRatioController.text,
                    },
                    tables: [
                      for (int i = 0; i < res.stairResults.length; i++)
                        {
                          'title': res.stairResults[i].name,
                          'headers': ['Component', 'ft³', 'm³'],
                          'rows': [
                            ['Stair', res.stairResults[i].stairV.toStringAsFixed(0), (res.stairResults[i].stairV * 0.0283168).toStringAsFixed(3)],
                            ['Slab', res.stairResults[i].slabV.toStringAsFixed(0), (res.stairResults[i].slabV * 0.0283168).toStringAsFixed(3)],
                            ['Total', res.stairResults[i].totalV.toStringAsFixed(0), res.stairResults[i].m3.toStringAsFixed(3)],
                          ],
                        },
                      {
                        'title': 'Project Totals',
                        'headers': ['Stair ft³', 'Slab ft³', 'Total ft³', 'Total m³'],
                        'rows': [
                          [
                            res.totals.stair.toStringAsFixed(0),
                            res.totals.slab.toStringAsFixed(0),
                            res.totals.total.toStringAsFixed(0),
                            (res.totals.total * 0.0283168).toStringAsFixed(0),
                          ],
                        ],
                      },
                      {
                        'title': 'Grand Total Mix Breakdown',
                        'headers': ['Item', 'Value'],
                        'rows': [
                          ['Cement', '${res.mixSummary.bags.toStringAsFixed(0)} bags (${res.mixSummary.cementKg.toStringAsFixed(0)} kg)'],
                          ['Sand', '${res.mixSummary.Vsand.toStringAsFixed(0)} ft³'],
                          ['Crush/Aggregate', '${res.mixSummary.Vagg.toStringAsFixed(0)} ft³'],
                          ['Water', '${res.mixSummary.waterL.toStringAsFixed(0)} liters (w/c = ${res.mixValues.wc})'],
                        ],
                      },
                    ],
                  );
                },
              ),
              SizedBox(height: 2.h),
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
                    text: "No results yet. Enter stair details and click Calculate.",
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: "Project Results",
                      styleType: StyleType.heading,
                    ),
                    SizedBox(height: 2.h),

                    // Individual Stair Results
                    for (int i = 0; i < res.stairResults.length; i++) ...[
                      AppTextWidget(
                        text: res.stairResults[i].name,
                        styleType: StyleType.subHeading,
                      ),
                      SizedBox(height: 1.h),
                      DynamicTable(
                        headers: ['Component', 'ft³', 'm³'],
                        rows: [
                          [
                            'Stair',
                            res.stairResults[i].stairV.toStringAsFixed(0),
                            (res.stairResults[i].stairV * 0.0283168).toStringAsFixed(0),
                          ],
                          [
                            'Slab',
                            res.stairResults[i].slabV.toStringAsFixed(0),
                            (res.stairResults[i].slabV * 0.0283168).toStringAsFixed(0),
                          ],
                          [
                            'Total',
                            res.stairResults[i].totalV.toStringAsFixed(0),
                            res.stairResults[i].m3.toStringAsFixed(0),
                          ],
                        ],
                      ),
                      SizedBox(height: 2.h),
                    ],

                    // Project Totals
                    AppTextWidget(
                      text: "Project Totals",
                      styleType: StyleType.subHeading,
                    ),
                    SizedBox(height: 1.h),
                    DynamicTable(
                      headers: ['Stair ft³', 'Slab ft³', 'Total ft³', 'Total m³'],
                      rows: [
                        [
                          res.totals.stair.toStringAsFixed(0),
                          res.totals.slab.toStringAsFixed(0),
                          res.totals.total.toStringAsFixed(0),
                          (res.totals.total * 0.0283168).toStringAsFixed(0),
                        ],
                      ],
                    ),

                    SizedBox(height: 2.h),

                    AppTextWidget(
                      text: "Grand Total Mix Breakdown",
                      styleType: StyleType.subHeading,
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppColors.baseColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.greyColor.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMixRow('Cement', '${res.mixSummary.bags.toStringAsFixed(0)} bags (${res.mixSummary.cementKg.toStringAsFixed(0)} kg)'),
                          SizedBox(height: 1.h),
                          _buildMixRow('Sand', '${res.mixSummary.Vsand.toStringAsFixed(0)} ft³'),
                          SizedBox(height: 1.h),
                          _buildMixRow('Crush/Aggregate', '${res.mixSummary.Vagg.toStringAsFixed(0)} ft³'),
                          SizedBox(height: 1.h),
                          _buildMixRow('Water', '${res.mixSummary.waterL.toStringAsFixed(0)} liters (w/c = ${res.mixValues.wc})'),
                          SizedBox(height: 1.h),

                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    AppTextWidget(
                      text: "Mix/materials based on all project stairs. Adjust mix fields above.",
                      styleType: StyleType.body,
                      color: AppColors.greyColor,
                    ),
                    SizedBox(height: 2.h),


                  ],
                );
              }),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMixRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          text: "$label:",
          styleType: StyleType.body,
        ),
        AppTextWidget(
          text: value,
          styleType: StyleType.body,
        ),
      ],
    );
  }
}
