import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';

class SoilCompactionController extends GetxController {
  final _repo = CalculatorRepository();

  // Loading state
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

  // 🔹 Cache last calculated values to avoid redundant API calls
  String _lastInputKey = '';

  /// 🔹 Generate compaction factor list (e.g., 1.10 → 1.15 → [1.10, 1.11, 1.12, ...])
  void updateCompactionOptions(String material) {
    final range = materialCompactionRanges[material];
    if (range == null) {
      compactionOptions.clear();
      selectedCompaction.value = '';
      return;
    }

    final start = range[0];
    final end = range[1];
    final step = (end - start) <= 0.1 ? 0.01 : 0.05;

    final values = <String>[];
    for (double i = start; i <= end + 0.0001; i += step) {
      values.add(i.toStringAsFixed(2));
    }

    compactionOptions.assignAll(values);

    // 🔹 Automatically select the average value for convenience
    final avg = ((start + end) / 2).toStringAsFixed(2);
    selectedCompaction.value = avg;
    log("🔸 Updated compaction options for $material: $values | Default: $avg");
  }

  /// 🔹 Perform soil compaction calculation via API
  Future<void> calculate() async {
    if (lengthController.text.isEmpty ||
        widthController.text.isEmpty ||
        depthController.text.isEmpty ||
        selectedMaterial.value.isEmpty ||
        selectedCompaction.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields correctly');
      return;
    }

    final length = double.tryParse(lengthController.text) ?? 0;
    final width = double.tryParse(widthController.text) ?? 0;
    final depth = double.tryParse(depthController.text) ?? 0;
    final compactionFactor = double.tryParse(selectedCompaction.value) ?? 0;

    if (length <= 0 || width <= 0 || depth <= 0 || compactionFactor <= 0) {
      Get.snackbar('Error', 'Invalid numeric values');
      return;
    }

    // 🔹 Create a unique key for caching (optional)
    final currentKey =
        '$length-$width-$depth-${selectedMaterial.value}-${selectedCompaction.value}-${selectedUnit.value}';
    if (currentKey == _lastInputKey) {
      log("🟡 Skipping API call (same input as last time)");
      return;
    }

    try {
      isLoading.value = true;

      final response = await _repo.calculateSoilCompaction(
        length: length.toString(),
        width: width.toString(),
        depth: depth.toString(),
        material: selectedMaterial.value.toLowerCase(),
        compactionFactor: compactionFactor.toString(),
        unit: selectedUnit.value,
      );

      if (response['success'] == true && response['results'] != null) {
        final results = response['results'];

        compactedVolume.value = (results['compactedVolume'] ?? 0.0).toDouble();
        looseVolume.value = (results['looseVolume'] ?? 0.0).toDouble();
        resultUnit.value = results['unit'] ?? selectedUnit.value;

        _lastInputKey = currentKey;

        log("✅ Updated compactedVolume: ${compactedVolume.value}");
        log("✅ Updated looseVolume: ${looseVolume.value}");
      } else {
        Get.snackbar('Error', 'Invalid response from server.');
      }
    } catch (e, st) {
      log("❌ Error in calculate(): $e\n$st");
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
