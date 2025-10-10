import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/custom_ui_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/controller/calculators/earth_work/soil_compaction_controller.dart';

class SoilCompactionScreen extends StatelessWidget {
  final String itemName;
  SoilCompactionScreen({super.key, required this.itemName});

  final controller = Get.put(SoilCompactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: "Soil Compaction Calculator",
              styleType: StyleType.heading,
            ),
            SizedBox(height: 2.h),

            Obx(() {
              return Column(
                children: [
                  AppTextField(
                    hintText: 'Enter length',
                    heading:
                    "Length of Area (${controller.selectedUnit.value})",
                    controller: controller.lengthController,
                  ),
                  TwoFieldsWidget(
                    heading1: "Width (${controller.selectedUnit.value})",
                    heading2: "Depth (${controller.selectedUnit.value})",
                    controller1: controller.widthController,
                    controller2: controller.depthController,
                  ),
                ],
              );
            }),

            SizedBox(height: 2.h),

            // 🔹 Material Type Dropdown
            Obx(() {
              return ReactiveDropdown(
                heading: "Material Type",
                selectedValue: controller.selectedMaterial,
                itemsList:
                controller.materialCompactionRanges.keys.toList(),
                hintText: "Material Type",
                onChangedCallback: (val) {
                  controller.selectedMaterial.value = val;
                  controller.updateCompactionOptions(val);
                  controller.selectedCompaction.value = '';
                },
              );
            }),

            SizedBox(height: 2.h),

            // 🔹 Compaction Factor Dropdown
            Obx(() {
              return ReactiveDropdown(
                selectedValue: controller.selectedCompaction,
                itemsList: controller.compactionOptions.toList(),
                hintText: "Compaction Factor",
                heading: "Compaction Factor",
                onChangedCallback: (val) {
                  controller.selectedCompaction.value = val;
                },
              );
            }),

            SizedBox(height: 2.h),

            // 🔹 Unit Dropdown
            Obx(() {
              return ReactiveDropdown(
                selectedValue: controller.selectedUnit,
                itemsList: ['ft', 'm'],
                hintText: "Unit of Measurement",
                heading: "Unit of Measurement",
                onChangedCallback: (val) {
                  controller.selectedUnit.value = val;
                },
              );
            }),

            SizedBox(height: 3.h),

            // 🔹 Calculate Button
            AppButtonWidget(
              text: 'Calculate',
              width: 100.w,
              height: 6.h,
              onPressed: controller.calculate,
            ),

            SizedBox(height: 3.h),

            // 🔹 Result Section
            Obx(() {
              if (controller.compactedVolume.value == 0 &&
                  controller.looseVolume.value == 0) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DynamicTable(
                    headers: ["Description","Value"],
                    rows: [
                      [
                        "Compacted Volume" ,
                        "${controller.compactedVolume.value.toStringAsFixed(0)} ${controller.resultUnit.value}"
                      ],  [
                        "Loose Volume Required" ,
                        "${controller.looseVolume.value.toStringAsFixed(0)} ${controller.resultUnit.value}",
                      ],
                    ],
                  ),
                ],
              );
            }),
            SizedBox(height: 2.h,),
            AppTextWidget(text: "Formulas: Compacted Volume = L×W×D, Loose Volume = Compacted Volume × Compaction Factor",styleType: StyleType.subTitle,color: AppColors.greyColor,),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    );
  }
}
