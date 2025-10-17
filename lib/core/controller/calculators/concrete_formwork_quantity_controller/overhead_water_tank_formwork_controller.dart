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
    for (int i = 0; i < 4; i++) {
      columnList.add({
        'length': TextEditingController(),
        'width': TextEditingController(),
        'height': TextEditingController(),
      });
    }
  }
  // 🔹 Calculation Function
  Future<void> calculate() async {
    try {
      isLoading.value = true;

      final dimensions = {
        "length": lengthInternalController.text,
        "width": widthInternalController.text,
        "height": heightInternalController.text,
        "wallThickness": wallThicknessController.text,
        "bottomThickness": bottomThicknessController.text,
        "roofThickness": roofThicknessController.text,
        "manholeLength": manholeLengthController.text,
        "manholeWidth": manholeWidthController.text,
      };
      List<Map<String, dynamic>> columns = [];

      // Build the "columns" list
      if (pickupColumnType.value == "Same Size") {
        final singleCol = {
          "length": columnLengthController.text,
          "width": columnWidthController.text,
          "height": columnHeightController.text,
        };
        columns = List.generate(4, (_) => singleCol);
      } else {
        // “Different” → 4 unique columns
        columns = columnList.map((col) {
          return {
            "length": col['length']?.text ?? "",
            "width": col['width']?.text ?? "",
            "height": col['height']?.text ?? "",
          };
        }).toList();
      }

      // Build the "mixRatio" object
      final mixRatio = {
        "cement": int.tryParse(cementController.text) ?? 0,
        "sand": int.tryParse(sandController.text) ?? 0,
        "crush": int.tryParse(crushController.text) ?? 0,
      };

      // Combine all
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
