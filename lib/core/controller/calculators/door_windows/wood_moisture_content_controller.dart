import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../config/model/door_windows_model/door_boq_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class WoodMoistureContentController extends GetxController{
  final _repo = CalculatorRepository();
  var isLoading = false.obs;
  var result = RxnString();
  final dryWeightController = TextEditingController();
  final wetWeightController = TextEditingController();



  void convert() async {
    try {
      isLoading.value = true;

      final body = {
        "samples": [
          {
            "id": "0",
            "dryWeight": dryWeightController.text,
            "wetWeight": wetWeightController.text,
          }
        ],

      };

      final res = await _repo.calculateWoodMoisture(body: body);
      if (res['results'] != null && res['results'] is List && res['results'].isNotEmpty) {
        result.value = res['results'][0].toString();
      } else {
        result.value = "No result";
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error: $e");
    }
  }


}