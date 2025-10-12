import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';

class SoilCompactionController extends GetxController {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;

  // Text Controllers
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController depthController = TextEditingController();

  // Dropdown Observables
  final RxString selectedMaterial = ''.obs;
  final RxString selectedCompaction = ''.obs;
  final RxString selectedUnit = 'ft'.obs;

  // Dropdown Data
  final Map<String, List<double>> materialCompactionRanges = {
    'Sand': [1.10, 1.15],
    'Gravel': [1.10, 1.25],
    'Clay': [1.20, 1.40],
    'Crushed Stone': [1.15, 1.30],
    'Common Fill': [1.20, 1.35],
  };

  final RxList<String> compactionOptions = <String>[].obs;

  // Results
  final RxDouble compactedVolume = 0.0.obs;
  final RxDouble looseVolume = 0.0.obs;
  final RxString resultUnit = ''.obs;

  /// 🔹 Generate compaction options dynamically based on material
  void updateCompactionOptions(String material) {
    final range = materialCompactionRanges[material];
    if (range != null) {
      double start = range[0];
      double end = range[1];
      double step = (end - start) <= 0.1 ? 0.01 : 0.05;

      final values = <String>[];
      for (double i = start; i <= end + 0.0001; i += step) {
        values.add(i.toStringAsFixed(2));
      }
      compactionOptions.assignAll(values);
    } else {
      compactionOptions.clear();
    }
  }

  /// 🔹 Perform the soil compaction calculation
  Future<void> calculate() async {
    if (lengthController.text.isEmpty ||
        widthController.text.isEmpty ||
        depthController.text.isEmpty ||
        selectedMaterial.value.isEmpty ||
        selectedCompaction.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields correctly');
      return;
    }

    try {
      isLoading.value = true;

      double length = double.tryParse(lengthController.text) ?? 0;
      double width = double.tryParse(widthController.text) ?? 0;
      double depth = double.tryParse(depthController.text) ?? 0;
      double compactionFactor = double.tryParse(selectedCompaction.value) ?? 0;

      if (length <= 0 || width <= 0 || depth <= 0 || compactionFactor <= 0) {
        Get.snackbar('Error', 'Invalid numeric values');
        return;
      }

      final response = await _repo.calculateSoilCompaction(
        length: length.toString(),
        width: width.toString(),
        depth: depth.toString(),
        material: selectedMaterial.value.toLowerCase(),
        compactionFactor: compactionFactor.toString(),
        unit: selectedUnit.value,
      );
      if (response['success'] == true) {
        final results = response['results'];

        // ✅ Update observables properly
        compactedVolume.value = results['compactedVolume'] ?? 0.0;
        looseVolume.value = results['looseVolume'] ?? 0.0;
        resultUnit.value = results['unit'] ?? '';

        print('✅ Updated compactedVolume: ${compactedVolume.value}');
        print('✅ Updated looseVolume: ${looseVolume.value}');
      }
    } catch (e) {
      log("❌ Error: $e");
      Get.snackbar('Error', 'Something went wrong during calculation');
    } finally {
      isLoading.value = false;
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
