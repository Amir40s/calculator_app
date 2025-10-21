import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/calculators/conversion/area_conversion_controller.dart';
import '../../../config/utility/pdf_helper.dart';
import '../../../core/controller/calculators/conversion/volume_conversion_controller.dart';
import 'base_conversion_screen.dart';

class AreaConversionScreen extends StatelessWidget {
  final String itemName;
  AreaConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(AreaConversionController());

  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Area Value",
      buttonLabel: "Convert Area",
      resultLabel: "Area Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,

      onConvert: controller.convertArea,
      onDownload: () async {
        if (controller.data.value == null) {
          Get.snackbar("Error", "Please convert first before downloading PDF.");
          return;
        }

        final conversions = (controller.data.value!.conversions);

        final List<List<String>> rows = conversions.entries
            .map((e) => [e.key.toString(), e.value.toString()])
            .toList();

        await PdfHelper.generateAndOpenPdf(
          context: context,
          title: itemName,
          inputData: {
            'Input': "${controller.inputValue.value} ${controller.selectedUnit.value}"
          },
          headers: ['Unit', 'Value'],
          rows: rows,
          fileName: '$itemName.pdf',
        );
      },

    );
  }
}
