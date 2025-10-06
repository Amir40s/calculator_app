import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/area_conversion.dart';
import '../../../../config/model/conversion_calculator/length_conversion_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class AreaConversionController
    extends BaseCalculatorController<AreaConversionModel> {
  final _repo = CalculatorRepository();

  // for length/distance
  final RxString selectedUnit = 'mm2'.obs;
  final RxString inputValue = ''.obs;

  /// Default units (can also be replaced dynamically from API)
  final RxList<String> availableUnits = <String>[
    "mm2",
    "cm2",
    "m2",
    "ha",
    "km2",
    "in2",
    "ft2",
    "yd2",
    "acre",
    "mi2",
  ].obs;
  Future<void> convertArea() async {
    setLoading(true);
    try {
      final response = await _repo.convertArea(
        value: double.tryParse(inputValue.value) ?? 0.0,
        fromUnit: selectedUnit.value,
      );
      // Parse JSON into model
      setData(AreaConversionModel.fromJson(response));
    } catch (e) {
      log("Error in convertLength: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
    }
  }

  void setValue(String value) => inputValue.value = value;
  void setUnit(String value) => selectedUnit.value = value;
}
