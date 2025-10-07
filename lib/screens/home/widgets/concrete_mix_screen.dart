import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/calculators/conversion/concrete_mix_controller.dart';
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
    );
  }
}
