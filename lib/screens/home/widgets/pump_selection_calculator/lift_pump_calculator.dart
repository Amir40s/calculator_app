import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/formula_widget.dart';
import 'package:smart_construction_calculator/core/component/result_box_widget.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 4.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 1.h,
          children: [
            AppTextWidget(text: "Pump Inputs", styleType: StyleType.heading),

            AppTextWidget(
                text: "Suction (UGT → Pump)",
                styleType: StyleType.dialogHeading),

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
            AppTextWidget(
                text: "Discharge (Pump → OHT)",
                styleType: StyleType.dialogHeading),

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
            AppTextWidget(
                text: "Tank Geometry & Volume",
                styleType: StyleType.dialogHeading),
            ReactiveDropdown(
              selectedValue: controller.selectedTankShape,
              itemsList: controller.tankShapeList,
              hintText: "Tank Shape",
              heading: "Tank Shape",
              onChangedCallback: (val) {
                controller.selectedTankShape.value = val;
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
            AppTextWidget(
                text: "Demand / Fill Objective",
                styleType: StyleType.dialogHeading),
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
                controller.selectedDesignStrategy.value = val;
              },
            ),
            AppTextField(
              hintText: "Manual Peak Draw (L/min, optional)",
              heading: "Manual Peak Draw (L/min, optional):",
              controller: controller.manualPeakDrawController,
            ),

            /// ====== Efficiencies ======
            AppTextWidget(
                text: "Efficiencies", styleType: StyleType.dialogHeading),
            ReactiveDropdown(
              selectedValue: controller.selectedSafetyFactor,
              itemsList: controller.safetyFactorList,
              hintText: "Safety Factor",
              heading: "Safety Factor",
              onChangedCallback: (val) {
                controller.selectedSafetyFactor.value = val;
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
            SizedBox(
              height: 2.h,
            ),
            AppButtonWidget(
              text: "Calculate",
              width: 100.w,
              height: 5.h,
              onPressed: () {
                controller.calculateLiftPump();
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                final results = controller.result.value;
                final result = results?.results;
                if (result == null) {
                  return Center(
                      child: Text(
                    "No data available",
                  ));
                }
                return Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: "Calculation Results",
                      styleType: StyleType.heading,
                    ),
                    AppTextWidget(
                      text: "Tank Volume & Drain Time:",
                      styleType: StyleType.dialogHeading,
                    ),
                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        [
                          "Tank Volume (L):",
                          "${result.tankVolumeDrainTime.tankVolumeL.toStringAsFixed(0)}"
                        ],
                        [
                          "Peak Draw Estimate (L/min):",
                          "${result.tankVolumeDrainTime.peakDrawEstimateLMin.toStringAsFixed(0)}"
                        ],
                        [
                          "Manual Peak Override (L/min):",
                          "${result.tankVolumeDrainTime.manualPeakOverrideLMin}"
                        ],
                        [
                          "Drain Time @ Peak (min): ",
                          "${result.tankVolumeDrainTime.drainTimeAtPeakMin.toStringAsFixed(0)}"
                        ],
                      ],
                    ),
                    AppTextWidget(
                      text: "Design Flow:",
                      styleType: StyleType.dialogHeading,
                    ),

                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        ["Strategy:", (result.designFlow.strategy)],
                        [
                          "Refill-Only Rate (L/min):",
                          ("${result.designFlow.refillOnlyRateLMin.toStringAsFixed(0)} (target ${(result.designFlow.refillTargetMin.toStringAsFixed(0))} min)")
                        ],
                        [
                          "Chosen Design Flow (L/min):",
                          "${result.designFlow.chosenDesignFlowLMin}"
                        ],
                      ],
                    ),                    SizedBox(height: 1.h,),

                    AppTextWidget(
                      text: "Heads:",
                      styleType: StyleType.dialogHeading,
                    ),

                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        [
                          "Static Suction Head (m):",
                          (result.heads.staticSuctionHeadM.toStringAsFixed(2))
                        ],
                        [
                          "Suction Friction (m):",
                          (result.heads.suctionFrictionM.toStringAsFixed(2))
                        ],
                        [
                          "Suction Minor Loss (m):",
                          (result.heads.suctionMinorLossM.toStringAsFixed(2))
                        ],
                        [
                          "Discharge Elevation (m):",
                          (result.heads.dischargeElevationM.toStringAsFixed(2))
                        ],
                        [
                          "Discharge Friction (m):",
                          (result.heads.dischargeFrictionM.toStringAsFixed(2))
                        ],
                        [
                          "Discharge Minor Loss (m):",
                          (result.heads.dischargeMinorLossM.toStringAsFixed(2))
                        ],
                        [
                          "Total Dynamic Head (m):",
                          (result.heads.totalDynamicHeadM.toStringAsFixed(2))
                        ],
                      ],
                    ),                    SizedBox(height: 1.h,),

                    AppTextWidget(
                      text: "Velocities:",
                      styleType: StyleType.dialogHeading,
                    ),

                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        [
                          "Suction Velocity (m/s):",
                          ("${result.velocities.suctionVelocityMS.toStringAsFixed(2)} (aim ${(result.velocities.suctionVelocityAim)})")
                        ],
                        [
                          "Discharge Velocity (m/s):",
                          ("${result.velocities.dischargeVelocityMS.toStringAsFixed(2)} (aim ${(result.velocities.dischargeVelocityAim)})")
                        ],
                      ],
                    ),                    SizedBox(height: 1.h,),

                    AppTextWidget(
                      text: "Power:",
                      styleType: StyleType.dialogHeading,
                    ),

                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        [
                          "Hydraulic Power (kW):",
                          ("${result.power.hydraulicPowerKW.toStringAsFixed(2)} ")
                        ],
                        [
                          "Motor Input Power:",
                          ("${result.power.motorInputPowerKW.toStringAsFixed(2)} (${(result.power.motorInputPowerHP)} HP)")
                        ],
                        [
                          "With Safety Factor ×1.25:",
                          ("${result.power.finalPowerHP.toStringAsFixed(2)} HP")
                        ],
                      ],
                    ),                    SizedBox(height: 1.h,),

                    FormulaWidget(
                        text:
                            "Assumptions:\n • Tank dimensions are entered in feet; converted to meters internally.\n  • TDH includes suction + discharge losses; both tanks are atmospheric (no pressure term).\n • Minor-loss K: suction (entry 0.5, elbow 0.9, valve/strainer 0.2, strainer 1.5), discharge (elbow 0.9, valve+tee 0.8, exit 1.0).\n • Darcy–Weisbach + Swamee–Jain; roughness values: uPVC/cPVC 0.0015 mm, PPR 0.007 mm, GI 0.150 mm.\n  • Match drain time strategy sets flow ≈ 2×peak draw to serve users + refill.")
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
