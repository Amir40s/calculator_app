import 'dart:developer';

import 'package:get/get.dart';

import '../../../../config/model/conversion_calculator/concrete_mix_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class ConcreteConversionController extends BaseCalculatorController<ConcreteMixModel> {

  ConcreteConversionController();
  final  _repo = CalculatorRepository();

  final RxString selectedUnit = '1:5:10'.obs;
  final RxString inputValue = ''.obs;

final RxList<String> availableUnits = <String>[
    "1:5:10",
    "1:4:8",
    "1:3:6",
    "1:2:4",
    "1:1.5:3",
    "1:1:2",
    "1:0.75:1.5",
    "1:0.5:1",
  ].obs;
  Future<void> convert() async {
    setLoading(true);

    try {
      final result = await _repo.convertConcreteMix(
        value: double.tryParse(inputValue.value) ?? 0.0,
        fromUnit: selectedUnit.value,
      );

      setData(ConcreteMixModel.fromJson(result));
    } catch (e) {
      log("Error in convertLength: $e");
      Get.snackbar('Error', e.toString());    } finally {
      setLoading(false);
    }
  }
  void setValue(String value) => inputValue.value = value;
  void setUnit(String value) => selectedUnit.value = value;

}
