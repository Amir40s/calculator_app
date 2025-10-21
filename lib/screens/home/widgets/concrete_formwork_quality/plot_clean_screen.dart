import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/plot_clean_controller.dart';

class PlotCleanScreen extends StatelessWidget {
  final String itemName;
  PlotCleanScreen({super.key, required this.itemName});

  final controller = Get.put(PlotCleanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.h,
            children: [
              AppTextWidget(
                text: "Concrete Input",
                styleType: StyleType.heading,
              ),
              TwoFieldsWidget(
                  heading1: "Plot Length (ft'in\")",
                  heading2: "Plot Width (ft'in\")",
                  hint: "e.g., 8'0\"",
                  hint2: "e.g., 0'6\"",
                  controller1: controller.plotLengthController,
                  controller2: controller.plotWidthController),
              AppTextField(
                hintText: "e.g., 4'6\"",
                heading: "Thickness (ft'in\")",
                controller: controller.thicknessController,
              ),
              AppTextWidget(
                text: "Concrete Ratio (cement:sand:crush)",
                styleType: StyleType.subHeading,
              ),
              Row(
                spacing: 1.w,
                children: [
                  Expanded(
                      child: AppTextField(
                    hintText: "1",
                    controller: controller.cementController,
                  )),
                  AppTextWidget(text: ":"),
                  Expanded(
                      child: AppTextField(
                    hintText: "2",
                    controller: controller.sandController,
                  )),
                  AppTextWidget(text: ":"),
                  Expanded(
                      child: AppTextField(
                    hintText: "3",
                    controller: controller.crushController,
                  )),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: () {
                  controller.convert();
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final res = controller.plotResult.value;
                  if (res == null) {
                    Get.snackbar("Error",
                        "Please calculate first before downloading PDF.");
                    return;
                  }

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {},
                    tables: [
                      {
                        'title': 'Concrete Results',
                        'headers': ['Item', 'Quantity'],
                        'rows': [
                          [
                            'Wet Volume (ft³)',
                            AppUtils()
                                .toRoundedDouble(res.results?.wetVolume)
                                .toStringAsFixed(0)
                          ],
                          [
                            'Dry Volume (ft³)',
                            AppUtils()
                                .toRoundedDouble(res.results?.dryVolume)
                                .toStringAsFixed(0)
                          ],
                          [
                            'Cement Bags',
                            AppUtils()
                                .toRoundedDouble(res.results?.cementBags)
                                .toStringAsFixed(0)
                          ],
                          [
                            'Sand (ft³)',
                            AppUtils()
                                .toRoundedDouble(res.results?.sandVol)
                                .toStringAsFixed(0)
                          ],
                          [
                            'Crush (ft³)',
                            AppUtils()
                                .toRoundedDouble(res.results?.crushVol)
                                .toStringAsFixed(0)
                          ],
                          [
                            'Water (liters)',
                            AppUtils()
                                .toRoundedDouble(res.results?.waterLiters)
                                .toStringAsFixed(0)
                          ],
                        ]
                      }
                    ],
                    fileName: '${itemName}_report.pdf',
                  );
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Loader(),
                  );
                }
                final res = controller.plotResult.value;
                if (res == null) {
                  return AppTextWidget(
                    color: AppColors.greyColor,
                    text:
                        "No results yet. Enter details (e.g., 4'6\", 8'0\", 0'6\", 1:2:4) and click \"Calculate\".",
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1.h,
                  children: [
                    AppTextWidget(
                      text: "Concrete Results",
                      styleType: StyleType.heading,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    DynamicTable(headers: [
                      'Item',
                      'Quantity'
                    ], rows: [
                      [
                        'Wet Volume (ft³)',
                        AppUtils()
                            .toRoundedDouble(res.results?.wetVolume)
                            .toStringAsFixed(0)
                      ],
                      [
                        'Dry Volume (ft³)',
                        AppUtils()
                            .toRoundedDouble(res.results?.dryVolume)
                            .toStringAsFixed(0)
                      ],
                      [
                        'Cement Bags',
                        AppUtils()
                            .toRoundedDouble(res.results?.cementBags)
                            .toStringAsFixed(0)
                      ],
                      [
                        'Sand (ft³)',
                        AppUtils()
                            .toRoundedDouble(res.results?.sandVol)
                            .toStringAsFixed(0)
                      ],
                      [
                        'Crush (ft³)',
                        AppUtils()
                            .toRoundedDouble(res.results?.crushVol)
                            .toStringAsFixed(0)
                      ],
                      [
                        'Water (liters)',
                        AppUtils()
                            .toRoundedDouble(res.results?.waterLiters)
                            .toStringAsFixed(0)
                      ],
                    ]),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
