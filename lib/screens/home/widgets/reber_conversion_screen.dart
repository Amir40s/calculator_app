import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/calculators/conversion/force_conversion_controller.dart';
import '../../../core/controller/calculators/conversion/reber_conversion_controller.dart';
import 'base_conversion_screen.dart';

class RebarConversionScreen extends StatelessWidget {
  final String itemName;
  RebarConversionScreen({super.key, required this.itemName});

  final controller =  Get.put(RebarConversionController());


  @override
  Widget build(BuildContext context) {
    return BaseConversionScreen(
      itemName: itemName,
      controller: controller,
      inputLabel: "Enter Rebar Value",
      buttonLabel: "Convert Rebar",
      resultLabel: "Rebar Conversion Results:",
      selectedUnit: controller.selectedUnit,
      availableUnits: controller.availableUnits,
      onValueChanged: controller.setValue,
      onUnitChanged: controller.setUnit,
      onConvert: controller.convert,
    );
  }
}
