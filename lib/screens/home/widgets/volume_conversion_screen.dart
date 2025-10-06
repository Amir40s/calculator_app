import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    );
  }
}
