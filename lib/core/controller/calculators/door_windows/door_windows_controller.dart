import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/model/door_windows_model/door_windows_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class DoorWindowsController extends GetxController {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;

  final RxString selectedFrameWidthUnit = ''.obs;
  final RxString selectedFrameThicknessUnit = ''.obs;

  final RxList<String> measuringType = RxList<String>([
    "Inches (in)",
    "Feet (ft)",
  ]);
  String _mapUnitToApiFormat(String displayValue) {
    if (displayValue.contains("Inches")) return "in";
    if (displayValue.contains("Feet")) return "ft";
    return displayValue; // fallback
  }


  final TextEditingController pricePerFtController = TextEditingController();
  final TextEditingController frameWidthController = TextEditingController();
  final TextEditingController frameThicknessController = TextEditingController();

  final doors = <DoorData>[DoorData()].obs;

  final RxDouble totalVolume = 0.0.obs;
  final RxDouble totalCost = 0.0.obs;

  void addDoor() => doors.add(DoorData());
  void removeDoor(int index) {
    if (doors.length > 1) doors.removeAt(index);
  }

  void onFrameWidthUnitChanged(String value) {
    selectedFrameWidthUnit.value = value;
  }

  void onFrameThicknessUnitChanged(String value) {
    selectedFrameThicknessUnit.value = value;
  }

  bool _validateInputs() {
    if (frameWidthController.text.isEmpty ||
        frameThicknessController.text.isEmpty ||
        selectedFrameWidthUnit.value.isEmpty ||
        selectedFrameThicknessUnit.value.isEmpty) {
      Get.snackbar("Validation Error", "Please fill all frame fields.");
      return false;
    }

    for (int i = 0; i < doors.length; i++) {
      final d = doors[i];
      if (d.heightController.text.isEmpty ||
          d.widthController.text.isEmpty ||
          d.quantityController.text.isEmpty) {
        Get.snackbar("Validation Error", "Please fill all fields for Door ${i + 1}");
        return false;
      }
    }
    return true;
  }

  Future<void> convert() async {
    if (!_validateInputs()) return;

    isLoading.value = true;

    try {
      final List<Map<String, dynamic>> doorList = [];
      for (int i = 0; i < doors.length; i++) {
        final d = doors[i];
        doorList.add({
          "id": i,
          "height": double.tryParse(d.heightController.text) ?? 0,
          "width": double.tryParse(d.widthController.text) ?? 0,
          "quantity": int.tryParse(d.quantityController.text) ?? 0,
        });
      }

      final Map<String, dynamic> body = {
        "frameWidth": double.tryParse(frameWidthController.text) ?? 0,
        "frameWidthUnit": _mapUnitToApiFormat(selectedFrameWidthUnit.value),
        "frameThickness": double.tryParse(frameThicknessController.text) ?? 0,
        "frameThicknessUnit": _mapUnitToApiFormat(selectedFrameThicknessUnit.value),
        "doors": doorList
      };

      log("📤 Sending payload: $body");

      final response = await _repo.calculateWoodDoor(body: body);

      log("📥 Response: $response");

      totalVolume.value = (response["totalVolume"] ?? 0).toDouble();

      final price = double.tryParse(pricePerFtController.text) ?? 0;
      totalCost.value = price * totalVolume.value;

    } catch (e) {
      log("❌ Error in convert: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}


