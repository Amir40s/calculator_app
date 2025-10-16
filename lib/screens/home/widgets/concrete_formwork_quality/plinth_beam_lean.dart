import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/res/app_color.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/plinth_beam_lean_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class PlinthBeamLeanScreen extends StatelessWidget {
  final String itemName;
  PlinthBeamLeanScreen({super.key, required this.itemName});
  final controller = Get.put(PlinthBeamLeanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: "Concrete Input", styleType: StyleType.heading),
              SizedBox(height: 1.h),

              for (int i = 0; i < controller.beam.length; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(text: "Beam ${i + 1}", styleType: StyleType.subHeading),
                    if (controller.beam.length > 1)
                      AppButtonWidget(
                        text: "Delete",
                        buttonColor: Colors.red,
                        radius: 2.w,
                        width: 20.w,
                        height: 3.h,
                        onPressed: () => controller.deleteBeam(i),
                      ),
                  ],
                ),
                TwoFieldsWidget(
                  heading1: "Grid",
                  heading2: "PB Tag",
                  hint: "name",
                  hint2: "tag",
                  controller1: controller.beam[i]['grid']!,
                  controller2: controller.beam[i]['tag']!,
                ),
                TwoFieldsWidget(
                  heading1: "Length (ft'in\")",
                  heading2: "Width (ft'in\")",
                  hint: "e.g., 4'6\"",
                  hint2: "e.g., 8'0\"",
                  controller1: controller.beam[i]['length']!,
                  controller2: controller.beam[i]['width']!,
                ),
                AppTextField(
                  hintText: "e.g., 8'0\"",
                  heading: "Height (ft'in\")",
                  controller: controller.beam[i]['height']!,
                ),
                AppTextWidget(
                  text: "Concrete Ratio (cement:sand:crush)",
                  styleType: StyleType.subHeading,
                ),
                Row(
                  children: [
                    Expanded(child: AppTextField(hintText: "0", controller: controller.beam[i]['cement']!)),
                    SizedBox(width: 1.w),
                    Expanded(child: AppTextField(hintText: "0", controller: controller.beam[i]['sand']!)),
                    SizedBox(width: 1.w),
                    Expanded(child: AppTextField(hintText: "0", controller: controller.beam[i]['crush']!)),
                  ],
                ),
                SizedBox(height: 2.h),
              ],

              AppButtonWidget(
                text: "+ Add Beam",
                width: 100.w,
                height: 5.h,
                onPressed: controller.addNewBeam,
              ),
              SizedBox(height: 1.h),

              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.calculate,
              ),
              SizedBox(height: 2.h),

              if (controller.isLoading.value)
                const Center(child: Loader())
              else
                _buildResults(controller),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildResults(PlinthBeamLeanController controller) {
    final res = controller.beamResult.value;
    if (res == null) {
      return AppTextWidget(
        color: AppColors.greyColor,
        text: "No results yet. Enter beam details and click Calculate.",
      );
    }

    final beams = res.beams ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(text: "Concrete Results", styleType: StyleType.heading),
        SizedBox(height: 1.h),
        for (int i = 0; i < beams.length; i++) ...[
          AppTextWidget(text: "Beam ${i + 1}", styleType: StyleType.subHeading),
          SizedBox(height: 1.h),
          DynamicTable(
            headers: ['Item', 'Value'],
            rows: [
              ['Grid', beams[i]?.grid ?? 'N/A'],
              ['PB Tag', beams[i]?.tag ?? 'N/A'],
              ['Volume (ft³)', beams[i].volFt3?.toStringAsFixed(2) ?? '0.00'],
              ['Cement Bags', beams[i].cementBags?.toStringAsFixed(2) ?? '0.00'],
              ['Sand Volume (ft³)', beams[i].sandVolume?.toStringAsFixed(2) ?? '0.00'],
              ['Crush Volume (ft³)', beams[i].crushVolume?.toStringAsFixed(2) ?? '0.00'],
              ['Water (L)', beams[i].waterLiter?.toStringAsFixed(2) ?? '0.00'],
            ],
          ),
          SizedBox(height: 2.h),
        ],
        AppTextWidget(text: "Summary", styleType: StyleType.subHeading),
        SizedBox(height: 1.h),
        DynamicTable(
          headers: ['Material', 'Quantity'],
          rows: [
            ['Cement (bags)', res.cementBags?.toStringAsFixed(0) ?? '0.00'],
            ['Sand (ft³)', res.sandVolume?.toStringAsFixed(0) ?? '0.00'],
            ['Crush (ft³)', res.crushVolume?.toStringAsFixed(0) ?? '0.00'],
            ['Water (liters)', res.waterLiter?.toStringAsFixed(0) ?? '0.00'],
          ],
        ),
        SizedBox(height: 2.h,),
      ],
    );
  }
}
