import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/model/earth_cost/backFill_model.dart';
import '../../../../config/model/earth_cost/excavation_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class BackFillController extends GetxController {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;
   final Rx<BackfillModel?> backFillCost = Rx<BackfillModel?>(null);

  // 🔹 Dropdowns for material and truck types
  final RxString selectedMaterialType = 'clean sand/gravel'.obs;
  final RxString selectedTruckType = 'sac truck'.obs;

  final RxList<String> materialType = RxList<String>([
    "clean sand/gravel",
    "silty/clayey sand",
  ]);

  final RxList<String> truckType = RxList<String>([
    "sac truck",
    "10-wheeler dumper",
  ]);

  // 🔹 Input controllers
  final TextEditingController plotLengthController = TextEditingController();
  final TextEditingController plotWidthController = TextEditingController();
  final TextEditingController depthController = TextEditingController();
  final TextEditingController totalConcreteController = TextEditingController();

  // 🔹 Dropdown handlers
  void onMaterialTypeChanged(String value) {
    selectedMaterialType.value = value;
  }

  void onTruckTypeChanged(String value) {
    selectedTruckType.value = value;
  }

  // ✅ Calculate compaction factor based on material type
  double getCompactionFactor() {
    if (selectedMaterialType.value == "clean sand/gravel") {
      return 1.15;
    } else if (selectedMaterialType.value == "silty/clayey sand") {
      return 1.20;
    }
    return 1.0;
  }

  // ✅ Calculate truck capacity based on truck type
  int getTruckCapacity() {
    if (selectedTruckType.value == "sac truck") {
      return 450;
    } else if (selectedTruckType.value == "10-wheeler dumper") {
      return 700;
    }
    return 450;
  }

  // ✅ Input validation
  bool _validateInputs() {
    if (plotLengthController.text.isEmpty ||
        plotWidthController.text.isEmpty ||
        depthController.text.isEmpty ||
        totalConcreteController.text.isEmpty) {
      Get.snackbar(
        'Missing Fields',
        'Please fill all required input fields.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  // ✅ Main API call
  Future<void> convert() async {
    if (!_validateInputs()) return;

    isLoading.value = true;

    try {
      final compactionFactor = getCompactionFactor();
      final truckCapacity = getTruckCapacity();

      final response = await _repo.calculateBackfill(
        length: plotLengthController.text,
        width: plotWidthController.text,
        depth: depthController.text,
        compactionFactor: compactionFactor.toString(),
        concreteVolume: totalConcreteController.text,
        truckCapacity: truckCapacity.toString(),
      );

      backFillCost.value = BackfillModel.fromJson(response);

    } catch (e) {
      log("❌ Error in convert: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
