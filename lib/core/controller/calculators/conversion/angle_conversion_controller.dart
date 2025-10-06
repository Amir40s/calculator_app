import 'dart:developer';

import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/temperature_conversion_model.dart';

import '../../../../config/model/conversion_calculator/angle_conversion_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class AngleConversionController extends BaseCalculatorController<AngleConversionModel> {
  final  _repo = CalculatorRepository();


  final RxString selectedUnit = 'deg'.obs;
  final RxString inputValue = ''.obs;

  final List<String> availableUnits = [
    "deg",
    "rad",
    "grad",
    "arcmin",
    "arcsec"
  ].obs;

  Future<void> convert() async {
    setLoading(true);
    try {
      final response = await _repo.convertAngle(
        value: double.tryParse(inputValue.value) ?? 0.0,
        fromUnit: selectedUnit.value,
      );
      // Parse JSON into model
      setData(AngleConversionModel.fromJson(response));
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
