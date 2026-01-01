import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/concrete_form_quantity/curing_water_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';

class CuringWaterController extends GetxController {
  final _repo = CalculatorRepository();

  // Controllers
  final surfaceAreaController = TextEditingController();
  final curingDurationController = TextEditingController();
  final waterApplicationRateController = TextEditingController();

  // Unit selections
  final RxString selectedSurfaceAreaUnit = 'Square Meters (m²)'.obs;
  final RxString selectedWaterRateUnit = 'Liters/m²/day'.obs;

  // Available units
  final RxList<String> surfaceAreaUnits = [
    'Square Meters (m²)',
    'Square Feet (ft²)',
  ].obs;

  final RxList<String> waterRateUnits = [
    'Liters/m²/day',
    'Gallons/yd²/day',
  ].obs;

  // State
  var isLoading = false.obs;
  var result = Rxn<CuringWaterModel>();

  // Input values for display
  var inputSurfaceArea = 0.0.obs;
  var inputCuringDuration = 0.0.obs;
  var inputWaterRate = 0.0.obs;

  // Helper methods to convert display units to API format
  String _getAreaUnitForApi(String displayUnit) {
    switch (displayUnit) {
      case 'Square Meters (m²)':
        return 'm2';
      case 'Square Feet (ft²)':
        return 'ft2';
      default:
        return 'm2';
    }
  }

  String _getRateUnitForApi(String displayUnit) {
    switch (displayUnit) {
      case 'Liters/m²/day':
        return 'L/m2/day';
      case 'Gallons/yd²/day':
        return 'gal/yd2/day';
      default:
        return 'L/m2/day';
    }
  }

  @override
  void onClose() {
    surfaceAreaController.dispose();
    curingDurationController.dispose();
    waterApplicationRateController.dispose();
    super.onClose();
  }

  Future<void> calculate() async {
    try {
      // Validate inputs
      if (surfaceAreaController.text.trim().isEmpty) {
        AppUtils.showToast(
          text: "Please enter Surface Area.",
          bgColor: Colors.red,
        );
        return;
      }

      if (curingDurationController.text.trim().isEmpty) {
        AppUtils.showToast(
          text: "Please enter Curing Duration.",
          bgColor: Colors.red,
        );
        return;
      }

      if (waterApplicationRateController.text.trim().isEmpty) {
        AppUtils.showToast(
          text: "Please enter Water Application Rate.",
          bgColor: Colors.red,
        );
        return;
      }

      final surfaceArea = double.tryParse(surfaceAreaController.text.trim());
      final curingDuration = double.tryParse(curingDurationController.text.trim());
      final waterRate = double.tryParse(waterApplicationRateController.text.trim());

      if (surfaceArea == null || surfaceArea <= 0) {
        AppUtils.showToast(
          text: "Please enter a valid Surface Area.",
          bgColor: Colors.red,
        );
        return;
      }

      if (curingDuration == null || curingDuration <= 0) {
        AppUtils.showToast(
          text: "Please enter a valid Curing Duration.",
          bgColor: Colors.red,
        );
        return;
      }

      if (waterRate == null || waterRate <= 0) {
        AppUtils.showToast(
          text: "Please enter a valid Water Application Rate.",
          bgColor: Colors.red,
        );
        return;
      }

      isLoading.value = true;

      inputSurfaceArea.value = surfaceArea;
      inputCuringDuration.value = curingDuration;
      inputWaterRate.value = waterRate;

      final body = {
        "area": surfaceArea,
        "areaUnit": _getAreaUnitForApi(selectedSurfaceAreaUnit.value),
        "duration": curingDuration,
        "rate": waterRate,
        "rateUnit": _getRateUnitForApi(selectedWaterRateUnit.value),
      };

      log("📦 Curing Water Payload: $body");

      final response = await _repo.calculateCuringWaterFormwork(body: body);
      result.value = CuringWaterModel.fromJson(response);
      log("✅ Curing Water Response: $response");
    } catch (e, stackTrace) {
      log("❌ Error: $e");
      log("❌ StackTrace: $stackTrace");
      AppUtils.showToast(
        text: "Failed to calculate: ${e.toString()}",
        bgColor: Colors.red,
        timeInSecForIosWeb: 4,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

