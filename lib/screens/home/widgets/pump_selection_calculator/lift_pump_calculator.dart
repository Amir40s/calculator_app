import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import '../../../../core/component/dropdown_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/pump_selection/lift_pump_controller.dart';

class LiftPumpCalculatorScreen extends StatelessWidget {
  final String itemName;
  const LiftPumpCalculatorScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiftPumpController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 1.h,
          children: [
            AppTextWidget(text: "Pump Inputs", styleType: StyleType.heading),

            /// ====== Suction Section ======
            AppTextWidget(text: "Suction (UGT → Pump)", styleType: StyleType.dialogHeading),

            TwoFieldsWidget(
              heading1: "Static Suction Head (ft)",
              heading2: "Static Suction Length (ft)",
              controller1: controller.staticSuctionHeadController,
              controller2: controller.staticSuctionLengthController,
            ),

            ReactiveDropdown(
              selectedValue: controller.selectedSuctionMaterial,
              itemsList: controller.suctionMaterialList,
              hintText: "Suction Material",
              heading: "Suction Material",
              onChangedCallback: (val) {
                controller.selectedSuctionMaterial.value;
              },
            ),
            TwoFieldsWidget(
              heading1: "Suction Diameter (in)",
              heading2: "Suction Elbows (count)",
              controller1: controller.suctionDiameterController,
              controller2: controller.suctionElbowsController,
            ),
            AppTextField(
              hintText: "Suction Valves/Strainer (count)",
              heading: "Suction Valves/Strainer (count):",
              controller: controller.suctionValvesController,
            ),

            /// ====== Discharge Section ======
            AppTextWidget(text: "Discharge (Pump → OHT)", styleType: StyleType.dialogHeading),

             ReactiveDropdown(
              selectedValue: controller.selectedDischargeMaterial,
              itemsList: controller.dischargeMaterialList,
              hintText: "Discharge Material",
              heading: "Discharge Material",
              onChangedCallback: (val) {
                controller.selectedDischargeMaterial.value;
              },
            ),

            AppTextField(
              hintText: "Discharge Elevation to OHT Water Level (ft)",
              heading: "Discharge Elevation to OHT Water Level (ft):",
              controller: controller.dischargeElevationController,
            ),
            AppTextField(
              hintText: "Discharge Pipe Length (ft)",
              heading: "Discharge Pipe Length (ft):",
              controller: controller.dischargePipeLengthController,
            ),

            TwoFieldsWidget(
              heading1: "Discharge Diameter (in)",
              heading2: "Discharge Elbows (count)",
              controller1: controller.dischargeDiameterController,
              controller2: controller.dischargeElbowsController,
            ),
            AppTextField(
              hintText: "Discharge Valves/Tees (count)",
              heading: "Discharge Valves/Tees (count):",
              controller: controller.dischargeValvesController,
            ),

            /// ====== Tank Geometry ======
            AppTextWidget(text: "Tank Geometry & Volume", styleType: StyleType.dialogHeading),
            ReactiveDropdown(
              selectedValue: controller.selectedTankShape,
              itemsList: controller.tankShapeList,
              hintText: "Tank Shape",
              heading: "Tank Shape",
              onChangedCallback: (val) {
                controller.selectedTankShape.value = val!;
              },
            ),

            TwoFieldsWidget(
              heading1: "Internal Length (ft)",
              heading2: "Internal Width (ft)",
              controller1: controller.internalLengthController,
              controller2: controller.internalWidthController,
            ),
            AppTextField(
              hintText: "Internal Water Height (ft)",
              heading: "Internal Water Height (ft):",
              controller: controller.internalWaterHeightController,
            ),

            /// ====== Demand / Fill Objective ======
            AppTextWidget(text: "Demand / Fill Objective", styleType: StyleType.dialogHeading),
            TwoFieldsWidget(
              heading1: "Bathrooms",
              heading2: "Kitchens",
              controller1: controller.bathroomsController,
              controller2: controller.kitchensController,
            ),
            TwoFieldsWidget(
              heading1: "Washing Machines",
              heading2: "Target Refill Time (min)",
              controller1: controller.washingMachinesController,
              controller2: controller.targetRefillTimeController,
            ),

             ReactiveDropdown(
              selectedValue: controller.selectedDesignStrategy,
              itemsList: controller.designStrategyList,
              hintText: "Design Strategy",
              heading: "Design Strategy",
              onChangedCallback: (val) {
                controller.selectedDesignStrategy.value = val!;
              },
            ),
            AppTextField(
              hintText: "Manual Peak Draw (L/min, optional)",
              heading: "Manual Peak Draw (L/min, optional):",
              controller: controller.manualPeakDrawController,
            ),

            /// ====== Efficiencies ======
            AppTextWidget(text: "Efficiencies", styleType: StyleType.dialogHeading),
            ReactiveDropdown(
              selectedValue:  controller.selectedSafetyFactor,
              itemsList: controller.safetyFactorList,
              hintText: "Safety Factor",
              heading: "Safety Factor",
              onChangedCallback: (val) {
                controller.selectedSafetyFactor.value = val!;
              },
            ),
            AppTextField(
              hintText: "Pump Hydraulic Efficiency (%)",
              heading: "Pump Hydraulic Efficiency (%):",
              controller: controller.pumpHydraulicEfficiencyController,
            ),
            AppTextField(
              hintText: "Motor Efficiency (%)",
              heading: "Motor Efficiency (%):",
              controller: controller.motorEfficiencyController,
            ),
            SizedBox(height: 2.h,),
            AppButtonWidget(text: "Calculate",width: 100.w,height: 5.h,onPressed: () {
              controller.calculateLiftPump();
            },),
            SizedBox(height: 2.h,),
            Obx((){
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                final results = controller.result.value;
                final result = results?.results;
                // Check if the result is null or if the required data is empty
                if (result == null ) {
                  return Center(
                      child: Text(
                        "No data available",
                      ));
                }
               return  Column(
                 children: [
                   AppTextWidget(text: "Calculation Results",styleType: StyleType.heading,),
                   DynamicTable(
                     headers: ["Description","Value"],
                     rows: [
                       [
                         "Tank Volume (L):" ,
                         "${result.tankVolume}"
                       ],  [
                         "Peak Draw Estimate (L/min):" ,
                         "${result.peakDrawEst}"

                       ], [
                         "Manual Peak Override (L/min):" ,
                         "${result.peakDrawManual}"

                       ], [
                         "Drain Time @ Peak (min): " ,
                         "${result.drainTime}"

                       ],
                     ],
                   ),
                 ],
               );
            }}),

          ],
        ),
      ),
    );
  }
}
