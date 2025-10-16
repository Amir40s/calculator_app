import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';

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

  // 🔹 Material Ratios
  final cementController = TextEditingController();
  final sandController = TextEditingController();
  final crushController = TextEditingController();

  // 🔹 Pickup Column Type (Radio Selection)
  var pickupColumnType = "Same Size".obs; // or "Different"

  // 🔹 Results
  var tankResult = Rxn<OverheadWaterTankFormworkModel>();
  var isLoading = false.obs;

  // 🔹 Calculation Function
  Future<void> calculate() async {
    try {
      isLoading.value = true;

      final body = {
        "lengthInternal": lengthInternalController.text,
        "widthInternal": widthInternalController.text,
        "heightInternal": heightInternalController.text,
        "wallThickness": wallThicknessController.text,
        "bottomThickness": bottomThicknessController.text,
        "roofThickness": roofThicknessController.text,
        "manholeLength": manholeLengthController.text,
        "manholeWidth": manholeWidthController.text,
        "columnLength": columnLengthController.text,
        "columnWidth": columnWidthController.text,
        "columnHeight": columnHeightController.text,
        "pickupColumnType": pickupColumnType.value, // 👈 Radio Button value
        "cementRatio": cementController.text,
        "sandRatio": sandController.text,
        "crushRatio": crushController.text,
        "mixRatio":
        "${cementController.text}:${sandController.text}:${crushController.text}",
      };

      AppUtils.logger("📦 POST DATA: $body");

      final res = await _repo.calculateOverheadWaterTankFormwork(body: body);
      tankResult.value = OverheadWaterTankFormworkModel.fromJson(res);
    } catch (e) {
      AppUtils.logger("❌ Overhead Tank Error: $e");
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
    super.onClose();
  }
}
