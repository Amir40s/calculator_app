import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/formula_widget.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/controller/calculators/door_windows/wood_moisture_content_controller.dart';

class WoodMoistureContentScreen extends StatelessWidget {
  final String itemName;
   WoodMoistureContentScreen({super.key, required this.itemName});

   final controller = Get.put(WoodMoistureContentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1.h,
              children: [
                AppTextWidget(
                  text: "Moisture Content Input",
                  styleType: StyleType.heading,
                ),
                AppTextWidget(
                  text: "Wood ",
                  styleType: StyleType.subHeading,
                ),
                AppTextField(hintText: "0",heading: "Wet Weight (g)",controller: controller.wetWeightController,),
                AppTextField(hintText: "0",heading: "Dry Weight (g)",controller: controller.dryWeightController,),
                SizedBox(height: 2.h,),
                AppButtonWidget(
                  text: "Calculate",
                    width: 100.w,
                    height: 5.h,
                    onPressed: () {
                    controller.convert();
                    },),
                SizedBox(height: 2.h,),
                Column(
                  spacing: 2.h,
                  children: [
                    Obx((){
                      if (controller.isLoading.value) {
                        return const Center(child: Loader());
                      }
                      final result = controller.result.value;

                      if (result == null) {
                        return  AppTextWidget(text: "No results yet. Enter Wood details and click Calculate");
                      }


                      return Column(
                        spacing: 1.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DynamicTable(headers: [
                            "Wood#",
                            "Wet Weight (g)",
                            "Dry Weight (g)",
                            "Moisture Content (%)",
                          ], rows: [
                            [
                              "1",
                              controller.wetWeightController.text,
                              controller.dryWeightController.text,
                              "$result %",
                            ],
                          ]),

                        ],
                      );
                    }),
                    FormulaWidget(text:
                    "Procedure for Moisture Content Testing \n Sample Collection: "
                        "\n For a wood piece like 2 × 8 × 8' long: The sample should be taken from the middle third of the"
                        " board, avoiding the ends and outer layers. The sample size should be approximately 2 cm × 2 cm"
                        " × 2 cm (or 20–50 grams). Sampling from the middle ensures that you get an average moisture "
                        "content that is not skewed by the faster drying at the ends or the outer layers."
                        " The moisture content near the surface will generally be lower due to exposure to air."
                        " \n Lab Oven Method: \n Weigh the wet sample (W₁) immediately after cutting it from the wood piece."
                        "\n Dry the sample in a preheated oven at 103–105°C (217–221°F) for 24 hours, or until the weight no longer changes."
                        "\n After drying, allow the sample to cool in a desiccator."
                        "\n Weigh the dry sample (W₂)."
                        "\n Calculate MC = [(W₁ - W₂) / W₂] × 100."
                        "\n Microwave Method: "
                        "\n Weigh the wet sample (W₁) immediately after cutting."
                        "\n Microwave at medium power (50–60%) in 30–40 second intervals."
                    "\nAfter each interval, remove and weigh the sample until weight stabilizes."
                    "\nFinal stable weight = dry weight (W₂)."
                    "\nCalculate MC = [(W₁ - W₂) / W₂] × 100."
                    "\n Why the Sample Location Matters: "
                        "\n Ensure you take the sample from the middle third of the wood piece, as this is where the moisture content is most representative of the entire wood. The ends and outer layers are typically drier, which may result in inaccurate moisture content readings. A sample size of approximately 2 × 2 × 2 cm (20–50 g) is ideal for both oven and microwave methods. This is small enough for effective drying, yet large enough to provide an accurate measurement.")
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
