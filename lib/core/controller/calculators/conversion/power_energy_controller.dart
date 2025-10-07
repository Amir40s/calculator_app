import 'dart:developer';

import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/density_conversion_model.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/temperature_conversion_model.dart';

import '../../../../config/model/conversion_calculator/power_energy_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class PowerEnergyConversionController extends BaseCalculatorController<PowerEnergyModel> {
  final  _repo = CalculatorRepository();


  final RxString selectedUnit = 'W'.obs;
  final RxString inputValue = ''.obs;

  final List<String> availableUnits = [
    "W",
    "kW",
    "MW",
    "J",
    "MJ",
    "cal",
    "kcal",
    "Wh",
    "kWh",
  ].obs;

  Future<void> convert() async {
    setLoading(true);
    try {
      final response = await _repo.convertPowerEnergy(
        value: double.tryParse(inputValue.value) ?? 0.0,
        fromUnit: selectedUnit.value.toLowerCase(),
      );
      // Parse JSON into model
      setData(PowerEnergyModel.fromJson(response));
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
