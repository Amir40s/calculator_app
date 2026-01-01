import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/enum/style_type.dart';
import '../../../../config/res/app_color.dart';
import '../../../../config/utility/pdf_helper.dart';
import '../../../../core/component/app_button_widget.dart';
import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/app_text_widget.dart';
import '../../../../core/component/dropdown_widget.dart';
import '../../../../core/component/dynamic_table_widget.dart';
import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/concrete_formwork_quantity_controller/foundation_formwork_concrete_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class FoundationFormworkConcreteScreen extends StatelessWidget {
  final String itemName;
  FoundationFormworkConcreteScreen({super.key, required this.itemName});

  final controller = Get.put(FoundationFormworkConcreteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Obx(() {
          return Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                  text: "Foundation Inputs", styleType: StyleType.heading),
              SizedBox(height: 1.h),
              for (int i = 0; i < controller.foundations.length; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: "Foundation ${i + 1}",
                      styleType: StyleType.dialogHeading,
                    ),
                    if (controller.foundations.length > 1)
                      AppButtonWidget(
                        text: "Delete",
                        buttonColor: Colors.red,
                        radius: 2.w,
                        width: 20.w,
                        height: 3.h,
                        onPressed: () => controller.deleteColumn(i),
                      ),
                  ],
                ),
                TwoFieldsWidget(
                  heading1: "Tag",
                  heading2: "Width (ft'in\")",
                  hint: "tag",
                  hint2: "e.g., 8'0\"",
                  keyboardType: TextInputType.numberWithOptions(),
                  keyboardType2: TextInputType.numberWithOptions(),
                  controller1: controller.foundations[i]['tag']!,
                  controller2: controller.foundations[i]['width']!,
                ),
                TwoFieldsWidget(
                  heading1: "Depth (ft'in\")",
                  heading2: "Length (ft'in\")",
                  hint: "e.g., 4'6\"",
                  hint2: "e.g., 8'0\"",
                  keyboardType: TextInputType.numberWithOptions(),
                  keyboardType2: TextInputType.numberWithOptions(),
                  controller1: controller.foundations[i]['depth']!,
                  controller2: controller.foundations[i]['height']!,
                ),
                ReactiveDropdown(
                  heading: "Type",
                  selectedValue: controller.selectedTypes[i],
                  itemsList: controller.columnTypes,
                  hintText: "Select Type",
                  onChangedCallback: (value) {
                    controller.onTypeChange(i, value);
                  },
                ),

                if (controller.selectedTypes[i].value == "CF" ) ...[
                  SizedBox(height: 1.h),
                  TwoFieldsWidget(
                    heading1: "AddOn Length (ft'in\")",
                    heading2: "AddOn Width (ft'in\")",
                    hint: "e.g.u, 4'6\"",
                    hint2: "e.g., 8'0\"",
                    keyboardType: TextInputType.numberWithOptions(),
                    keyboardType2: TextInputType.numberWithOptions(),
                    controller1: controller.foundations[i]['addOnLength'] ?? TextEditingController(),
                    controller2: controller.foundations[i]['addOnWidth'] ?? TextEditingController(),
                  ),

                ],

                AppTextField(
                  heading: "Quantity",
                  hintText: "0",
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: controller.foundations[i]['quantity']!,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        heading: "Cement",
                        hintText: "0",
                        keyboardType: TextInputType.numberWithOptions(),

                        controller: controller.foundations[i]['cement']!,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: AppTextField(
                        heading: "Sand",
                        hintText: "0",                  keyboardType: TextInputType.numberWithOptions(),

                        controller: controller.foundations[i]['sand']!,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: AppTextField(
                        heading: "Crush",
                        hintText: "0",                  keyboardType: TextInputType.numberWithOptions(),

                        controller: controller.foundations[i]['crush']!,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
              AppButtonWidget(
                text: "+ Add Columns",
                width: 100.w,
                height: 5.h,
                onPressed: controller.addNewColumn,
              ),
              SizedBox(height: 1.h),
              AppButtonWidget(
                text: "Calculate",
                width: 100.w,
                height: 5.h,
                onPressed: controller.calculate,
              ),
              SizedBox(height: 1.h),

              AppButtonWidget(
                text: "Download PDF",
                width: 100.w,
                height: 5.h,
                onPressed: () async {
                  final res = controller.subStructureResult.value;

                  if (res == null) {
                    Get.snackbar("Error", "Please calculate results first.");
                    return;
                  }

                  final entry = res.entries ?? [];

                  final List<Map<String, dynamic>> pdfTables = [];

                  for (int i = 0; i < entry.length; i++) {
                    final e = entry[i];
                    pdfTables.add({
                      'title': 'Column ${i + 1} (${e.tag ?? "N/A"})',
                      'headers': ['Item', 'Value'],
                      'rows': [
                        ['Tag', e.tag ?? 'N/A'],
                        ['Type', e.type ?? 'N/A'],
                        ['Volume (ft³)', e.volume.toStringAsFixed(2) ?? 'N/A'],
                        ['Formwork (ft²)', e.formwork.toStringAsFixed(2) ?? 'N/A'],
                        ['Cement Bags', e.cementBags.toStringAsFixed(2) ?? 'N/A'],
                        ['Sand Volume (ft³)', e.sandVolume.toStringAsFixed(2) ?? 'N/A'],
                        ['Crush Volume (ft³)', e.crushVolume.toStringAsFixed(2) ?? 'N/A'],
                      ],
                    });
                  }

                  // Add summary table
                  pdfTables.add({
                    'title': 'Summary',
                    'headers': ['Item', 'Quantity'],
                    'rows': [
                      ['Total Volume (ft³)', res.totalVolume.toStringAsFixed(2) ?? '0'],
                      ['Total Formwork (ft²)', res.totalFormwork.toStringAsFixed(2) ?? '0'],
                      ['Cement (bags)', res.cementBags.toStringAsFixed(2) ?? '0'],
                      ['Sand (ft³)', res.sandVolume.toStringAsFixed(2) ?? '0'],
                      ['Crush (ft³)', res.crushVolume.toStringAsFixed(2) ?? '0'],
                      ['Water (liters)', res.waterLiters.toStringAsFixed(2) ?? '0'],
                    ],
                  });

                  await PdfHelper.generateAndOpenPdf(
                    context: context,
                    title: itemName,
                    inputData: {},
                    tables: pdfTables,
                  );
                },
              ),
              SizedBox(height: 2.h),
              Obx((){
                if(controller.isLoading.value){
                  return const Center(child: Loader());
                }
                final res = controller.subStructureResult.value;

                if(controller.subStructureResult.value == null){
                  return AppTextWidget(
                    color: AppColors.greyColor,
                    text: "No results yet. Enter column details and click Calculate.",
                  );

                }
                final entry = res?.entries ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1.h,
                  children: [

                    AppTextWidget(text: "Concrete Results", styleType: StyleType.heading),
                    SizedBox(height: 1.h),
                    for (int i = 0; i < entry.length; i++) ...[
                      AppTextWidget(text: "Column ${i + 1}", styleType: StyleType.subHeading),
                      SizedBox(height: 1.h),
                      DynamicTable(
                        headers: ['Item', 'Value'],
                        rows: [
                          ['Tag', entry[i].tag ?? 'N/A'],
                          ['Type', entry[i].type ?? 'N/A'],
                          ['Volume (ft³)', entry[i].volume.toStringAsFixed(2) ?? 'N/A'],
                          ['Formwork (ft²)', entry[i].formwork.toStringAsFixed(2) ?? 'N/A'],
                          ['Cement bags', entry[i].cementBags.toStringAsFixed(2) ?? 'N/A'],
                          ['Sand volume (ft³)', entry[i].sandVolume.toStringAsFixed(2) ?? 'N/A'],
                          ['Crush Volume (ft³)', entry[i].crushVolume.toStringAsFixed(2) ?? 'N/A'],
                        ],
                      ),
                      SizedBox(height: 2.h),


                    ],
                    AppTextWidget(text: "Summary", styleType: StyleType.subHeading),
                    SizedBox(height: 1.h),
                    DynamicTable(
                      headers: ['Item', 'Quantity'],
                      rows: [
                        ['Total Volume (ft³)	', res?.totalVolume.toStringAsFixed(0) ?? '0'],
                        ['Total Formwork (ft²)', res?.totalFormwork.toStringAsFixed(0) ?? '0'],
                        ['Cement (bags)', res?.cementBags.toStringAsFixed(0) ?? '0'],
                        ['Sand (ft³)', res?.sandVolume.toStringAsFixed(0) ?? '0'],
                        ['Crush (ft³)', res?.crushVolume.toStringAsFixed(0) ?? '0'],
                        ['Water (liters)', res?.waterLiters.toStringAsFixed(0) ?? '0'],
                      ],),
                    SizedBox(height: 2.h),
                  ],
                );
              })
            ],
          );
        }),
      ),
    );
  }
}