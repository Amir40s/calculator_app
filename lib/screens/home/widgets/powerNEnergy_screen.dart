import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/calculators/conversion/power_energy_controller.dart';
import 'base_conversion_screen.dart';

class PowerEnergyConversionScreen extends StatelessWidget {
  final String itemName;
  PowerEnergyConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(PowerEnergyConversionController());


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
      onUnitChanged:  controller.setUnit,
      onConvert: controller.convert,
    );
  }
}
