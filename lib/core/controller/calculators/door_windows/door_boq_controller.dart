import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../config/model/door_windows_model/door_boq_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class DoorBoqController extends GetxController{
  final _repo = CalculatorRepository();
  var result = Rxn<DoorBoqModel>();
  var isLoading = false.obs;
  final noOfSolidDoorsController = TextEditingController();
  final noOfNetDoorsController = TextEditingController();
  final heightController = TextEditingController();
  final widthController = TextEditingController();

  RxString selectedLockType = 'Mortise Lock'.obs;

  final RxList<String> measuringType = RxList<String>([
    "Mortise Lock",
    "Cylindrical Lockset",
  ]);

  void convert() async {
    try {
      isLoading.value = true;

      final body = {
        "solidDoors": [
          {
            "id": "0",
            "count": noOfSolidDoorsController.text,
            "lockType": selectedLockType.value,
          }
        ],
        "netDoors": [
          {
            "id": "0",
            "count": noOfNetDoorsController.text,
            "height": heightController.text,
            "width": widthController.text,
          }
        ],
      };

      final res = await _repo.calculateDoorBoq(body: body);

      result.value = DoorBoqModel.fromJson(res);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error: $e");
    }
  }


}