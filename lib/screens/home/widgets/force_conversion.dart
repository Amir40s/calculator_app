import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/calculators/conversion/force_conversion_controller.dart';
import 'base_conversion_screen.dart';

class ForceConversionScreen extends StatelessWidget {
  final String itemName;
  ForceConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(ForceConversionController());


  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Force Value",
      buttonLabel: "Convert Force",
      resultLabel: "Force Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convert,
    );
  }
}
