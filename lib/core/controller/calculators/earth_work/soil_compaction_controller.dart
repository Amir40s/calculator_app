import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoilCompactionController extends GetxController {
  // 🔹 Text controllers
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController depthController = TextEditingController();

  // 🔹 Dropdowns
  final RxString selectedMaterial = ''.obs;
  final RxString selectedCompaction = ''.obs;
  final RxString selectedUnit = 'ft'.obs;

  // 🔹 Dropdown data
  final Map<String, List<double>> materialCompactionRanges = {
    'Sand': [1.10, 1.15],
    'Gravel': [1.10, 1.25],
    'Clay': [1.20, 1.40],
    'Crushed Stone': [1.15, 1.30],
    'Common Fill': [1.20, 1.35],
  };

  RxList<String> compactionOptions = <String>[].obs;

  // 🔹 Result values
  final RxDouble compactedVolume = 0.0.obs;
  final RxDouble looseVolume = 0.0.obs;
  final RxString resultUnit = ''.obs;

  void updateCompactionOptions(String material) {
    final range = materialCompactionRanges[material];
    if (range != null) {
      double start = range[0];
      double end = range[1];
      double step = material == 'Sand' ? 0.01 : 0.05;

      List<String> values = [];
      for (double i = start;
      i <= end + 0.0001; // to handle floating precision
      i += step) {
        values.add(i.toStringAsFixed(2));
      }

      compactionOptions.value = values;
    }
  }

  void calculate() {
    try {
      final double length = double.parse(lengthController.text);
      final double width = double.parse(widthController.text);
      final double depth = double.parse(depthController.text);
      final double compaction = double.parse(selectedCompaction.value);

      final double compacted = length * width * depth;
      final double loose = compacted * compaction;

      compactedVolume.value = compacted;
      looseVolume.value = loose;
      resultUnit.value = selectedUnit.value == 'ft' ? 'ft³' : 'm³';

      log("✅ compactedVolume: $compactedVolume, looseVolume: $looseVolume");
    } catch (e) {
      log("❌ Error in calculate: $e");
      Get.snackbar('Error', 'Please enter valid inputs');
    }
  }

  @override
  void onClose() {
    lengthController.dispose();
    widthController.dispose();
    depthController.dispose();
    super.onClose();
  }
}
