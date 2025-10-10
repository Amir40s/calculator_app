import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/custom_ui_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';

import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/earth_work/back_fill_controller.dart';

class BackFillCalculatorScreen extends StatelessWidget {
  final String itemName;
   BackFillCalculatorScreen({super.key, required  this.itemName});
  final controller = Get.put(BackFillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: "Backfill Calculator",styleType: StyleType.heading,),  AppTextField(
                controller: controller.plotLengthController,
                hintText: "Enter length",
                heading: "Plot Length (X) in ft:",
              ),
              AppTextField(
                controller: controller.plotWidthController,
                hintText: "Enter width",
                heading: "Plot Width (Y) in ft:",
              ),
              AppTextField(
                controller: controller.depthController,
                hintText: "Enter depth",
                heading: "Foundation Depth (D) in ft:",
              ),
              AppTextField(
                controller: controller.totalConcreteController,
                hintText: "Enter concrete volume",
                heading: "Total Concrete Volume (ft³):",
              ),
              ReusableDropdown(
                selectedValue: controller.selectedMaterialType,
                itemsList: controller.materialType,
                hintText: "Select Material Type",
                onChangedCallback: (val) => controller.onMaterialTypeChanged(val),
              ),
              ReusableDropdown(
                selectedValue: controller.selectedTruckType,
                itemsList: controller.truckType,
                hintText: "Select Truck Type",
                onChangedCallback: (val) => controller.onTruckTypeChanged(val),
              ),
              AppButtonWidget(text: 'Calculate',width: 100.w,height: 5.h,
              onPressed: () {
                controller.convert();
              },
              ),
              SizedBox( height: 3.h,),
              Obx((){
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
          
                final data = controller.backFillCost.value;
          
                if (data == null) {
                  return const Center(
                    child: Text('No results yet. Enter values and calculate'),
                  );
                }
          
                final result = data.results;
                return Column(
                  children: [
                    DynamicTable(
                      headers: ["Description","Dimensions","Value"],
                      rows: [
                        [
                          "Adjusted Excavation Volume",
                          "${controller.plotLengthController.text} × ${controller.plotWidthController.text} × ${controller.depthController.text}",
                          result.excavationVolume.toStringAsFixed(1),
                        ], [
                          "Stone Soiling Volume (6' top layer)",
                          "--",
                          "${AppUtils().toRoundedDouble(result.stoneSoilingVolume)}",
                        ], [
                          "Compacted Backfill Volume",
                          "--",
                          "${AppUtils().toRoundedDouble(result.compactedBackfillVolume)}",
                        ], [
                          "Required Loose Fill Volume (95% AASHTO)",
                          "--",
                          "${AppUtils().toRoundedDouble(result.looseFillVolume)}",
                        ], [
                          "Estimated Trucks Required",
                          "--",
                          "${AppUtils().toRoundedDouble(result.numberOfTrucks.toStringAsFixed(0))} (${result.truckCapacity.toStringAsFixed(0)} ft each) ",
                        ],
                      ]
                    ),
                    SizedBox(height: 2.h,),
                    AppTextWidget(text: "Formulas: Adjusted Volume = (L)×(W)×D, Stone Soiling = (L)×(W)×0.5, Backfill = Adjusted Volume − Concrete − Stone Soiling, Loose Fill = Backfill × Compaction Factor",
                    styleType: StyleType.subTitle,
                      color: AppColors.greyColor,
                    ),                    SizedBox(height: 2.h,),

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
