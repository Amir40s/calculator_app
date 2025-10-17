import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/model/concrete_form_quantity/beam_result_model.dart';
import '../../../../config/model/concrete_form_quantity/plinth_beam_concrete_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class PlinthBeamConcreteController extends GetxController {
  RxList<Map<String, TextEditingController>> beam = <Map<String, TextEditingController>>[].obs;

  var beamConcreteResult = Rxn<PlinthBeamConcretModel>();
  final _repo = CalculatorRepository();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    addNewBeam();
  }

  void addNewBeam() {
    beam.add({
      "grid": TextEditingController(),
      "tag": TextEditingController(),
      "length": TextEditingController(),
      "width": TextEditingController(),
      "height": TextEditingController(),
      "cement": TextEditingController(),
      "sand": TextEditingController(),
      "crush": TextEditingController(),
    });
  }

  void deleteBeam(int index) {
    if (beam.length > 1) beam.removeAt(index);
  }

  bool isValidFeetInchFormat(String input) {
    input = input.trim();
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

  /// ✅ Perform calculation
  Future<void> calculate() async {
    try {
      isLoading.value = true;

      // 🧱 Mix ratio validation
      final mixRatio = {
        "cement": beam.first["cement"]!.text.trim(),
        "sand": beam.first["sand"]!.text.trim(),
        "crush": beam.first["crush"]!.text.trim(),
      };
      if (mixRatio.values.any((v) => v.isEmpty)) {
        Get.snackbar("Missing Input", "Please enter cement, sand, and crush values.");
        return;
      }

      // 🧾 Prepare beam list
      final List<Map<String, dynamic>> beamList = [];
      for (int i = 0; i < beam.length; i++) {
        final b = beam[i];
        final length = b["length"]!.text.trim();
        final width = b["width"]!.text.trim();
        final height = b["height"]!.text.trim();

        if (!isValidFeetInchFormat(length) ||
            !isValidFeetInchFormat(width) ||
            !isValidFeetInchFormat(height)) {
          Get.snackbar("Invalid Input",
              "Invalid feet-inch format in Beam ${i + 1}. Use format like 4'6\" or 8'0\".");
          return;
        }

        beamList.add({
          "grid": b["grid"]!.text.trim(),
          "tag": b["tag"]!.text.trim(),
          "length": length,
          "width": width,
          "height": height,
        });
      }

      final body = {
        "mixRatio": mixRatio,
        "beams": beamList,
      };

      log("📦 POST DATA: $body");

      final res = await _repo.calculatePlinthBeam(body: body);
      beamConcreteResult.value = PlinthBeamConcretModel.fromJson(res);
    } catch (e) {
      log("❌ Beam Calculation Error: $e");
      Get.snackbar("Error", "Failed to calculate: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
