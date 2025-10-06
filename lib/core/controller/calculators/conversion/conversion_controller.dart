import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../../config/model/conversion_calculator/length_conversion_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';


class ConversionController extends BaseCalculatorController<LengthConversionModel> {
  final  _repo = CalculatorRepository();

// for length/distance
  final RxString selectedUnit = 'ft'.obs;
  final RxString inputValue = ''.obs;

  /// Default units (can also be replaced dynamically from API)
  final RxList<String> availableUnits = <String>[
    'mm', 'cm', 'm', 'km', 'in', 'ft', 'yd', 'mi'
  ].obs;
  Future<void> convertLength() async {
    setLoading(true);
    try {
      final response = await _repo.convertLength(
        value: double.tryParse(inputValue.value) ?? 0.0,
        fromUnit: selectedUnit.value,
      );
      // Parse JSON into model
      setData(LengthConversionModel.fromJson(response));
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
