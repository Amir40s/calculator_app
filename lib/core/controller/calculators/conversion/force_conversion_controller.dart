import 'dart:developer';

import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/temperature_conversion_model.dart';

import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class ForceConversionController extends BaseCalculatorController<TemperatureConversionModel> {
  final  _repo = CalculatorRepository();


  final RxString selectedUnit = 'N'.obs;
  final RxString inputValue = ''.obs;

  final List<String> availableUnits = [
    "N",
    "kN",
    "dyn",
    "gf",
    "kgf",
    "lbf",
    "kip"
  ].obs;

  Future<void> convert() async {
    setLoading(true);
    try {
      final response = await _repo.convertForce(
        value: double.tryParse(inputValue.value) ?? 0.0,
        fromUnit: selectedUnit.value,
      );
      // Parse JSON into model
      setData(TemperatureConversionModel.fromJson(response));
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
