import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/utility/pdf_helper.dart';
import '../../../core/controller/calculators/conversion/reber_conversion_controller.dart';
import 'base_conversion_screen.dart';

class RebarConversionScreen extends StatelessWidget {
  final String itemName;
  RebarConversionScreen({super.key, required this.itemName});

  final controller = Get.put(RebarConversionController());

  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Rebar Value",
      buttonLabel: "Convert Rebar",
      resultLabel: "Rebar Conversion Results:",
      selectedUnit: controller.selectedInput,
      selectedUnit2: controller.selectedInput2,
      availableUnits: controller.inputType,
      availableUnits2: controller.inputType2,
      controller2: controller.customDiameterController,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convert,
      onDownload: () async {
        if (controller.data.value == null) {
          Get.snackbar("Error", "Please convert first before downloading PDF.");
          return;
        }

        final conversions = controller.data.value!.conversions;
        final List<List<String>> rows = conversions.entries
            .map((e) => [e.key.toString(), (e.value as num).toStringAsFixed(0)])
            .toList();


        await PdfHelper.generateAndOpenPdf(
          context: context,
          title: itemName,
          inputData: {
            'Input': "${controller.inputValue.value} ${controller.selectedInput.value}"
          },
          headers: ['Unit', 'Value'],
          rows: rows,
          fileName: '$itemName.pdf',
        );
      },
    );
  }
}
