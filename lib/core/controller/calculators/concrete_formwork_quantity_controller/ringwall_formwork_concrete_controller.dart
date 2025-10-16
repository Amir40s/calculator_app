import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';
import '../../../../config/model/concrete_form_quantity/ringwall_formwork_model.dart';

class RingwallFormworkConcreteController extends GetxController {
  final _repo = CalculatorRepository();

  // 🔹 Input Controllers
  final lengthOfPlotController = TextEditingController();
  final widthOfPlotController = TextEditingController();
  final widthOfFoundationController = TextEditingController();
  final thicknessOfFoundationController = TextEditingController();
  final thicknessOfRingWallController = TextEditingController();
  final heightOfRingWallController = TextEditingController();

  // 🔹 Mix ratio controllers
  final cementController = TextEditingController();
  final sandController = TextEditingController();
  final crushController = TextEditingController();

  var ringwallResult = Rxn<RingwallFormworkConcreteModel>();
  var isLoading = false.obs;

  /// ✅ Validate format like 4'6" or 8'0"
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

  /// ✅ Calculate Ringwall Formwork Concrete
  Future<void> calculate() async {
    try {
      isLoading.value = true;

      final cement = cementController.text.trim();
      final sand = sandController.text.trim();
      final crush = crushController.text.trim();

      // 🧱 Validate ratios
      if (cement.isEmpty || sand.isEmpty || crush.isEmpty) {
        Get.snackbar("Missing Input", "Please enter cement, sand, and crush ratios.");
        return;
      }

      // 🧾 Validate dimension inputs
      final fields = {
        "Length of Plot": lengthOfPlotController.text,
        "Width of Plot": widthOfPlotController.text,
        "Width of Foundation": widthOfFoundationController.text,
        "Thickness of Foundation": thicknessOfFoundationController.text,
        "Thickness of Ring Wall": thicknessOfRingWallController.text,
        "Height of Ring Wall": heightOfRingWallController.text,
      };

      for (final entry in fields.entries) {
        if (!isValidFeetInchFormat(entry.value)) {
          Get.snackbar("Invalid Input", "${entry.key} must be in format like 4'6\" or 8'0\".");
          return;
        }
      }

      // ✅ Prepare the API body (keep original string values!)
      final body = {
        "lengthPlot": lengthOfPlotController.text.trim(),
        "widthPlot": widthOfPlotController.text.trim(),
        "widthFoundation": widthOfFoundationController.text.trim(),
        "thicknessFoundation": thicknessOfFoundationController.text.trim(),
        "thicknessRingWall": thicknessOfRingWallController.text.trim(),
        "heightRingWall": heightOfRingWallController.text.trim(),
        "cementRatio": cement,
        "sandRatio": sand,
        "crushRatio": crush,
        "mixRatio": "$cement:$sand:$crush",
      };

      // 🛰️ Log
      print("📦 POST DATA: $body");

      // 🚀 API Call
      final response = await _repo.calculateRingwallFormworkConcrete(body: body);

      // 🧩 Parse Result
      ringwallResult.value = RingwallFormworkConcreteModel.fromJson(response);
    } catch (e) {
      Get.snackbar("❌ Ringwall Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    lengthOfPlotController.dispose();
    widthOfPlotController.dispose();
    widthOfFoundationController.dispose();
    thicknessOfFoundationController.dispose();
    thicknessOfRingWallController.dispose();
    heightOfRingWallController.dispose();
    cementController.dispose();
    sandController.dispose();
    crushController.dispose();
    super.onClose();
  }
}
