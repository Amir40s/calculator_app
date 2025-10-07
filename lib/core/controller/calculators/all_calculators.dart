import 'dart:developer';
import 'package:get/get.dart';
import '../../../config/model/conversion_calculator/all_calculator_model.dart';
import '../../../config/repository/calculator_repository.dart';
import '../base_calculator_controller.dart';

class CalculatorController extends BaseCalculatorController<List<CalculatorModel>> {
  final _repo = CalculatorRepository();
  /// Fetch all calculators
  Future<void> fetchCalculators() async {
    setLoading(true);

    try {
      final response = await _repo.getAllCalculators();

      final calculators = (response as List)
          .map((item) => CalculatorModel.fromMap(item))
          .toList();

      setData(calculators);
      log("Fetched ${calculators.length} calculators");
    } catch (e) {
      log("Error fetching calculators: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
    }
  }
}
