import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      onConvert: controller.convert,
    );
  }
}
