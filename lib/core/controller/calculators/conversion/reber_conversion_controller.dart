import 'dart:developer';

import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/density_conversion_model.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/temperature_conversion_model.dart';

import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class RebarConversionController extends BaseCalculatorController<DensityConversionModel> {
  final  _repo = CalculatorRepository();


  final RxString selectedUnit = 'kgm3'.obs;
  final RxString inputValue = ''.obs;

  final List<String> availableUnits = [
    "kgm3",
    "gcm3",
    "gm3",
    "lbft3",
    "lbgal",
    "slugft3"
  ].obs;

  Future<void> convert() async {
    setLoading(true);
    try {
      final response = await _repo.convertRebar(
        value: double.tryParse(inputValue.value) ?? 0.0,
        fromUnit: selectedUnit.value,
      );
      // Parse JSON into model
      setData(DensityConversionModel.fromJson(response));
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
