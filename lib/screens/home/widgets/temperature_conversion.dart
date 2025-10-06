import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/calculators/conversion/temperature_convertion_controller.dart';
import 'base_conversion_screen.dart';

class TemperatureConversionScreen extends StatelessWidget {
  final String itemName;
  TemperatureConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(TemperatureConversionController());


  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Temperature Value",
      buttonLabel: "Convert Temperature",
      resultLabel: "Temperature Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convertTemperature,
    );
  }
}
