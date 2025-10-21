import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/concrete_cost_estimator_controller.dart';

class ConcreteCostEstimatorScreen extends StatelessWidget {
  final String itemName;
   ConcreteCostEstimatorScreen({super.key, required this.itemName});

   final controller = Get.put(ConcreteCostEstimatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.h,
            children: [
              AppTextWidget(text: "Concrete Cost Estimator",styleType: StyleType.heading,),
              TwoFieldsWidget(
                  heading1: "Currency Symbol",
                  heading2: "Concrete Volume (ft³)",
                  hint: "PKR",
                  hint2: "100",
                  keyboardType2: TextInputType.numberWithOptions(),
                  controller1: controller.currencySymbolController,
                  controller2: controller.concreteVolumeController),
              TwoFieldsWidget(
                  heading1: "Mix Ratio (C:S:A)",
                  hint: "e.g., 0:0:1",
                  heading2: "Cement Rate / bag",
                  keyboardType2: TextInputType.numberWithOptions(),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller1: controller.mixRatioController,
                  controller2: controller.cementRateController),
              TwoFieldsWidget(
                  heading1: "Sand Rate / ft³ (optional)",
                  heading2: "Water / ft³ (optional)",
                  controller1: controller.sandRateController,
                  controller2: controller.waterRateController),
              AppTextField(hintText: '0.30',heading: "Aggregate Rate / ft³ (optional)",),
              TwoFieldsWidget(
                  heading1: "Admixture / ft³ (optional)",
                  heading2: "Labor / ft³ (optional)",
                  controller1: controller.admixtureRateController,
                  controller2: controller.laborRateController),
              SizedBox(height: 1.h,),

              GestureDetector(
                onTap: controller.toggleAdvanced,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppColors.blueColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(text: "Advanced",styleType: StyleType.subHeading,),
                      Obx(() => AnimatedRotation(
                        turns: controller.isAdvancedVisible.value ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(Icons.arrow_drop_down_rounded),
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.h,),
              Obx(() => AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: controller.isAdvancedVisible.value
                    ? Column(
                  children: [
                    SizedBox(height: 1.h),
                    TwoFieldsWidget(
                      heading1: "Dry Volume Factor",
                      heading2: "Wastage %",
                      hint: "1.54",
                      keyboardType: TextInputType.numberWithOptions(),
                      keyboardType2: TextInputType.numberWithOptions(),
                      controller1: controller.dryVolumeFactorController,
                      controller2: controller.wastageController,
                    ),
                    AppTextField(
                        hintText: '3',                      keyboardType: TextInputType.numberWithOptions(),

                        heading: "Cement Bag Size (kg)",
                        controller: controller.cementBagSizeController),
                    AppTextField(
                        hintText: '5',                      keyboardType: TextInputType.numberWithOptions(),

                        heading: "Cement Density (kg/m³)",
                        controller: controller.cementDensityController),
                    AppTextField(
                        hintText: '0',                      keyboardType: TextInputType.numberWithOptions(),

                        heading: "Sand Density (kg/m³)",
                        controller: controller.sandDensityController),
                    AppTextField(
                        hintText: '0',                      keyboardType: TextInputType.numberWithOptions(),

                        heading: "Aggregate Density (kg/m³)",
                        controller: controller.aggregateDensityController),
                    SizedBox(height: 1.h),
                  ],
                )
                    : const SizedBox.shrink(),
              )),
              SizedBox(height: 1.h,),
              AppButtonWidget(text: "Calculate",width: 100.w,height: 5.h,onPressed: (){
                controller.calculate();
              }),
              SizedBox(
                height: 1.h,
              ),
              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final res = controller.concreteCostResult.value;
                  if (res == null) {
                    Get.snackbar("Error", "Please calculate first before downloading PDF.");
                    return;
                  }

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {
                      'Concrete Volume': "${controller.concreteVolumeController.text} ft³",
                      'Mix Ratio': controller.mixRatioController.text,
                    },
                    tables: [
                      // ✅ Summary Table
                      {
                        'title': 'Summary',
                        'headers': ['Description', 'Value'],
                        'rows': [
                          ["Total Cost", "PKR ${res.totalCost.toStringAsFixed(0)}"],
                          ["Wet Volume", "${res.wetVolume} ${AppUtils().formatUnit("ft³")}"],
                          [
                            "Dry Volume (+Wastage)",
                            "${res.dryVolumeWithWastage.toStringAsFixed(0)} ${AppUtils().formatUnit("ft³")}"
                          ],

                        ],
                      },

                      // ✅ Material Quantities Table
                      {
                        'title': 'Material Quantities',
                        'headers': ['Material', 'Quantity'],
                        'rows': res.materialQuantities.map((m) {
                          String formattedVolume;
                          if (m.material.toLowerCase().contains('cement')) {
                            formattedVolume = "${m.volume.toStringAsFixed(0)} bags";
                          } else if (m.material.toLowerCase().contains('sand') ||
                              m.material.toLowerCase().contains('aggregate')) {
                            formattedVolume =
                            "${AppUtils().toRoundedDouble(m.volume).toStringAsFixed(0)} ${AppUtils().formatUnit("ft³")}";
                          } else {
                            formattedVolume =
                            "${AppUtils().toRoundedDouble(m.volume)} ${AppUtils().formatUnit("ft³")}";
                          }
                          return [m.material, formattedVolume];
                        }).toList(),
                      },

                      // ✅ Cost Breakdown Table
                      {
                        'title': 'Cost Breakdown',
                        'headers': ['Item', 'Cost (PKR)'],
                        'rows': res.costBreakdown.map((m) {
                          return [
                            m.item,
                            "PKR ${m.cost.toStringAsFixed(1)} (${m.percentage.toStringAsFixed(1)}%)",
                          ];
                        }).toList(),
                      },
                    ],
                    fileName: '${itemName}_report.pdf',
                  );
                },
              ),
              SizedBox(height: 3.h,),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final result = controller.concreteCostResult.value;
                if (result == null) {
                  return const Center(child: Text("No data available"));
                }

                final mater = result.materialQuantities;

                return Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(text: "Results",styleType: StyleType.heading,),
                    AppTextWidget(text: "Summary",styleType: StyleType.subHeading,),
                    DynamicTable(headers: ["Description","Value"],

                        rows: [
                          [
                            "Total cost", "PKR ${result.totalCost.toStringAsFixed(0)}"
                          ],
                          [

                            "Wet volume", "${result.wetVolume} ${AppUtils().formatUnit("ft3")}"],
                          [
                            "Dry volume (+wastage)", "${result.dryVolumeWithWastage.toStringAsFixed(0)} ${AppUtils().formatUnit("ft3")}"
                          ],
                        ]),
                    AppTextWidget(text: "Material quantities",styleType: StyleType.subHeading,),
                    DynamicTable(headers: ["Description","Value",],

                        rows: result.materialQuantities.map((m) {
                          String formattedVolume;

                          // 🎯 Format based on material name
                          if (m.material.toLowerCase().contains('cement')) {
                            formattedVolume =
                            "${m.volume.toStringAsFixed(0)} bags";
                          } else if (m.material.toLowerCase().contains('sand') ||
                              m.material.toLowerCase().contains('aggregate')) {
                            formattedVolume =
                            "${AppUtils().toRoundedDouble(m.volume).toStringAsFixed(0)} ${AppUtils().formatUnit("ft3")}";
                          }  else {
                            formattedVolume =
                            "${AppUtils().toRoundedDouble(m.volume)} ${AppUtils().formatUnit("ft3")}";
                          }
                          return [
                            m.material,
                            formattedVolume,
                          ];
                        }).toList(),),
                    AppTextWidget(text: "Cost breakdown",styleType: StyleType.subHeading,),
                    DynamicTable(headers: ["Description","Value",],

                        rows: result.costBreakdown.map((m) {
                          String formattedVolume;

                          // 🎯 Format based on material name
                          if (m.item.toLowerCase().contains('cement')) {
                            formattedVolume =
                            "${m.cost.toStringAsFixed(0)} bags";
                          } else if (m.item.toLowerCase().contains('sand') ||
                              m.item.toLowerCase().contains('aggregate')) {
                            formattedVolume =
                            "${AppUtils().toRoundedDouble(m.cost).toStringAsFixed(0)} ${AppUtils().formatUnit("ft3")}";
                          }  else {
                            formattedVolume =
                            "${AppUtils().toRoundedDouble(m.cost)} ${AppUtils().formatUnit("ft3")}";
                          }
                          return [
                            m.item,
                            "PKR ${m.cost.toStringAsFixed(1)} (${m.percentage.toStringAsFixed(1)}%)",
                          ];
                        }).toList(),),
                  ],
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
