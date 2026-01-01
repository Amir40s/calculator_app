import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/concrete_form_quantity/plinth_beam_concrete_model.dart';
import 'package:smart_construction_calculator/config/model/concrete_form_quantity/substructure_column_formwork_model.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import '../../../../config/repository/calculator_repository.dart';

class SuperstructureBeamFormworkConcreteController extends GetxController {
  RxList<Map<String, TextEditingController>> foundations = <Map<String, TextEditingController>>[].obs;
  var isLoading = false.obs;
  var superStructureBeamResult = Rxn<PlinthBeamConcretModel>();

  final _repo = CalculatorRepository();

  @override
  void onInit() {
    super.onInit();
    addNewColumn();
  }

  void addNewColumn() {
    foundations.add({
      "grid": TextEditingController(),
      "width": TextEditingController(),
      "height": TextEditingController(),
      "length": TextEditingController(),
      "superStrucTag": TextEditingController(),
      "cement": TextEditingController(),
      "sand": TextEditingController(),
      "crush": TextEditingController(),
    });
  }

  /// Delete a beam safely
  void deleteColumn(int index) {
    if (foundations.length > 1) {
      for (var c in foundations[index].values) {
        c.dispose();
      }
      foundations.removeAt(index);
    }
  }

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
      isLoading.value = true;

      final mixRatio = {
        "cement": foundations.first["cement"]!.text.trim(),
        "sand": foundations.first["sand"]!.text.trim(),
        "crush": foundations.first["crush"]!.text.trim(),
      };

      if (mixRatio.values.any((v) => v.isEmpty)) {
        AppUtils.showToast(
          text: "Please enter cement, sand, and crush values.",
          bgColor: Colors.red,
        );
        isLoading.value = false;
        return;
      }

      final List<Map<String, dynamic>> rows = [];

      for (int i = 0; i < foundations.length; i++) {
        final c = foundations[i];

        // Validate grid
        if (c["grid"]!.text.trim().isEmpty) {
          AppUtils.showToast(
            text: "Please enter grid for Beam ${i + 1}.",
            bgColor: Colors.red,
          );
          isLoading.value = false;
          return;
        }

        // Validate width format
        if (!isValidFeetInchFormat(c["width"]!.text)) {
          AppUtils.showToast(
            text: "Beam ${i + 1} - Width: Please use format 1'2\" (e.g., 4'6\" or 8'0\").",
            bgColor: Colors.red,
            timeInSecForIosWeb: 4,
          );
          isLoading.value = false;
          return;
        }

        // Validate height format
        if (!isValidFeetInchFormat(c["height"]!.text)) {
          AppUtils.showToast(
            text: "Beam ${i + 1} - Height: Please use format 1'2\" (e.g., 4'6\" or 8'0\").",
            bgColor: Colors.red,
            timeInSecForIosWeb: 4,
          );
          isLoading.value = false;
          return;
        }

        // Validate length format
        if (!isValidFeetInchFormat(c["length"]!.text)) {
          AppUtils.showToast(
            text: "Beam ${i + 1} - Length: Please use format 1'2\" (e.g., 4'6\" or 8'0\").",
            bgColor: Colors.red,
            timeInSecForIosWeb: 4,
          );
          isLoading.value = false;
          return;
        }

        if (c["superStrucTag"]!.text.trim().isEmpty) {
          AppUtils.showToast(
            text: "Please enter SuperStructure Tag for Beam ${i + 1}.",
            bgColor: Colors.red,
          );
          isLoading.value = false;
          return;
        }

        rows.add({
          "grid": c["grid"]!.text.trim(),
          "width": c["width"]!.text.trim(),
          "height": c["height"]!.text.trim(),
          "length": c["length"]!.text.trim(),
          "superStrucTag": c["superStrucTag"]!.text.trim(),
        });
      }

      final body = {"mixRatio": mixRatio, "beams": rows};
      log("📦 Final Payload: $body");

      final result = await _repo.calculatePlinthBeam(body: body);
      superStructureBeamResult.value = PlinthBeamConcretModel.fromJson(result);
      log("✅ API Response: $result");
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

  @override
  void onClose() {
    for (var beam in foundations) {
      for (var controller in beam.values) {
        controller.dispose();
      }
    }
    super.onClose();
  }
}
