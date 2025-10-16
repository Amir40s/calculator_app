import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/model/door_windows_model/door_beading_model.dart';
import '../../../../config/model/door_windows_model/door_shutter_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';



class DoorBeadingWoodController extends GetxController {
  final _repo = CalculatorRepository();
  var result = Rxn<DoorBeadingWoodModel>();
  var isLoading = false.obs;

  final TextEditingController priceController = TextEditingController();

  // Master door list
  final RxList<DoorBeadingModel> doors = <DoorBeadingModel>[DoorBeadingModel()].obs;

  // Static options
  final RxList<String> measuringType = RxList<String>([
    "Inches (in)",
    "Feet (ft)",
    "Centimeters (cm)",
  ]);
  final RxList<String> measuringType2 = RxList<String>([
    "Inches (in)",
    "Feet (ft)",
    "Centimeters (cm)",
    "Millimeters (mm)",
  ]);

  // --- FUNCTIONS ---
  void addDoor() {
    doors.add(DoorBeadingModel());
  }

  void removeDoor(int index) {
    if (doors.length > 1) {
      doors.removeAt(index);
    }
  }

  Future<void> calculateBeading() async {
    try {
      isLoading.value = true;

      final body = {
        "doors": doors.asMap().entries.map((entry) {
          final index = entry.key;
          final door = entry.value;
          return door.toJson(index);
        }).toList(),
      };

      log("body of beading is${body.toString()}");

      final res = await _repo.calculateDoorBeadingWood(body: body);
      result.value = DoorBeadingWoodModel.fromJson(res);
      for (var door in result.value!.results) {
        print("Door Volume: ${door.totalFt3}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
