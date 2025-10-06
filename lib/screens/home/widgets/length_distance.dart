import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/controller/calculators/conversion/conversion_controller.dart';
import 'base_conversion_screen.dart';

class LengthConversionScreen extends StatelessWidget {
  final String itemName;
  LengthConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(ConversionController());

  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
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
    );
  }
}
