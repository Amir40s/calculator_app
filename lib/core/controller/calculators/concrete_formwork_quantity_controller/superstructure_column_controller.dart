import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/concrete_form_quantity/substructure_column_formwork_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class SuperstructureColumnController extends GetxController {
  RxList<Map<String, TextEditingController>> columns =
      <Map<String, TextEditingController>>[].obs;
  var isLoading = false.obs;
  var subStructureResult = Rxn<SubstructureColumnFormworkModel>();

  // Column types
  final RxList<String> columnTypes = <String>[
    'Square',
    'Rectangular',
    'L-Shaped',
    'U-Shaped',
  ].obs;

  // Each column can have its own type instead of a single global one
  // to support different types per column
  RxList<RxString> selectedTypes = <RxString>[].obs;

  final _repo = CalculatorRepository();

  @override
  void onInit() {
    super.onInit();
    addNewColumn();
  }

  /// Add a new column (default = Square type)
  void addNewColumn() {
    columns.add({
      "tag": TextEditingController(),
      "width": TextEditingController(),
      "thickness": TextEditingController(),
      "height": TextEditingController(),
      "quantity": TextEditingController(),
      "cement": TextEditingController(),
      "sand": TextEditingController(),
      "crush": TextEditingController(),
    });

    selectedTypes.add('Square'.obs); // each column gets its own type tracker
  }

  /// Handle type change dynamically for each column
  void onTypeChange(int index, String newType) {
    selectedTypes[index].value = newType;

    // Add extra fields if needed
    if (newType == "L-Shaped" || newType == "U-Shaped") {
      columns[index].putIfAbsent("baseWidth", () => TextEditingController());
      columns[index].putIfAbsent("baseThickness", () => TextEditingController());
      columns[index].putIfAbsent("legWidth", () => TextEditingController());
      columns[index].putIfAbsent("legThickness", () => TextEditingController());
    } else {
      // Remove if switched back to Square/Rectangular
      columns[index].remove("baseWidth");
      columns[index].remove("baseThickness");
      columns[index].remove("legWidth");
      columns[index].remove("legThickness");
    }
    update();
  }

  /// Delete a column safely
  void deleteColumn(int index) {
    if (columns.length > 1) {
      // Dispose controllers
      for (var c in columns[index].values) {
        c.dispose();
      }
      columns.removeAt(index);
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
        "cement": columns.first["cement"]!.text.trim(),
        "sand": columns.first["sand"]!.text.trim(),
        "crush": columns.first["crush"]!.text.trim(),
      };

      if (mixRatio.values.any((v) => v.isEmpty)) {
        Get.snackbar("Missing Input", "Please enter cement, sand, and crush values.");
        isLoading.value = false;
        return;
      }

      final List<Map<String, dynamic>> rows = [];

      for (int i = 0; i < columns.length; i++) {
        final c = columns[i];
        final type = selectedTypes[i].value;

        // Validation
        if (!isValidFeetInchFormat(c["width"]!.text) ||
            !isValidFeetInchFormat(c["thickness"]!.text) ||
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

        if (type == "L-Shaped" || type == "U-Shaped") {
          if (!isValidFeetInchFormat(c["baseWidth"]!.text) ||
              !isValidFeetInchFormat(c["baseThickness"]!.text) ||
              !isValidFeetInchFormat(c["legWidth"]!.text) ||
              !isValidFeetInchFormat(c["legThickness"]!.text)) {
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
          "thickness": c["thickness"]!.text.trim(),
          "height": c["height"]!.text.trim(),
          "baseWidth": (type == "L-Shaped" || type == "U-Shaped")
              ? c["baseWidth"]?.text.trim() ?? ""
              : "",
          "baseThickness": (type == "L-Shaped" || type == "U-Shaped")
              ? c["baseThickness"]?.text.trim() ?? ""
              : "",
          "legWidth": (type == "L-Shaped" || type == "U-Shaped")
              ? c["legWidth"]?.text.trim() ?? ""
              : "",
          "legThickness": (type == "L-Shaped" || type == "U-Shaped")
              ? c["legThickness"]?.text.trim() ?? ""
              : "",
          "quantity": c["quantity"]!.text.trim(),
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
    for (var column in columns) {
      for (var controller in column.values) {
        controller.dispose();
      }
    }
    super.onClose();
  }
}
