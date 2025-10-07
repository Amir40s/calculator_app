import 'dart:developer';
import 'package:get/get.dart';
import '../../../../config/base/base_url.dart';
import '../../../../config/model/cost_estimation_calcutor/grey_structure_model.dart';
import '../../../../config/network/api_services.dart';

class GreyStructureController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxBool isLoading = false.obs;
  final Rx<GreyStructureModel?> greyData = Rx<GreyStructureModel?>(null);

  final RxDouble builtupArea = 0.0.obs;

  /// 🔹 Set user input
  void setBuiltupArea(String value) {
    builtupArea.value = double.tryParse(value) ?? 0.0;
  }

  /// 🔹 Fetch Grey Structure Data
  Future<void> fetchGreyStructureData() async {
    if (builtupArea.value <= 0) {
      Get.snackbar("Invalid Input", "Please enter a valid area.");
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        "area": builtupArea.value,
      };

      final response = await _apiService.postApi(
        url: Endpoint.greyStructure,
        data: body,
      );

      greyData.value = GreyStructureModel.fromJson(response);
    } catch (e, s) {
      log('Error in fetchGreyStructureData: $e\n$s');
    } finally {
      isLoading.value = false;
    }
  }
}
