import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/model/concrete_form_quantity/underground_water_tank_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../../../config/utility/app_utils.dart';

class UndergroundWaterTankController extends GetxController {
  final _repo = CalculatorRepository();
  var isLoading = false.obs;

  // 🧱 Input Controllers
  final lengthInternalController = TextEditingController();
  final widthInternalController = TextEditingController();
  final heightInternalController = TextEditingController();
  final wallThicknessController = TextEditingController();
  final bottomThicknessController = TextEditingController();
  final roofThicknessController = TextEditingController();
  final manholeLengthController = TextEditingController();
  final manholeWidthController = TextEditingController();

  // 🧮 Mix ratio inputs
  final cementController = TextEditingController();
  final sandController = TextEditingController();
  final crushController = TextEditingController();

  // 📊 Result model
  var result = Rxn<UndergroundWaterTankModel>();

  @override
  void onClose() {
    lengthInternalController.dispose();
    widthInternalController.dispose();
    heightInternalController.dispose();
    wallThicknessController.dispose();
    bottomThicknessController.dispose();
    roofThicknessController.dispose();
    manholeLengthController.dispose();
    manholeWidthController.dispose();
    cementController.dispose();
    sandController.dispose();
    crushController.dispose();
    super.onClose();
  }

  /// ✅ Helper: validate feet-inch format
  bool isValidFeetInchFormat(String input) {
    input = input.trim();
    if (!input.contains("'") || !input.contains('"')) return false;
    try {
      final parts = input.split("'");
      if (parts.length != 2) return false;
      final feet = int.tryParse(parts[0].trim());
      final inches = double.tryParse(parts[1].replaceAll('"', '').trim());
      if (feet == null || inches == null) return false;
      if (feet < 0 || inches < 0 || inches >= 12) return false;
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 🚀 Perform Calculation
  Future<void> calculate() async {
    try {
      isLoading.value = true;

      // ✅ Validate required fields
      final fields = {
        "Length (Internal)": lengthInternalController.text.trim(),
        "Width (Internal)": widthInternalController.text.trim(),
        "Height (Internal)": heightInternalController.text.trim(),
        "Wall Thickness": wallThicknessController.text.trim(),
        "Bottom Thickness": bottomThicknessController.text.trim(),
        "Roof Thickness": roofThicknessController.text.trim(),
        "Manhole Length": manholeLengthController.text.trim(),
        "Manhole Width": manholeWidthController.text.trim(),
      };

      for (final entry in fields.entries) {
        if (entry.value.isEmpty) {
          Get.snackbar("Missing Input", "Please enter ${entry.key}");
          return;
        }
        if (!isValidFeetInchFormat(entry.value)) {
          Get.snackbar("Invalid Format",
              "Invalid ${entry.key} format. Use feet-inch like 4'6\" or 8'0\".");
          return;
        }
      }

      // ✅ Validate mix ratio
      if (cementController.text.isEmpty ||
          sandController.text.isEmpty ||
          crushController.text.isEmpty) {
        Get.snackbar("Missing Input",
            "Please enter mix ratio values (cement, sand, crush).");
        return;
      }

      // 🧾 Prepare body
      final body = {
        "tankLength": lengthInternalController.text.trim(),
        "tankWidth": widthInternalController.text.trim(),
        "tankHeight": heightInternalController.text.trim(),
        "wallThickness": wallThicknessController.text.trim(),
        "bottomThickness": bottomThicknessController.text.trim(),
        "roofThickness": roofThicknessController.text.trim(),
        "manholeLength": manholeLengthController.text.trim(),
        "manholeWidth": manholeWidthController.text.trim(),
        "cementRatio": cementController.text.trim(),
        "sandRatio": sandController.text.trim(),
        "crushRatio": crushController.text.trim(),
        "pcHeight": "",
        "pcLength": "",
        "pcWidth": ""
      };

      log("📦 Underground Tank Request: $body");

      final res = await _repo.calculateUndergroundWaterTank(body: body);

      result.value = UndergroundWaterTankModel.fromJson(res);
      log("✅ Tank Calculation Successful: ${result.value}");
    } catch (e, s) {
      log("❌ Underground Tank Error: $e\n$s");
      Get.snackbar("Error", "Calculation failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
