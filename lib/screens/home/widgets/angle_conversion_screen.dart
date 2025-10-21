import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/utility/pdf_helper.dart';
import '../../../core/controller/calculators/conversion/angle_conversion_controller.dart';
import 'base_conversion_screen.dart';

class AngleConversionScreen extends StatelessWidget {
  final String itemName;
  AngleConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(AngleConversionController());


  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Angle Value",
      buttonLabel: "Convert Angle",
      resultLabel: "Angle Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convert,       onDownload: () async {
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
