import 'dart:developer';
import 'package:get/get.dart';
import '../../../../config/model/cost_estimation_calcutor/final_cost_model.dart';
import '../../../../config/model/cost_estimation_calcutor/grey_structure_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class FinishingCostController extends BaseCalculatorController<FinalCostModel> {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;
  final isFinished = false.obs;

  final Rx<FinalCostModel?> finishingCostData = Rx<FinalCostModel?>(null);

  final RxString selectedQuality = 'normal'.obs;
  final RxString inputValue = ''.obs;

  final RxList<String> availableQuality = RxList<String>(["normal", "superior"]);

  void onUnitChanged(String value) {
    selectedQuality.value = value;
  }

  // Fetch the data and update controller state
  Future<void> convert() async {
    setLoading(true);
    isFinished.value = false;

    try {
      final response = await _repo.calculateFinishingCost(
        coveredArea: double.parse(inputValue.value),
        quality: selectedQuality.value,
      );

      // Assuming response is a map, parse it to your model
      finishingCostData.value = FinalCostModel.fromJson(response);

      // Optionally log or handle any specific data
      log("Fetched data: $response");

    } catch (e) {
      log("Error in convert: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
      isFinished.value = true;

    }
  }

  void setValue(String value) => inputValue.value = value;
}
