import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/model/conversion_calculator/power_energy_model.dart';
import '../../../config/utility/pdf_helper.dart';
import '../../../core/controller/calculators/conversion/power_energy_controller.dart';
import 'base_conversion_screen.dart';

class PowerEnergyConversionScreen extends StatelessWidget {
  final String itemName;
  PowerEnergyConversionScreen({super.key, required this.itemName});

  final controller = Get.put(PowerEnergyConversionController());

  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Power and Energy Value",
      buttonLabel: "Convert Power/Energy",
      resultLabel: "Power/Energy Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convert,
      onDownload: () async {
        if (controller.data.value == null) {
          Get.snackbar("Error", "Please convert first before downloading PDF.");
          return;
        }

        final data = controller.data.value;
        final results =
            (data as dynamic).results as Map<String, PowerEnergyResult>?;

        if (results == null || results.isEmpty) {
          Get.snackbar("Error", "No results available to export.");
          return;
        }

        final List<List<String>> rows = results.entries.map((entry) {
          final result = entry.value;

          final RegExp regex = RegExp(r'^(.*)\s*\((.*)\)$');
          String name = result.name;
          String unitSymbol = '';

          final match = regex.firstMatch(result.name);
          if (match != null) {
            name = match.group(1) ?? result.name;
            unitSymbol = match.group(2) ?? '';
          }
          final valueStr =
              '${result.value.toStringAsFixed(0)} ${unitSymbol.isNotEmpty ? unitSymbol : ''}';

          return [name, valueStr.trim()];
        }).toList();

        await PdfHelper.generateAndOpenPdf(
          context: context,
          title: itemName,
          inputData: {
            'Input Value':
                "${controller.inputValue.value} (${controller.selectedUnit.value})"
          },
          headers: ['Unit', 'Value'],
          rows: rows,
          fileName: '$itemName.pdf',
        );
      },
    );
  }
}
