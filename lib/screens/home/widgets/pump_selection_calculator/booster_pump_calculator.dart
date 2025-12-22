import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/formula_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/pump_selection/booster_pump_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/dropdown_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/pump_selection/lift_pump_controller.dart';

class BoosterPumpCalculatorScreen extends StatelessWidget {
  final String itemName;
  const BoosterPumpCalculatorScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BoosterPumpController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 1.h,
          children: [
            AppTextWidget(text: "Pump Inputs", styleType: StyleType.heading),

            AppTextWidget(
                text: "Levels (Relative Distances)",
                styleType: StyleType.dialogHeading),
            AppTextField(
              hintText: "ft",
              heading: "Static Suction Head (ft):",
              controller: controller.staticSuctionHeadController,
            ),
            AppTextField(
              hintText: "ft",
              heading: "Discharge Elevation to Highest Fixture (ft):",
              controller: controller.dischargeElevationController,
            ),

            AppTextWidget(text: "Demand", styleType: StyleType.dialogHeading),
            TwoFieldsWidget(
              heading1: "Bathrooms",
              heading2: "Kitchens",
              controller1: controller.bathroomsController,
              controller2: controller.kitchensController,
            ),
            TwoFieldsWidget(
              heading1: "Washing Machines (count)",
              heading2: "Auto-Estimated Design Flow (L/min)",
              controller1: controller.washingMachinesController,
              controller2: controller.autoEstimateController,
            ),
            AppTextField(
              hintText: "Manual Peak Draw (L/min, optional)",
              heading: "Manual Peak Draw (L/min, optional):",
              controller: controller.manualPeakDrawController,
            ),

            AppTextWidget(
                text: "Discharge Piping", styleType: StyleType.dialogHeading),

            TwoFieldsWidget(
              heading1: "Straight Pipe Length (ft)",
              heading2: "Pipe Internal Diameter (in)",
              controller1: controller.straightPipeLController,
              controller2: controller.straightPipeDiameterController,
            ),
            ReactiveDropdown(
              selectedValue: controller.selectedDesignStrategy,
              itemsList: controller.suctionMaterialList,
              hintText: "Pipe Material Roughness",
              heading: "Pipe Material Roughness",
              onChangedCallback: (val) {
                controller.selectedDesignStrategy.value = val;
              },
            ),

            AppTextWidget(
                text: "Minor Losses", styleType: StyleType.dialogHeading),
            TwoFieldsWidget(
              heading1: "90° Elbows (count)",
              heading2: "Tees (through, count)",
              controller1: controller.elbowsController,
              controller2: controller.teesController,
            ),
            AppTextField(hintText: "Through Valves (gate/ball, count)",controller: controller.valvesController ,),
            ReactiveDropdown(
              selectedValue: controller.selectedEntryExitLoss,
              itemsList: controller.selectedEntryExitLossList,
              hintText: "Add Entry + Exit Losses?",
              heading: "Add Entry + Exit Losses?",
              onChangedCallback: (val) {
                controller.selectedEntryExitLoss.value = val;
              },
            ),

            AppTextWidget(
                text: "Targets & Efficiencies",
                styleType: StyleType.dialogHeading),

            AppTextField(
              hintText: "Desired Pressure at Fixtures",
              heading: "Desired Pressure at Fixtures:",
              controller: controller.desiredPressureController,
            ),
            AppTextField(
              hintText: "Pump Hydraulic Efficiency (%)",
              heading: "Pump Hydraulic Efficiency (%):",
              controller: controller.pumpHydraulicEfficiencyController,
            ),  AppTextField(
              hintText: "Motor Efficiency (%)",
              heading: "Motor Efficiency (%):",
              controller: controller.motorEfficiencyController,
            ),
            ReactiveDropdown(
              selectedValue: controller.selectedSafetyFactor,
              itemsList: controller.safetyFactorList,
              hintText: "Safety Factor",
              heading: "Safety Factor:",
              onChangedCallback: (val) {
                controller.selectedSafetyFactor.value = val;
              },
            ),
            AppTextField(
              hintText: "Water Temperature for Viscosity (°C)",
              heading: "Water Temperature for Viscosity (°C):",
              controller: controller.waterTemperatureController,
            ),
            SizedBox(
              height: 2.h,
            ),
            AppButtonWidget(
              text: "Calculate",
              width: 100.w,
              height: 5.h,
              onPressed: () {
                controller.calculatePump();
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
                final results = controller.result.value;
                final result = results?.results;
                final hydro = result?.hydraulics;
                final power = result?.power;

                if (result == null) {
                  Get.snackbar("No results yet","Enter pump parameters and click Calculate.");
                  return;
                }

                await PdfHelper.generateAndOpenPdf(
                  context: context,
                  title: "Booster Pump Calculation Report",
                  inputData: {
                    "Pipe Material": "${controller.selectedDesignStrategy.value}",
                    "Safety Factor": "${controller.selectedSafetyFactor.value}",
                    "Entry/Exit Loss": "${controller.selectedEntryExitLoss.value}",
                  },
                  tables: [
                    {
                      'title': "Hydraulics Summary",
                      'headers': ["Parameter", "Value"],
                      'rows': [
                        ["Design Flow (L/min)", "${hydro?.designFlowLMin.toStringAsFixed(0)}"],
                        ["Velocity (m/s)", "${hydro?.velocityMS.toStringAsFixed(2)} (${hydro?.velocityStatus})"],
                        ["Reynolds Number", "${hydro?.reynoldsNumber.toStringAsFixed(0)}"],
                        ["Friction Factor (f)", "${hydro?.frictionFactorF.toStringAsFixed(2)}"],
                        ["Static Suction Head (m)", "${hydro?.staticSuctionHeadM.toStringAsFixed(2)}"],
                        ["Discharge Elevation (m)", "${hydro?.dischargeElevationM.toStringAsFixed(2)}"],
                        ["Major Loss (m)", "${hydro?.majorLossFrictionM.toStringAsFixed(2)}"],
                        ["Minor Loss (m)", "${hydro?.minorLossFittingsM.toStringAsFixed(2)}"],
                        ["Desired Pressure Head (m)", "${hydro?.desiredPressureHeadM.toStringAsFixed(2)}"],
                        ["Total Head (TDH) (m)", "${hydro?.totalHeadTDHM.toStringAsFixed(2)}"],
                      ],
                    },
                    {
                      'title': "Power Summary",
                      'headers': ["Parameter", "Value"],
                      'rows': [
                        ["Hydraulic Power (kW)", "${power?.hydraulicPowerKW.toStringAsFixed(2)}"],
                        ["Motor Input Power (kW)", "${power?.motorInputPowerKW.toStringAsFixed(2)} (${power?.motorInputPowerHP.toStringAsFixed(2)} HP)"],
                        ["With Safety Factor ×1.25", "${power?.finalPowerHP.toStringAsFixed(2)} HP"],
                        ["Suggested Motor Size (HP)", "${power?.suggestedMotorSizeHP.toStringAsFixed(2)} HP"],
                      ],
                    },
                  ],
                  fileName: "booster_pump_report.pdf",
                );
              },
            ),


            SizedBox(
              height: 2.h,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: Loader());
              } else {
                final results = controller.result.value;
                final result = results?.results;
                final hydro = result?.hydraulics;
                if (result == null) {
                  return Center(
                      child: AppTextWidget(text:
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
                      text: "Hydraulics:",
                      styleType: StyleType.dialogHeading,
                    ),
                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        [
                          "Design Flow (L/min):",
                          ("${hydro?.designFlowLMin.toStringAsFixed(0)} ")
                        ],
                        [
                          "Velocity (m/s):",
                          ("${result.hydraulics.velocityMS.toStringAsFixed(2)} ${(result.hydraulics.velocityStatus)}")
                        ],
                        [
                          "Reynolds Number:",
                          ("${result.hydraulics.reynoldsNumber.toStringAsFixed(0)}")
                        ],
                        [
                          "Friction Factor (f)",
                          ("${result.hydraulics.frictionFactorF.toStringAsFixed(2)}")
                        ], [
                          "Static Suction Head (m):",
                          ("${result.hydraulics.staticSuctionHeadM.toStringAsFixed(2)}")
                        ], [
                          "Discharge Elevation (m):",
                          ("${result.hydraulics.dischargeElevationM.toStringAsFixed(2)}")
                        ], [
                          "Major Loss (friction) (m):",
                          ("${result.hydraulics.majorLossFrictionM.toStringAsFixed(2)}")
                        ],
                        [
                          "Minor Loss (fittings) (m):",
                          ("${result.hydraulics.minorLossFittingsM.toStringAsFixed(2)}")
                        ],[
                          "Desired Pressure Head (m):",
                          ("${result.hydraulics.desiredPressureHeadM.toStringAsFixed(2)}")
                        ],[
                          "Total Head (TDH) (m): ",
                          ("${result.hydraulics.totalHeadTDHM.toStringAsFixed(2)}")
                        ],
                      ],
                    ), AppTextWidget(
                      text: "Power:",
                      styleType: StyleType.dialogHeading,
                    ),
                    DynamicTable(
                      headers: ["Description", "Value"],
                      rows: [
                        [
                          "Hydraulic Power (kW):",
                          ("${result.power.finalPowerHP.toStringAsFixed(2)} ")
                        ],
                        [
                          "Motor Input Power:",
                          ("${result.power.motorInputPowerKW.toStringAsFixed(2)} (${(result.power.motorInputPowerHP)} HP)")
                        ],
                        [
                          "With Safety Factor ×1.25:",
                          ("${result.power.finalPowerHP.toStringAsFixed(2)} HP")
                        ],  [
                          "Suggested Motor Size (HP):",
                          ("${result.power.suggestedMotorSizeHP.toStringAsFixed(2)} HP")
                        ],
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    FormulaWidget(
                        text:
                            "Assumptions:\n"
                                " • TDH = (discharge elevation) + (losses) + (desired pressure head) − (static suction head)\n  "
                                "• Minor-loss K: elbow 0.9, valve 0.2, tee 0.6, entry 0.5, exit 1.0.\n "
                                "• Darcy–Weisbach + Swamee–Jain; roughness for uPVC/cPVC = 0.002 mm.\n "
                                "• Materials: uPVC/cPVC, PPR, GI (GI roughness assumes new/clean).\n"
                                "• Verify pump curve meets (43 L/min, 39 m) at operating point.")
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
