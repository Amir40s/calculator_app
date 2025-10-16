import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import '../../../../config/model/concrete_form_quantity/slab_concrete_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class SlabConcreteController extends GetxController {
  RxList<Map<String, TextEditingController>> slabs = <Map<String, TextEditingController>>[].obs;

  var slabResult = Rxn<SlabConcreteModel>();
  final _repo = CalculatorRepository();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    addNewSlab();
  }

  void addNewSlab() {
    slabs.add({
      "grid": TextEditingController(),
      "tag": TextEditingController(),
      "length": TextEditingController(),
      "width": TextEditingController(),
      "thickness": TextEditingController(),
      "cement": TextEditingController(),
      "sand": TextEditingController(),
      "crush": TextEditingController(),
    });
  }

  void deleteSlab(int index) {
    if (slabs.length > 1) {
      slabs.removeAt(index);
    }
  }

  /// ✅ Helper: validate feet-inch format (e.g. 4'6" or 8'0")
  bool isValidFeetInchFormat(String input) {
    input = input.trim();
    if (!input.contains("'") || !input.contains('"')) return false;

    try {
      final parts = input.split("'");
      if (parts.length != 2) return false;

      final feetPart = parts[0].trim();
      final inchPart = parts[1].replaceAll('"', '').trim();

      if (feetPart.isEmpty || inchPart.isEmpty) return false;

      final feet = int.tryParse(feetPart);
      final inches = double.tryParse(inchPart);

      if (feet == null || inches == null) return false;
      if (feet < 0 || inches < 0 || inches >= 12) return false;

      return true;
    } catch (_) {
      return false;
    }
  }

  /// ✅ Calculate concrete data with validation
  Future<void> calculate() async {
    try {
      isLoading.value = true;

      // 🧱 Validate mix ratio
      final mixRatio = {
        "cement": slabs.first["cement"]!.text.trim(),
        "sand": slabs.first["sand"]!.text.trim(),
        "crush": slabs.first["crush"]!.text.trim(),
      };

      if (mixRatio.values.any((v) => v.isEmpty)) {
        Get.snackbar("Missing Input", "Please enter all mix ratio values (cement, sand, crush).");
        return;
      }

      // 🧾 Prepare and validate slabs list
      final List<Map<String, dynamic>> slabList = [];
      for (int i = 0; i < slabs.length; i++) {
        final slab = slabs[i];
        final length = slab["length"]!.text.trim();
        final width = slab["width"]!.text.trim();
        final thickness = slab["thickness"]!.text.trim();

        if (!isValidFeetInchFormat(length) ||
            !isValidFeetInchFormat(width) ||
            !isValidFeetInchFormat(thickness)) {
          Get.snackbar(
            "Invalid Input",
            "Invalid feet-inch format in Slab ${i + 1}. Use format like 4'6\" or 8'0\".",
          );
          return;
        }

        slabList.add({
          "grid": slab["grid"]!.text.trim(),
          "tag": slab["tag"]!.text.trim(),
          "length": length,
          "width": width,
          "thickness": thickness,
        });
      }

      final body = {
        "mixRatio": mixRatio,
        "slabs": slabList,
      };

      log("📦 POST DATA: $body");

      // 🚀 API call
      final res = await _repo.calculateSlabCostEstimatorQuantity(body: body);
      slabResult.value = SlabConcreteModel.fromJson(res);

    } catch (e) {
      log("❌ Slab Calculation Error: $e");
      Get.snackbar("Error", "Failed to calculate: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
