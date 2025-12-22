import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/concrete_form_quantity/substructure_column_formwork_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class FoundationFormworkConcreteController extends GetxController {
  RxList<Map<String, TextEditingController>> foundations = <Map<String, TextEditingController>>[].obs;
  var isLoading = false.obs;
  var subStructureResult = Rxn<SubstructureColumnFormworkModel>();

  // Column types
  final RxList<String> columnTypes = <String>[
    'CF',
    'Rectangular',
  ].obs;

  RxList<RxString> selectedTypes = <RxString>[].obs;

  final _repo = CalculatorRepository();

  @override
  void onInit() {
    super.onInit();
    addNewColumn();
  }

  void addNewColumn() {
    foundations.add({
      "tag": TextEditingController(),
      "width": TextEditingController(),
      "depth": TextEditingController(),
      "height": TextEditingController(),
      "quantity": TextEditingController(),
      "cement": TextEditingController(),
      "sand": TextEditingController(),
      "crush": TextEditingController(),
    });

    selectedTypes.add('CF'.obs);
  }

  void onTypeChange(int index, String newType) {
    selectedTypes[index].value = newType;

    if (newType == "CF" ) {
      foundations[index].putIfAbsent("addOnLength", () => TextEditingController());
      foundations[index].putIfAbsent("addOnWidth", () => TextEditingController());
    } else {
      foundations[index].remove("addOnLength");
      foundations[index].remove("addOnWidth");
    }
    update();
  }

  /// Delete a column safely
  void deleteColumn(int index) {
    if (foundations.length > 1) {
      for (var c in foundations[index].values) {
        c.dispose();
      }
      foundations.removeAt(index);
      selectedTypes.removeAt(index);
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
        Get.snackbar("Missing Input", "Please enter cement, sand, and crush values.");
        isLoading.value = false;
        return;
      }

      final List<Map<String, dynamic>> rows = [];

      for (int i = 0; i < foundations.length; i++) {
        final c = foundations[i];
        final type = selectedTypes[i].value;

        // Validation
        if (!isValidFeetInchFormat(c["width"]!.text) ||
            !isValidFeetInchFormat(c["depth"]!.text) ||
            !isValidFeetInchFormat(c["height"]!.text)) {
          Get.snackbar("Invalid Input",
              "Invalid feet-inch format in Column ${i + 1}. Use 4'6\" or 8'0\".");
          isLoading.value = false;
          return;
        }

        if (c["quantity"]!.text.trim().isEmpty) {
          Get.snackbar("Missing Quantity",
              "Please enter quantity for Column ${i + 1}.");
          isLoading.value = false;
          return;
        }

        if (type == "CF" ) {
          if (!isValidFeetInchFormat(c["addOnWidth"]!.text) ||
              !isValidFeetInchFormat(c["addOnLength"]!.text)) {
            Get.snackbar("Invalid Input",
                "Please enter valid Base/Leg dimensions in Column ${i + 1}.");
            isLoading.value = false;
            return;
          }
        }

        rows.add({
          "tag": c["tag"]!.text.trim(),
          "type": type,
          "width": c["width"]!.text.trim(),
          "depth": c["depth"]!.text.trim(),
          "height": c["height"]!.text.trim(),
          "addOnWidth": (type == "CF" )
              ? c["addOnWidth"]?.text.trim() ?? ""
              : "",
          "addOnLength": (type == "CF" )
              ? c["addOnLength"]?.text.trim() ?? ""
              : "",
        });
      }

      final body = {"mixRatio": mixRatio, "rows": rows};
      log("📦 Final Payload: $body");

      final result = await _repo.calculateSubstructureColumnFormwork(body: body);
      subStructureResult.value = SubstructureColumnFormworkModel.fromJson(result);
      log("✅ API Response: $result");
    } catch (e) {
      log("❌ Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    for (var column in foundations) {
      for (var controller in column.values) {
        controller.dispose();
      }
    }
    super.onClose();
  }
}
