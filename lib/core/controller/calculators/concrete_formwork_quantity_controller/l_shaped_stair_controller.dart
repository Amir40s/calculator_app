import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/model/concrete_form_quantity/l_shaped_stair_result_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class LShapedStairController extends GetxController {
  // Text controllers
  final totalRisersController = TextEditingController();
  final riserHeightController = TextEditingController();
  final treadLengthController = TextEditingController();
  final stairWidthController = TextEditingController();
  final winderStepsController = TextEditingController();
  final waistSlabThicknessController = TextEditingController();
  final landingSlabLengthController = TextEditingController();
  final landingSlabThicknessController = TextEditingController();

  final cementController = TextEditingController();
  final sandController = TextEditingController();
  final crushController = TextEditingController();

  // Checkboxes and computed results
  var includeWinderSteps = false.obs;

  // Example calculated result (can expand later)
  var totalConcreteVolume = Rxn<LShapedStairResultModel>();
  final _repo = CalculatorRepository();
  var isLoading = false.obs;
  void toggleIncludeWinder(bool? value) {
    includeWinderSteps.value = value ?? false;
  }

  void calculate() async {
    try {
      // Prepare payload
      final body = {
        "cementRatio": cementController.text,
        "crushRatio": crushController.text,
        "includeWinders": includeWinderSteps.value,
        "landingLength": landingSlabLengthController.text,
        "landingThickness": landingSlabThicknessController.text,
        "riserHeight": riserHeightController.text,
        "sandRatio": sandController.text,
        "risers": totalRisersController.text,
        "slabThickness": waistSlabThicknessController.text,
        "treadLength": treadLengthController.text,
        "width": stairWidthController.text,
        "winderSteps": winderStepsController.text,
      };

      log("📦 POST DATA: $body");

      // 🚀 API call
      final res = await _repo.calculateLShapedStair(body: body);

      // Validate response
      if (res == null || res.isEmpty) {
        Get.snackbar("Error", "Empty response from server");
        return;
      }

      // Parse into model
      totalConcreteVolume.value = LShapedStairResultModel.fromJson(res);

      log("✅ Calculation Success: ${totalConcreteVolume.value!.waterLiters}");

    } catch (e, s) {
      log("❌ Error in calculate(): $e", stackTrace: s);
      Get.snackbar(
        "Calculation Failed",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.onErrorContainer,
      );
    }
  }

  @override
  void onClose() {
    totalRisersController.dispose();
    riserHeightController.dispose();
    treadLengthController.dispose();
    stairWidthController.dispose();
    winderStepsController.dispose();
    waistSlabThicknessController.dispose();
    landingSlabLengthController.dispose();
    landingSlabThicknessController.dispose();
    cementController.dispose();
    sandController.dispose();
    crushController.dispose();
    super.onClose();
  }
}
