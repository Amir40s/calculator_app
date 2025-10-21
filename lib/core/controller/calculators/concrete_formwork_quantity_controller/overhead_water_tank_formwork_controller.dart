import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import '../../../../config/model/concrete_form_quantity/oberheadWaterTankFormworkModel.dart';

class OverheadWaterTankFormworkController extends GetxController {
  final _repo = CalculatorRepository();

  // 🔹 Tank Internal Dimensions
  final lengthInternalController = TextEditingController();
  final widthInternalController = TextEditingController();
  final heightInternalController = TextEditingController();
  final wallThicknessController = TextEditingController();
  final bottomThicknessController = TextEditingController();
  final roofThicknessController = TextEditingController();

  // 🔹 Manhole
  final manholeLengthController = TextEditingController();
  final manholeWidthController = TextEditingController();

  // 🔹 Pickup Columns
  final columnLengthController = TextEditingController();
  final columnWidthController = TextEditingController();
  final columnHeightController = TextEditingController();
  RxList<Map<String, TextEditingController>> columnList =
      <Map<String, TextEditingController>>[].obs;

  // 🔹 Material Ratios
  final cementController = TextEditingController();
  final sandController = TextEditingController();
  final crushController = TextEditingController();

  // 🔹 Pickup Column Type (Radio Selection)
  var pickupColumnType = "Same Size".obs;

  // 🔹 Results
  var tankResult = Rxn<OverheadWaterTankFormworkModel>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // initialize 4 dynamic columns
    for (int i = 0; i < 4; i++) {
      columnList.add({
        'length': TextEditingController(),
        'width': TextEditingController(),
        'height': TextEditingController(),
      });
    }
  }

  // 🔹 Validate feet-inch input
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


  // 🔹 Validate all required dimension fields before API call
  bool _validateAllInputs(Map<String, String> dimensions, List<Map<String, String>> columns) {
    for (var entry in dimensions.entries) {
      if (entry.value.isNotEmpty && !isValidFeetInchFormat(entry.value)) {
        Get.snackbar("Invalid Input", "Invalid ${entry.key} format. Use format like 4'6\" or 4'.");
        return false;
      }
    }
    for (int i = 0; i < columns.length; i++) {
      final col = columns[i];
      for (var entry in col.entries) {
        if (entry.value.isNotEmpty && !isValidFeetInchFormat(entry.value)) {
          Get.snackbar("Invalid Column", "Invalid ${entry.key} in column ${i + 1}. Use format like 2'6\".");
          return false;
        }
      }
    }
    return true;
  }

  // 🔹 Calculation Function
  Future<void> calculate() async {
    try {
      isLoading.value = true;

      final dimensions = {
        "length": lengthInternalController.text.trim(),
        "width": widthInternalController.text.trim(),
        "height": heightInternalController.text.trim(),
        "wallThickness": wallThicknessController.text.trim(),
        "bottomThickness": bottomThicknessController.text.trim(),
        "roofThickness": roofThicknessController.text.trim(),
        "manholeLength": manholeLengthController.text.trim(),
        "manholeWidth": manholeWidthController.text.trim(),
      };

      List<Map<String, String>> columns = [];

      if (pickupColumnType.value == "Same Size") {
        final singleCol = {
          "length": columnLengthController.text.trim(),
          "width": columnWidthController.text.trim(),
          "height": columnHeightController.text.trim(),
        };
        columns = List.generate(4, (_) => singleCol);
      } else {
        columns = columnList.map((col) {
          return {
            "length": col['length']?.text.trim() ?? "",
            "width": col['width']?.text.trim() ?? "",
            "height": col['height']?.text.trim() ?? "",
          };
        }).toList();
      }

      if (!_validateAllInputs(dimensions, columns)) {
        isLoading.value = false;
        return;
      }

      final mixRatio = {
        "cement": int.tryParse(cementController.text) ?? 0,
        "sand": int.tryParse(sandController.text) ?? 0,
        "crush": int.tryParse(crushController.text) ?? 0,
      };

      final body = {
        "dimensions": dimensions,
        "columns": columns,
        "mixRatio": mixRatio,
      };

      log("📦 POST DATA: $body");

      final res = await _repo.calculateOverheadWaterTankFormwork(body: body);
      tankResult.value = OverheadWaterTankFormworkModel.fromJson(res);
    } catch (e) {
      log("❌ Overhead Tank Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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
    columnLengthController.dispose();
    columnWidthController.dispose();
    columnHeightController.dispose();
    cementController.dispose();
    sandController.dispose();
    crushController.dispose();
    for (var col in columnList) {
      for (var c in col.values) {
        c.dispose();
      }
    }
    super.onClose();
  }
}
