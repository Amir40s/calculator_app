import 'package:get/get.dart';
import '../../../../config/model/cost_estimation_calcutor/final_cost_model.dart';
import '../../../../config/model/cost_estimation_calcutor/grey_structure_model.dart';
import 'grey_structure_controller.dart';
import 'finishing_cost_controller.dart';

class CostEstimationController extends GetxController {
  final greyController = Get.put(GreyStructureController());
  final finishController = Get.put(FinishingCostController());

  // Combined reactive values
  var isLoading = false.obs;
  var isFinished = false.obs;
  final RxDouble builtupArea = 0.0.obs;

  final Rx<GreyStructureModel?> greyData = Rx<GreyStructureModel?>(null);
  final Rx<FinalCostModel?> finishingCostData = Rx<FinalCostModel?>(null);
  var combinedTotal = 0.0.obs;

  // Expose text controllers from greyController
  get cementRate => greyController.cementRate;
  get aggregateRate => greyController.aggregateRate;
  get sandRate => greyController.sandRate;
  get waterRate => greyController.waterRate;
  get steelRate => greyController.steelRate;
  get blockRate => greyController.blockRate;

  // Dropdown values from finishing controller
  get selectedQuality => finishController.selectedQuality;
  get availableQuality => finishController.availableQuality;
  void onQualityChanged(String? value) => finishController.onUnitChanged(value!);

  void setBuiltupArea(String value) {
    builtupArea.value = double.tryParse(value) ?? 0.0;
  }
  Future<void> fetchCombinedData() async {
    try {
      isLoading.value = true;
      isFinished.value = false;
      greyController.builtupArea.value = builtupArea.value;
      finishController.inputValue.value = builtupArea.value.toString();

      await Future.wait([
        greyController.fetchGreyStructureData(),
        finishController.convert(),
      ]);

      greyData.value = greyController.greyData.value;
      finishingCostData.value = finishController.finishingCostData.value;
      if (greyData.value != null && finishingCostData.value != null) {
        combinedTotal.value =
            (greyData.value!.totalCost + finishingCostData.value!.total);
      }

      isFinished.value = true;
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
