import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/model/door_windows_model/door_shutter_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';



class DoorShutterWoodController extends GetxController {
  final _repo = CalculatorRepository();
  var result = Rxn<DoorShutterModel>();
  var isLoading = false.obs;

  final TextEditingController priceController = TextEditingController();

  // Master door list
  final RxList<DoorItemModel> doors = <DoorItemModel>[DoorItemModel()].obs;

  // Static options
  final RxList<String> doorTypes = RxList<String>(["Solid", "Net"]);
  final RxList<String> measuringType = RxList<String>([
    "Inches (in)",
    "Feet (ft)",
  ]);

  // --- FUNCTIONS ---
  void addDoor() {
    doors.add(DoorItemModel());
  }

  void removeDoor(int index) {
    if (doors.length > 1) {
      doors.removeAt(index);
    }
  }

  Future<void> calculateVolume() async {
    try {
      isLoading.value = true;

      final body = {
        "doors": doors.map((door) => door.toJson()).toList(),
      };

      final res = await _repo.calculateDoorShutterWood(body: body);

      result.value = DoorShutterModel.fromJson(res);

    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
