import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/cost_estimation_widget.dart';
import 'package:smart_construction_calculator/core/component/custom_ui_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/cost_estimation/finishing_cost_controller.dart';

import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/dropdown_widget.dart';
import '../../../../core/component/result_box_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/cost_estimation/cost_estimation_controller.dart';
import '../../../../core/controller/calculators/cost_estimation/grey_structure_controller.dart';

class CostEstimationScreen extends StatelessWidget {
  final String itemName;
  CostEstimationScreen({super.key, required this.itemName});
  final controller = Get.put(CostEstimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuiltupAreaWidget(
                onChanged: controller.setBuiltupArea,
              ),
              AppTextWidget(
                text: "Grey Structure Material Prices",
                styleType: StyleType.dialogHeading,
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
              SizedBox(height: 2.h),
              AppTextWidget(
                text: "Finishing Material Quality",
                styleType: StyleType.dialogHeading,
              ),
              ReusableDropdown(
                selectedValue: controller.selectedQuality,
                itemsList: controller.availableQuality,
                hintText: 'Select Quality',
                onChangedCallback: (value) {
                  controller.onQualityChanged(value);
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              AppButtonWidget(
                text: "Calculate",
                onPressed: () {
                  controller.fetchCombinedData();
                },
                width: 100.w,
                height: 5.h,
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!controller.isFinished.value) {
                  return const SizedBox();
                }

                final grey = controller.greyData.value;
                final finish = controller.finishingCostData.value;

                if (grey == null || finish == null) {
                  return const Center(child: Text('Please calculate again.'));
                }
// ✅ Calculate total dynamically from both lists
                final double greyMonthsTotal = grey.monthlyDistribution
                    .skip(1) // skip index 0
                    .fold(0.0, (sum, month) => sum + month.amount);

                final double finishMonthsTotal = finish.monthly
                    .fold(0.0, (sum, amount) => sum + amount);

                final double combinedTotal = greyMonthsTotal + finishMonthsTotal;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomUiWidget(
                        header: "Project Cost Breakdown",
                        total: controller.combinedTotal.toStringAsFixed(0),
                        children: [
                          ResultList(
                              value: "Grey Structure",
                              price: grey.totalCost.toStringAsFixed(0)),
                          ResultList(
                              value: "Finishing",
                              price: finish.total.toStringAsFixed(0)),
                        ]),
                    AppTextWidget(
                      text: 'Grey Structure Results',
                      styleType: StyleType.dialogHeading,
                    ),
                    CustomUiWidget(
                      header: "Material Cost",
                      total: grey.totalCost.toString(),
                      children: [
                        ResultList(
                            value: "Excavation:",
                            price: grey.excavationCost.toStringAsFixed(0)),
                        ResultList(
                            value: "cement:",
                            price: grey.cementCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Sand:",
                            price: grey.sandCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Aggregate:",
                            price: grey.aggregateCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Water:",
                            price: grey.waterCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Steel:",
                            price: grey.steelCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Block:",
                            price: grey.blockCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Back Fill Material:",
                            price:
                                grey.backFillMaterialCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Door Frame:",
                            price: grey.doorFrameCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Electrical Conduiting:",
                            price: grey.electricalConduitingCost
                                .toStringAsFixed(0)),
                        ResultList(
                            value: "Sewage:",
                            price: grey.sewageCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Miscellaneous:",
                            price: grey.miscellaneousCost.toStringAsFixed(0)),
                        ResultList(
                            value: "Labor:",
                            price: grey.waterCost.toStringAsFixed(0)),
                        ResultList(
                            value: " Project Management:",
                            price:
                                grey.projectManagementCost.toStringAsFixed(0)),
                      ],
                    ),
                    CustomUiWidget(
                      header: "Monthly Expense",
                      total: grey.totalCost.toStringAsFixed(0),
                      children: grey.monthlyDistribution.map((month) {
                        return ResultList(
                          value:
                              "${month.period} (${month.percentage.toStringAsFixed(0)}%) :",
                          price: month.amount.toStringAsFixed(0),
                        );
                      }).toList(),
                    ),
                    AppTextWidget(
                      text: 'Finishing Cost Results',
                      styleType: StyleType.dialogHeading,
                    ),
                    CustomUiWidget(
                        header: "Cost Breakdown",
                        total: grey.totalCost.toString(),
                        children: [
                          ...finish.groups.map((group) {
                            double totalGroupAmount = group.rows
                                .fold(0.0, (sum, row) => sum + row.amount);

                            return Padding(
                              padding: EdgeInsets.all(2.5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                      text: group.name,
                                      styleType: StyleType.subHeading),

                                  ...group.rows.map((row) {
                                    return ResultBoxTile(
                                      subHeading: row.note,
                                      price: row.amount.toStringAsFixed(0),
                                      heading: row.name,
                                    );
                                  }),

                                  // Display subtotal for the group
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: "Subtotal:",
                                      ),
                                      AppTextWidget(
                                        text:
                                            totalGroupAmount.toStringAsFixed(0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h), // Space between groups
                                ],
                              ),
                            );
                          })
                        ]),
                    CustomUiWidget(
                        header: "Monthly Expense",
                        total: finish.total.toStringAsFixed(0),
                        children: [
                          ...finish.monthly.asMap().entries.map((entry) {
                            int index = entry.key + 1;
                            double monthAmount = entry.value;
                            return CostBreakdownTotal(
                              title: ' Month $index ',
                              result: "PKR ${monthAmount.toStringAsFixed(0)}",
                              color: Colors.transparent,
                            );
                          }),
                        ]),
                    AppTextWidget(
                      text: 'Combined Results',
                      styleType: StyleType.dialogHeading,
                    ),
                    CustomUiWidget(
                      header: "Combined Monthly Expense",
                      total: combinedTotal.toStringAsFixed(0),
                      children: [
                        // 🔹 Combine both lists
                        ...List.generate(
                          (grey.monthlyDistribution.length - 1) +
                              finish.monthly.length,
                          (index) {
                            // grey part
                            if (index < grey.monthlyDistribution.length - 1) {
                              final month = grey
                                  .monthlyDistribution[index + 1]; // skip first
                              return ResultBoxTile(
                                heading: "Month ${index + 1}",
                                subHeading: "",
                                price: month.amount.toStringAsFixed(0),
                              );
                            } else {
                              // finish part
                              final finishIndex =
                                  index - (grey.monthlyDistribution.length - 1);
                              final monthAmount = finish.monthly[finishIndex];
                              return ResultBoxTile(
                                heading: "Month ${index + 1}",
                                subHeading: "",
                                price: monthAmount.toStringAsFixed(0),
                              );
                            }
                          },
                        ),
                      ],

                    )
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
