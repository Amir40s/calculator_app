import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/volume_conversion_model.dart';

import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';


class VolumeConversionController extends BaseCalculatorController<VolumeConversionModel> {
  final  _repo = CalculatorRepository();


  final RxString selectedVolumeUnit = 'mm3'.obs;
  final RxString inputVolumeValue = ''.obs;

  /// Default units (can also be replaced dynamically from API)
  final RxList<String> availableVolumeUnits = <String> [
    "mm3",
    "cm3",
    "m3",
    "l",
    "ml",
    "in3",
    "ft3",
    "yd3",
    "gal",
    "qt"
  ].obs;
  Future<void> convertVolume() async {
    setLoading(true);
    try {
      final response = await _repo.convertVolume(
        value: double.tryParse(inputVolumeValue.value) ?? 0.0,
        fromUnit: selectedVolumeUnit.value,
      );
      // Parse JSON into model
      setData(VolumeConversionModel.fromJson(response));
    } catch (e) {
      log("Error in convertLength: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
    }
  }

  void setVolumeValue(String value) => inputVolumeValue.value = value;
  void setVolumeUnit(String value) => selectedVolumeUnit.value = value;


}
