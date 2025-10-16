import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/model/concrete_form_quantity/concrete_cost_estimator_quanity_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class ConcreteCostEstimatorController extends GetxController {
  var concreteCostResult = Rxn<ConcreteCostEstimatorQuantityModel>();
  final _repo = CalculatorRepository();

  // Controllers for inputs
  final currencySymbolController = TextEditingController();
  final concreteVolumeController = TextEditingController();
  final mixRatioController = TextEditingController();

  final cementRateController = TextEditingController();
  final sandRateController = TextEditingController();
  final waterRateController = TextEditingController();
  final aggregateRateController = TextEditingController();
  final admixtureRateController = TextEditingController();
  final laborRateController = TextEditingController();

  final dryVolumeFactorController = TextEditingController();
  final wastageController = TextEditingController();

  final cementBagSizeController = TextEditingController();
  final cementDensityController = TextEditingController();
  final sandDensityController = TextEditingController();
  final aggregateDensityController = TextEditingController();

  var isLoading = false.obs;
  var isAdvancedVisible = false.obs;

  void toggleAdvanced() {
    isAdvancedVisible.toggle();
  }

  /// Validate required inputs
  bool validateInputs() {
    log("message ${currencySymbolController.text.trim()}");
    log("message ${concreteVolumeController.text.trim()}");
    log("message ${mixRatioController.text.trim()}");
    log("message ${cementRateController.text.trim()}");
    if (currencySymbolController.text.trim().isEmpty ||
        concreteVolumeController.text.trim().isEmpty ||
        mixRatioController.text.trim().isEmpty ||
        cementRateController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      return false;
    }

    final numericFields = [
      concreteVolumeController.text,
      cementRateController.text,
      sandRateController.text,
      waterRateController.text,
      aggregateRateController.text,
      admixtureRateController.text,
      laborRateController.text,
      dryVolumeFactorController.text,
      wastageController.text,
      cementBagSizeController.text,
      cementDensityController.text,
      sandDensityController.text,
      aggregateDensityController.text,
    ];

    for (final value in numericFields) {
      if (value.isNotEmpty && double.tryParse(value) == null) {
        Get.snackbar("Invalid Input", "Please enter only numeric values.");
        return false;
      }
    }

    return true;
  }

  /// Validate mix ratio format (e.g. 1:2:4)
  bool isValidMixRatio(String input) {
    final pattern = RegExp(r'^\d+:\d+:\d+$');
    return pattern.hasMatch(input.trim());
  }

  /// Convert "1:2:4" to {"cement": "1", "sand": "2", "crush": "4"}


  /// Build final API request payload
  Map<String, dynamic> buildRequestBody() {
    return {
      "currencySymbol": currencySymbolController.text.trim(),
      "concreteVolume":
      double.tryParse(concreteVolumeController.text.trim()) ?? 0,
      "mixRatio": mixRatioController.text.trim(),
      "cementRate": double.tryParse(cementRateController.text.trim()) ?? 0,
      "sandRate": double.tryParse(sandRateController.text.trim()) ?? 0,
      "waterRate": double.tryParse(waterRateController.text.trim()) ?? 0,
      "aggregateRate":
      double.tryParse(aggregateRateController.text.trim()) ?? 0,
      "admixtureRate":
      double.tryParse(admixtureRateController.text.trim()) ?? 0,
      "laborRate": double.tryParse(laborRateController.text.trim()) ?? 0,
      "dryVolumeFactor":
      double.tryParse(dryVolumeFactorController.text.trim()) ?? 0,
      "wastagePercent": double.tryParse(wastageController.text.trim()) ?? 0,
      "cementBagSize":
      double.tryParse(cementBagSizeController.text.trim()) ?? 0,
      "cementDensity":
      double.tryParse(cementDensityController.text.trim()) ?? 0,
      "sandDensity": double.tryParse(sandDensityController.text.trim()) ?? 0,
      "aggregateDensity":
      double.tryParse(aggregateDensityController.text.trim()) ?? 0,
    };
  }

  /// Perform API calculation
  Future<void> calculate() async {
    final mixRatio = mixRatioController.text.trim();

    if (!isValidMixRatio(mixRatio)) {
      Get.snackbar(
        "Invalid Mix Ratio",
        "Please enter a valid format like 1:2:4",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (!validateInputs()) return;

    try {
      isLoading.value = true;
      final body = buildRequestBody();

      final res = await _repo.calculateConcreteCostEstimatorQuantity(body: body);

      concreteCostResult.value = ConcreteCostEstimatorQuantityModel.fromJson(res);
    } catch (e) {
      Get.snackbar("Error", "Failed to calculate: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Dispose controllers properly
  @override
  void onClose() {
    for (final controller in [
      currencySymbolController,
      concreteVolumeController,
      mixRatioController,
      cementRateController,
      sandRateController,
      waterRateController,
      aggregateRateController,
      admixtureRateController,
      laborRateController,
      dryVolumeFactorController,
      wastageController,
      cementBagSizeController,
      cementDensityController,
      sandDensityController,
      aggregateDensityController,
    ]) {
      controller.dispose();
    }
    super.onClose();
  }
}
