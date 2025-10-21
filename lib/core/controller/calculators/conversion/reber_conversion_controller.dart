import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/density_conversion_model.dart';
import '../../../../config/model/conversion_calculator/reber_conversion_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class RebarConversionController
    extends BaseCalculatorController<RebarConversionModel> {
  final _repo = CalculatorRepository();

  // 🔹 Reactive state
  final RxString selectedInput = 'Standard Rebar Size (#2 - #10)'.obs;
  final RxString selectedDiameterInput = 'mm'.obs;
  final RxString selectedInput2 = '#2'.obs;
  final RxString inputValue = ''.obs;
  final customDiameterController = TextEditingController();

  // 🔹 Lists should be RxList, not List
  final RxList<String> inputType = [
    "Standard Rebar Size (#2 - #10)",
    "Custom Diameter",
  ].obs;

  final RxList<String> inputDiameterType = [
    "mm",
    "inch",
  ].obs;

  final RxList<String> inputType2 = [
    "#2",
    "#3",
    "#4",
    "#5",
    "#6",
    "#7",
    "#8",
    "#9",
    "#10",
  ].obs;

  // 🔹 Logic
  Future<void> convert() async {
    setLoading(true);
    try {
      final body = {
        "lengthFt": double.tryParse(inputValue.value.toString()) ?? 0.0,
        "customDiameter": double.tryParse(customDiameterController?.text ?? "") ?? 0.0,
        "customUnit": selectedDiameterInput.value,
        "rebarSize": selectedInput2.value,
        "mode": selectedInput.value == "Custom Diameter" ? "custom" : "standard",
      };


      final response = await _repo.convertRebar(body: body);
      log("body is $body");

      setData(RebarConversionModel.fromJson(response));
    } catch (e) {
      log("Error in convertRebar: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
    }
  }

  void setValue(String value) => inputValue.value = value;
  void setUnit(String value) => selectedInput.value = value;
}
