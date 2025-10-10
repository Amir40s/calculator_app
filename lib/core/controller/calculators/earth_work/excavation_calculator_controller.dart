import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/model/earth_cost/excavation_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class ExcavationCalculatorController extends BaseCalculatorController<ExcavationModel> {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;
  final RxBool isFinished = false.obs;

  final Rx<ExcavationModel?> finishingCostData = Rx<ExcavationModel?>(null);

  // Dropdown for showing cubic yards
  final RxString selectedQuality = 'yes'.obs;
  final RxList<String> availableQuality = RxList<String>(["yes", "no"]);

  // Checkbox for using extensions
  final RxBool isChecked = false.obs;

  // Controllers for user input
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController depthController = TextEditingController();
  final TextEditingController lengthExtensionController = TextEditingController();
  final TextEditingController widthExtensionController = TextEditingController();

  // 🔹 Update dropdown
  void onUnitChanged(String value) {
    selectedQuality.value = value;
  }

  // 🔹 Toggle checkbox
  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }

  // ✅ Input Validation
  bool _validateInputs() {
    if (lengthController.text.isEmpty ||
        widthController.text.isEmpty ||
        depthController.text.isEmpty) {
      Get.snackbar(
        'Missing Fields',
        'Please fill Length, Width, and Depth values.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Optional check for extensions only if checkbox is checked
    if (isChecked.value &&
        (lengthExtensionController.text.isEmpty ||
            widthExtensionController.text.isEmpty)) {
      Get.snackbar(
        'Missing Extensions',
        'Please fill Length Extension and Width Extension values.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  // ✅ Main conversion logic
  Future<void> convert() async {
    if (!_validateInputs()) return; // stop if validation fails

    setLoading(true);
    isFinished.value = false;

    try {
      final response = await _repo.calculateExcavation(
        height: heightController.text,
        length: lengthController.text,
        depth: depthController.text,
        lengthExtension: lengthExtensionController.text,
        widthExtension: widthExtensionController.text,
        width: widthController.text,
        showCubicYards: selectedQuality.value == "yes", // ✅ convert string → bool
        useExtensions: isChecked.value, // ✅ checkbox → bool
      );

      finishingCostData.value = ExcavationModel.fromJson(response);
      log("✅ Excavation Data Response: $response");

    } catch (e) {
      log("❌ Error in convert: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
      isFinished.value = true;
    }
  }
}
