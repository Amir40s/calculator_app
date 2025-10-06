import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/calculators/conversion/area_conversion_controller.dart';
import '../../../core/controller/calculators/conversion/volume_conversion_controller.dart';
import 'base_conversion_screen.dart';

class AreaConversionScreen extends StatelessWidget {
  final String itemName;
  AreaConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(AreaConversionController());

  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Area Value",
      buttonLabel: "Convert Area",
      resultLabel: "Area Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convertArea,
    );
  }
}
