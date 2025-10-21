import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/cost_estimation_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/custom_ui_widget.dart';
import '../../../../core/component/result_box_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/cost_estimation/grey_structure_controller.dart';

class GreyStructureConversionScreen extends StatelessWidget {
  final String itemName;
  GreyStructureConversionScreen({super.key, required this.itemName});

  final controller = Get.put(GreyStructureController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuiltupAreaWidget(
                onChanged: controller.setBuiltupArea,
              ),
              AppTextField(
                heading: "Cement Rate/ Bag:",
                hintText: "0",
                controller: controller.cementRate,
              ),
              AppTextField(
                heading: "Aggregate (Crush) Rate / CFT:",
                hintText: "0",
                controller: controller.aggregateRate,
              ),

              TwoFieldsWidget(
                  heading1: 'Sand Rate / CFT:',
                  controller1: controller.sandRate,
                  controller2: controller.waterRate,
                  heading2: "Water Rate / L:"),
              TwoFieldsWidget(
                  heading1: 'Steel Rate / Kg:',
                  controller1: controller.steelRate,
                  controller2: controller.blockRate,
                  heading2: "Block Rate / Unit:"),
              SizedBox(height: 4.h,),
              AppButtonWidget(
                text: "Calculate",
                onPressed: () {
                  controller.fetchGreyStructureData();
                },
                width: 100.w,
                height: 5.h,
              ),              SizedBox(height: 1.h,),
              AppButtonWidget(
                text: "Download PDF",
                onPressed: () async {
                  final greyData = controller.greyData.value;

                  if (greyData == null) {
                    Get.snackbar("Error", "Please calculate first before downloading PDF.");
                    return;
                  }
                  final data = greyData;
                  final materialRows = [
                    ['Excavation', data.excavationCost.toStringAsFixed(0)],
                    ['Cement', data.cementCost.toStringAsFixed(0)],
                    ['Sand', data.sandCost.toStringAsFixed(0)],
                    ['Aggregate', data.aggregateCost.toStringAsFixed(0)],
                    ['Water', data.waterCost.toStringAsFixed(0)],
                    ['Steel', data.steelCost.toStringAsFixed(0)],
                    ['Block', data.blockCost.toStringAsFixed(0)],
                    ['Back Fill Material', data.backFillMaterialCost.toStringAsFixed(0)],
                    ['Door Frame', data.doorFrameCost.toStringAsFixed(0)],
                    ['Electrical Conduiting', data.electricalConduitingCost.toStringAsFixed(0)],
                    ['Sewage', data.sewageCost.toStringAsFixed(0)],
                    ['Miscellaneous', data.miscellaneousCost.toStringAsFixed(0)],
                    ['Labor', data.laborCost.toStringAsFixed(0)],
                    ['Project Management', data.projectManagementCost.toStringAsFixed(0)],
                  ]
                      .map((row) => row.map((e) => e.toString() ?? '').toList())
                      .toList();


                  final monthlyRows = data.monthlyDistribution.map((month) {
                    final period = month.period.toString() ?? '';
                    final percentage = month.percentage.toStringAsFixed(0) ?? '0';
                    final amount = month.amount.toStringAsFixed(0) ?? '0';
                    return ['$period ($percentage%)', amount];
                  }).toList();

                  final totalRows = [
                    ['Total Material Cost', data.totalCost.toStringAsFixed(0)],
                    [
                      'Grand Total (Including Management)',
                      (data.totalCost + data.projectManagementCost).toStringAsFixed(0)
                    ],
                  ]
                      .map((row) => row.map((e) => e.toString() ?? '').toList())
                      .toList();

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {
                      'Built-up Area': '${controller.builtupArea.value} sqft',
                      'Cement Rate': '${controller.cementRate.text} Rs/bag',
                      'Steel Rate': '${controller.steelRate.text} Rs/kg',
                    },
                    tables: [
                      {
                        'title': 'MATERIAL COST BREAKDOWN',
                        'headers': ['Material / Service', 'Cost (Rs)'],
                        'rows': materialRows,
                      },
                      {
                        'title': 'MONTHLY EXPENSE',
                        'headers': ['Period', 'Amount (Rs)'],
                        'rows': monthlyRows,
                      },
                      {
                        'title': 'TOTAL SUMMARY',
                        'headers': ['Description', 'Value (Rs)'],
                        'rows': totalRows,
                      },
                    ],
                    fileName: '${itemName}_report.pdf',
                  );
                },
                width: 100.w,
                height: 5.h,
              ),
              SizedBox(height: 2.h,),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }

                final data = controller.greyData.value;
                if (data == null) {
                  return const Center(
                      child: Text('Enter area and tap "Calculate Now"'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomUiWidget(
                      header: "Material Cost",
                      total: data.totalCost.toString(),
                      children: [
                        ResultList(
                            value: "Excavation:",
                            price: data.excavationCost.toStringAsFixed(0)),
                        ResultList(
                            value: "cement:",
                            price: data.cementCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Sand:",
                            price: data.sandCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Aggregate:",
                            price: data.aggregateCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Water:",
                            price: data.waterCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Steel:",
                            price: data.steelCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Block:",
                            price: data.blockCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Back Fill Material:",
                            price:
                                data.backFillMaterialCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Door Frame:",
                            price: data.doorFrameCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Electrical Conduiting:",
                            price: data.electricalConduitingCost
                                .toStringAsFixed(0)),
                        ResultList(
                            value: "Sewage:",
                            price: data.sewageCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Miscellaneous:",
                            price: data.miscellaneousCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Labor:",
                            price: data.waterCost.toStringAsFixed(0)),
                        ResultList(
                            value: " Project Management:",
                            price:
                                data.projectManagementCost.toStringAsFixed(0)),
                      ],
                    ),
                    CustomUiWidget(
                      header: "Monthly Expense",
                      total: data.totalCost.toString(),
                      children: data.monthlyDistribution.map((month) {
                        return ResultList(
                          value:
                              "${month.period} (${month.percentage.toStringAsFixed(0)}%) :",
                          price: month.amount.toStringAsFixed(0),
                        );
                      }).toList(),
                    ),
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
