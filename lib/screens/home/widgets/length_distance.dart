import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../config/utility/pdf_helper.dart';
import '../../../core/controller/calculators/conversion/conversion_controller.dart';
import 'base_conversion_screen.dart';

class LengthConversionScreen extends StatelessWidget {
  final String itemName;
  LengthConversionScreen({super.key, required this.itemName});

  final controller = Get.put(ConversionController());

  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen<ConversionController>(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Length Value",
      buttonLabel: "Convert Length",
      resultLabel: "Length Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convertLength,
      onDownload: () async {
        if (controller.data.value == null) {
          Get.snackbar("Error", "Please convert first before downloading PDF.");
          return;
        }

        final conversions = (controller.data.value!.conversions);

        final rows = conversions.entries
            .map((e) => [e.key.toString(), e.value.toString()])
            .toList();

        await PdfHelper.generateAndOpenPdf(
          context: context,
          title: itemName,
          inputData: {
            'Input': "${controller.inputValue.value} ${controller.selectedUnit.value}"
          },
          tables: [
            {
              'title': 'Conversion Results',
              'headers': ['Unit', 'Value'],
              'rows': rows,
            },
          ],
          fileName: '${itemName}.pdf',
        );
      },
    );
  }
}
