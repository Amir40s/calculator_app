import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/calculators/conversion/concrete_mix_controller.dart';
import '../../../config/utility/pdf_helper.dart';
import 'base_conversion_screen.dart';

class ConcreteMixConversionScreen extends StatelessWidget {
  final String itemName;
  ConcreteMixConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(ConcreteConversionController());


  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Concrete Value",
      buttonLabel: "Convert Concrete",
      resultLabel: "Concrete Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged:  controller.setUnit,
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
            'Mix Ratio': " (${controller.selectedUnit.value}) Volume ${controller.inputValue.value}"
          },
          headers: ['Unit', 'Value'],
          rows: rows,
          fileName: '$itemName.pdf',
        );
      },


    );
  }
}
