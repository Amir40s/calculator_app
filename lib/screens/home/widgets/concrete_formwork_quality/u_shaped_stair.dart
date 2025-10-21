import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/u_shaped_stair_controller.dart';

class UShapedStairScreen extends StatelessWidget {
  final String itemName;
  const UShapedStairScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UShapedStairController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 1.h,
          children: [
            AppTextWidget(
              text: "Input Parameters",
              styleType: StyleType.heading,
            ),
            AppTextWidget(
              text: "Stair Dimensions",
              styleType: StyleType.dialogHeading,
            ),
            AppTextField(
              hintText: "0",
              heading: "Total Number of Risers",
              keyboardType: TextInputType.numberWithOptions(),
              controller: controller.totalRisersController,
            ),
            TwoFieldsWidget(
              heading1: "Riser Height (ft)",
              heading2: "Tread Length (ft)",
              keyboardType: TextInputType.numberWithOptions(),
              controller1: controller.riserHeightController,
              controller2: controller.treadLengthController,
            ),
            TwoFieldsWidget(
              heading1: "Stair Width (ft)",
              heading2: "Winder Steps per Turn",
              keyboardType: TextInputType.numberWithOptions(),
              controller1: controller.stairWidthController,
              controller2: controller.winderStepsController,
            ),
            Obx(() => CheckboxListTile(
                  title: AppTextWidget(text: "Include Winder Steps"),
                  value: controller.includeWinderSteps.value,
                  onChanged: controller.toggleIncludeWinder,
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.blueColor,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            AppTextField(
              hintText: "0",
              heading: "Waist Slab Thickness (ft)",
              keyboardType: TextInputType.numberWithOptions(),
              controller: controller.waistSlabThicknessController,
            ),
            AppTextField(
              hintText: "0",
              heading: "Mid Slab Length (ft)",
              keyboardType: TextInputType.numberWithOptions(),
              controller: controller.midSlabLengthController,
            ),
            AppTextField(
              hintText: "0",
              heading: "Mid Slab Thickness (ft)",
              keyboardType: TextInputType.numberWithOptions(),
              controller: controller.midSlabThicknessController,
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: "0",
                    heading: "Cement",
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: controller.cementController,
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: AppTextField(
                    hintText: "0",
                    heading: "Sand",
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: controller.sandController,
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: AppTextField(
                    hintText: "0",
                    heading: "Crush",
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: controller.crushController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
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
                if (controller.totalUShape.value == null) {
                  Get.snackbar("Error", "Please calculate results first.");
                  return;
                }

                final res = controller.totalUShape.value!;

                await PdfHelper.generateAndOpenPdf(
                  context: context,
                  title: itemName,
                  inputData: {
                    'Mode': "Winder Stair",
                  },
                  tables: [
                    {
                      'title': "Component Volumes",
                      'headers': ["Component", "Volume (ft³)"],
                      'rows': [
                        ["Waist Slab", res.waistVolume.toStringAsFixed(2)],
                        ["Steps", res.stepVolume.toStringAsFixed(2)],
                        ["Winder Steps", res.winderVolume.toStringAsFixed(2)],
                        ["Mid Slab", res.midSlabVolume.toStringAsFixed(2)],
                      ],
                    },
                    {
                      'title': "Summary",
                      'headers': ["Item", "Value"],
                      'rows': [
                        [
                          "Total Volume (ft³)",
                          AppUtils()
                              .toRoundedDouble(res.totalFt3)
                              .toStringAsFixed(0)
                        ],
                        [
                          "Cement (bags)",
                          AppUtils()
                              .toRoundedDouble(res.cementBags)
                              .toStringAsFixed(0)
                        ],
                        [
                          "Sand (ft³)",
                          AppUtils()
                              .toRoundedDouble(res.sandVolume)
                              .toStringAsFixed(0)
                        ],
                        [
                          "Crush (ft³)",
                          AppUtils()
                              .toRoundedDouble(res.crushVolume)
                              .toStringAsFixed(0)
                        ],
                        [
                          "Water (liters)",
                          AppUtils()
                              .toRoundedDouble(res.waterLiters)
                              .toStringAsFixed(0)
                        ],
                      ],
                    },
                  ],
                  fileName: '${itemName}_report.pdf',
                );
              },
            ),
            SizedBox(height: 2.h),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: Loader());
              }
              if (controller.totalUShape.value == null) {
                return Center(
                    child: AppTextWidget(
                        color: AppColors.greyColor,
                        text:
                            "No results yet. Enter details (e.g., 4.5, 0.5) and click Calculate."));
              }

              final res = controller.totalUShape.value!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 1.h,
                children: [
                  AppTextWidget(
                    text: "Calculation Results",
                    styleType: StyleType.heading,
                  ),
                  AppTextWidget(
                    text: "Mode:Winder Stair",
                    styleType: StyleType.subHeading,
                  ),
                  DynamicTable(headers: [
                    "Component",
                    "Volume (ft³)"
                  ], rows: [
                    ["Waist Slab", res.waistVolume.toStringAsFixed(2)],
                    ["Steps", res.stepVolume.toStringAsFixed(2)],
                    ["Winder Steps", res.winderVolume.toStringAsFixed(2)],
                    ["Mid Slab", res.midSlabVolume.toStringAsFixed(2)],
                  ]),
                  SizedBox(
                    height: 2.h,
                  ),
                  AppTextWidget(
                    text: "Summary",
                    styleType: StyleType.subHeading,
                  ),
                  DynamicTable(headers: [
                    "Item",
                    "Value"
                  ], rows: [
                    [
                      "Total Volume (ft³)",
                      AppUtils()
                          .toRoundedDouble(res.totalFt3)
                          .toStringAsFixed(0)
                    ],
                    [
                      "Cement (bags)",
                      AppUtils()
                          .toRoundedDouble(res.cementBags)
                          .toStringAsFixed(0)
                    ],
                    [
                      "Sand (ft³)",
                      AppUtils()
                          .toRoundedDouble(res.sandVolume)
                          .toStringAsFixed(0)
                    ],
                    [
                      "Crush (ft³)",
                      AppUtils()
                          .toRoundedDouble(res.crushVolume)
                          .toStringAsFixed(0)
                    ],
                    [
                      "Water (liters)",
                      AppUtils()
                          .toRoundedDouble(res.waterLiters)
                          .toStringAsFixed(0)
                    ],
                  ]),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
