import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/cost_estimation_widget.dart';
import 'package:smart_construction_calculator/core/component/result_box_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/cost_estimation/finishing_cost_controller.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/buttons_row_widget.dart';
import '../../../../core/component/dropdown_widget.dart';

class FinishingCostScreen extends StatelessWidget {
  final String itemName;
  FinishingCostScreen({super.key, required this.itemName});
  final controller = Get.put(FinishingCostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuiltupAreaWidget(  onChanged: (value) {
                controller.setValue(value);
              },),
              SizedBox(height: 2.h),
              ReusableDropdown(
                selectedValue: controller.selectedQuality,
                itemsList: controller.availableQuality,
                hintText: 'Select Quality',
                onChangedCallback: (value) {
                  controller.onUnitChanged(value);
                },
              ),
              SizedBox(height: 3.h),
          
              // Calculate and Reset Buttons
              ReusableButtonRow(
                firstButtonText: 'Reset',
                secondButtonText: 'Calculate',
                firstButtonAction: () {
                  controller.reset();
                },
                secondButtonAction: () {
                  controller.convert();
                },
              ),
              SizedBox(height: 1.h),
              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final finishingData = controller.finishingCostData.value;

                  if (finishingData == null) {
                    Get.snackbar("Error", "Please calculate first before downloading PDF.");
                    return;
                  }

                  final data = finishingData;

                  final List<Map<String, dynamic>> groupTables = data.groups.map((group) {
                    final rows = group.rows.map((row) {
                      return [row.name, row.note, row.amount.toStringAsFixed(0)];
                    }).toList();

                    final totalGroupAmount =
                    group.rows.fold(0.0, (sum, row) => sum + row.amount);
                    rows.add(["Subtotal", "", totalGroupAmount.toStringAsFixed(0)]);

                    return {
                      'title': group.name,
                      'headers': ['Item', 'Description', 'Amount (PKR)'],
                      'rows': rows,
                    };
                  }).toList();

                  final monthlyRows = data.monthly
                      .asMap()
                      .entries
                      .map((entry) => [
                    "Month ${entry.key + 1}",
                    entry.value.toStringAsFixed(0),
                  ])
                      .toList();

                  final monthlyTable = {
                    'title': 'Monthly Expense',
                    'headers': ['Month', 'Amount (PKR)'],
                    'rows': monthlyRows,
                  };

                  final totalTable = {
                    'title': 'Total Summary',
                    'headers': ['Description', 'Value (PKR)'],
                    'rows': [
                      ['Total Material Cost', data.total.toStringAsFixed(0)],
                      ['Rate per Sq Ft', data.perSqFt.toStringAsFixed(0)],
                    ],
                  };

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {
                      'Built-up Area:': '${controller.inputValue.value} sqft',
                      'Finishing Material Quality:': controller.selectedQuality.value,
                      'Rate per Sq Ft:': 'PKR ${data.perSqFt} / ft²',
                    },
                    tables: [
                      ...groupTables,
                      monthlyTable,
                      totalTable,
                    ],
                    fileName: '${itemName}_report.pdf',
                  );
                },
              ),

              SizedBox(height: 3.h),

              CostBreakdown(controller: controller,),

            ],
          ),
        ),
      ),
    );
  }
}

