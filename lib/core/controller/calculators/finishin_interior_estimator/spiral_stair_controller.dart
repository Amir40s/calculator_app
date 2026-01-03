import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/model/finishing_interior_estimate/spiral_stair_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../../../config/utility/app_utils.dart';

class SpiralStairController extends GetxController {
  final _repo = CalculatorRepository();

  // TextEditingControllers
  final centerColumnOuterRadiusController = TextEditingController(); // R (ft'in")
  final columnThicknessController = TextEditingController(); // T (mm)
  final riserHeightController = TextEditingController(); // h (ft'in")
  final treadAngleWebWidthController = TextEditingController(); // w (mm)
  final treadAngleThicknessController = TextEditingController(); // t (mm)
  final landingLengthController = TextEditingController(); // L (ft'in")
  final landingPlateThicknessController = TextEditingController(); // Lt (mm)
  final handrailPipeThicknessController = TextEditingController(); // th (mm)
  final balusterHeightController = TextEditingController(); // l' (ft'in")
  final landingRailingSidesController = TextEditingController(); // (1-4)
  
  final centerColumnHeightController = TextEditingController(); // H (ft'in")
  final materialDensityController = TextEditingController(); // D (Kg/m³)
  final stairOuterRadiusController = TextEditingController(); // r (ft'in")
  final treadAngleWebLengthController = TextEditingController(); // l (mm)
  final treadBasePlateThicknessController = TextEditingController(); // t' (mm)
  final landingWidthController = TextEditingController(); // W (ft'in")
  final handrailPipeDiaController = TextEditingController(); // d (mm)
  final balusterSpacingOnLandingController = TextEditingController(); // k (ft'in")
  final balustersPerStairTreadController = TextEditingController();
  final currencySymbolController = TextEditingController(); // Currency Symbol

  // Price Controllers
  final centerColumnPriceController = TextEditingController();
  final treadFrameAnglePriceController = TextEditingController();
  final treadBasePlatePriceController = TextEditingController();
  final landingBasePlatePriceController = TextEditingController();
  final landingBaseFramePriceController = TextEditingController();
  final handrailPipePriceController = TextEditingController();
  final balusterPipesPriceController = TextEditingController();

  // State
  var isLoading = false.obs;
  var result = Rxn<SpiralStairModel>();

  // Helper method to get price for an item by description
  double getPriceForItem(String description) {
    final priceMap = {
      "Center Column": centerColumnPriceController.text.trim(),
      "Tread Frame Angle": treadFrameAnglePriceController.text.trim(),
      "Tread Base Plate": treadBasePlatePriceController.text.trim(),
      "Landing Base Plate": landingBasePlatePriceController.text.trim(),
      "Landing Base Frame": landingBaseFramePriceController.text.trim(),
      "Handrail Pipe": handrailPipePriceController.text.trim(),
      "Baluster Pipes": balusterPipesPriceController.text.trim(),
    };

    final priceStr = priceMap[description] ?? "0";
    return double.tryParse(priceStr) ?? 0.0;
  }

  @override
  void onClose() {
    centerColumnOuterRadiusController.dispose();
    columnThicknessController.dispose();
    riserHeightController.dispose();
    treadAngleWebWidthController.dispose();
    treadAngleThicknessController.dispose();
    landingLengthController.dispose();
    landingPlateThicknessController.dispose();
    handrailPipeThicknessController.dispose();
    balusterHeightController.dispose();
    landingRailingSidesController.dispose();
    centerColumnHeightController.dispose();
    materialDensityController.dispose();
    stairOuterRadiusController.dispose();
    treadAngleWebLengthController.dispose();
    treadBasePlateThicknessController.dispose();
    landingWidthController.dispose();
    handrailPipeDiaController.dispose();
    balusterSpacingOnLandingController.dispose();
    balustersPerStairTreadController.dispose();
    currencySymbolController.dispose();
    centerColumnPriceController.dispose();
    treadFrameAnglePriceController.dispose();
    treadBasePlatePriceController.dispose();
    landingBasePlatePriceController.dispose();
    landingBaseFramePriceController.dispose();
    handrailPipePriceController.dispose();
    balusterPipesPriceController.dispose();
    super.onClose();
  }

  // Validate feet-inch format
  bool isValidFeetInchFormat(String input) {
    input = input.trim();
    if (input.isEmpty) return false;
    if (!input.contains("'") || !input.contains('"')) return false;
    try {
      final parts = input.split("'");
      if (parts.length != 2) return false;
      final feetPart = parts[0].trim();
      final inchPart = parts[1].replaceAll('"', '').trim();
      final feet = int.tryParse(feetPart);
      final inches = double.tryParse(inchPart);
      if (feet == null || inches == null) return false;
      if (feet < 0 || inches < 0 || inches >= 12) return false;
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> calculate() async {
    try {
      // Validate feet-inch format fields
      final feetInchFields = {
        "Center Column Outer Radius R": centerColumnOuterRadiusController.text.trim(),
        "Riser Height h": riserHeightController.text.trim(),
        "Landing Length L": landingLengthController.text.trim(),
        "Baluster Height l'": balusterHeightController.text.trim(),
        "Center Column Height H": centerColumnHeightController.text.trim(),
        "Stair Outer Radius r": stairOuterRadiusController.text.trim(),
        "Landing Width W": landingWidthController.text.trim(),
        "Baluster Spacing on Landing k": balusterSpacingOnLandingController.text.trim(),
      };

      for (final entry in feetInchFields.entries) {
        if (entry.value.isEmpty) {
          AppUtils.showToast(
            text: "Please enter ${entry.key}.",
            bgColor: Colors.red,
          );
          return;
        }
        if (!isValidFeetInchFormat(entry.value)) {
          AppUtils.showToast(
            text: "Invalid ${entry.key} format. Use format like 0'2\" or 23'0\".",
            bgColor: Colors.red,
          );
          return;
        }
      }

      // Validate numeric fields
      final numericFields = {
        "Column Thickness T": columnThicknessController.text.trim(),
        "Tread Angle Web width w": treadAngleWebWidthController.text.trim(),
        "Tread Angle thickness t": treadAngleThicknessController.text.trim(),
        "Landing Plate thickness Lt": landingPlateThicknessController.text.trim(),
        "Handrail Pipe Thickness th": handrailPipeThicknessController.text.trim(),
        "Material Density D": materialDensityController.text.trim(),
        "Tread Angle Web length l": treadAngleWebLengthController.text.trim(),
        "Tread Base Plate thickness t'": treadBasePlateThicknessController.text.trim(),
        "Handrail Pipe Dia d": handrailPipeDiaController.text.trim(),
        "Balusters per Stair Tread": balustersPerStairTreadController.text.trim(),
      };

      for (final entry in numericFields.entries) {
        if (entry.value.isEmpty) {
          AppUtils.showToast(
            text: "Please enter ${entry.key}.",
            bgColor: Colors.red,
          );
          return;
        }
        final value = double.tryParse(entry.value);
        if (value == null || value < 0) {
          AppUtils.showToast(
            text: "Please enter a valid ${entry.key}.",
            bgColor: Colors.red,
          );
          return;
        }
      }

      // Validate Landing Railing Sides (1-4)
      final railingSides = int.tryParse(landingRailingSidesController.text.trim());
      if (railingSides == null || railingSides < 1 || railingSides > 4) {
        AppUtils.showToast(
          text: "Landing Railing Sides must be between 1 and 4.",
          bgColor: Colors.red,
        );
        return;
      }

      isLoading.value = true;

      // Convert numeric fields to numbers
      final t = double.tryParse(columnThicknessController.text.trim()) ?? 0;
      final d = double.tryParse(materialDensityController.text.trim()) ?? 0;
      final w = double.tryParse(treadAngleWebWidthController.text.trim()) ?? 0;
      final l = double.tryParse(treadAngleWebLengthController.text.trim()) ?? 0;
      final tThickness = double.tryParse(treadAngleThicknessController.text.trim()) ?? 0;
      final tPrime = double.tryParse(treadBasePlateThicknessController.text.trim()) ?? 0;
      final lt = double.tryParse(landingPlateThicknessController.text.trim()) ?? 0;
      final dDia = double.tryParse(handrailPipeDiaController.text.trim()) ?? 0;
      final th = double.tryParse(handrailPipeThicknessController.text.trim()) ?? 0;
      final balPerTread = int.tryParse(balustersPerStairTreadController.text.trim()) ?? 0;

      final body = {
        "R": centerColumnOuterRadiusController.text.trim().toString(),
        "H": centerColumnHeightController.text.trim(),
        "T": t,
        "D": d,
        "h": riserHeightController.text.trim(),
        "r": stairOuterRadiusController.text.trim(),
        "w": w,
        "l": l,
        "t": tThickness,
        "tPrime": tPrime,
        "L": landingLengthController.text.trim(),
        "W": landingWidthController.text.trim(),
        "Lt": lt,
        "d": dDia,
        "th": th,
        "k": balusterSpacingOnLandingController.text.trim(),
        "lPrime": balusterHeightController.text.trim(),
        "balPerTread": balPerTread,
        "railingSides": railingSides,
      };

      log("📦 Spiral Stair Payload: $body");

      final response = await _repo.calculateSpiralStair(body: body);
      result.value = SpiralStairModel.fromJson(response);
      log("✅ Spiral Stair Response: $response");
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

