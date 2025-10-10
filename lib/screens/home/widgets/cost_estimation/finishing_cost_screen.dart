import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/cost_estimation_widget.dart';
import 'package:smart_construction_calculator/core/component/result_box_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/cost_estimation/finishing_cost_controller.dart';
import '../../../../config/res/app_color.dart';
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
                },
                secondButtonAction: () {
                  controller.convert();
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

