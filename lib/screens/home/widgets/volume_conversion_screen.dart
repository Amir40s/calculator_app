import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/utility/pdf_helper.dart';
import '../../../core/controller/calculators/conversion/volume_conversion_controller.dart';
import 'base_conversion_screen.dart';

class VolumeConversionScreen extends StatelessWidget {
  final String itemName;
  VolumeConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(VolumeConversionController());

  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Volume Value",
      buttonLabel: "Convert Volume",
      resultLabel: "Volume Conversion Results:",
      selectedUnit: controller.selectedVolumeUnit,
      availableUnits: controller.availableVolumeUnits,
      onValueChanged: controller.setVolumeValue,
      onUnitChanged: controller.setVolumeUnit,

      onConvert: controller.convertVolume,
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
            'Input': "${controller.inputVolumeValue.value} ${controller.selectedVolumeUnit.value}"
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
      },    );
  }
}
