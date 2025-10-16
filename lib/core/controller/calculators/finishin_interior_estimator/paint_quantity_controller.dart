import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/model/finishing_interior_estimate/paint_quantity_model.dart';
import '../../../../config/repository/calculator_repository.dart';

class PaintQuantityController extends GetxController {
  final _repo = CalculatorRepository();

  /// List of wall inputs (reactive)
  var walls = <WallInput>[].obs;
  var result = Rxn<PaintQuantityModel>();


  /// Dropdown values
  final RxList<String> typeList = RxList(["Internal Wall", "External Wall", "Roof"]);
  final RxList<String> paintType = RxList(["SPD", "Emulsion"]);

  /// Loading & API result
  var isLoading = false.obs;

  /// Constructor — initialize with 1 wall
  PaintQuantityController() {
    addWall();
  }

  void addWall() {
    final wall = WallInput(
      tagController: TextEditingController(),
      heightController: TextEditingController(),
      widthController: TextEditingController(),
      noOfWindowsController: TextEditingController(),
      noOfDoorsController: TextEditingController(),
      noOfPrimeController: TextEditingController(),
      noOfPuttyController: TextEditingController(),
      noOfPaintController: TextEditingController(),
      selectedPaintType: 'Emulsion'.obs,
      selectedType: 'Internal Wall'.obs,
    );

    wall.tagController.text = "Wall ${walls.length + 1}";

    /// Attach listeners for dynamic fields
    wall.noOfWindowsController.addListener(() {
      updateWindows(wall, wall.noOfWindowsController.text);
    });
    wall.noOfDoorsController.addListener(() {
      updateDoors(wall, wall.noOfDoorsController.text);
    });

    walls.add(wall);
  }

  /// Remove a wall
  void removeWall(int index) {
    if (index >= 0 && index < walls.length) {
      walls.removeAt(index);

      // Re-number remaining wall tags
      for (int i = 0; i < walls.length; i++) {
        walls[i].tagController.text = "Wall ${i + 1}";
      }
    }
  }

  /// Update window fields dynamically based on count input
  void updateWindows(WallInput wall, String value) {
    int count = int.tryParse(value) ?? 0;

    // Clear previous fields
    wall.windowFields.clear();

    // Add new fields
    for (int i = 0; i < count; i++) {
      wall.windowFields.add({
        'length': TextEditingController(),
        'width': TextEditingController(),
      });
    }
  }

  /// Update door fields dynamically based on count input
  void updateDoors(WallInput wall, String value) {
    int count = int.tryParse(value) ?? 0;

    wall.doorFields.clear();

    for (int i = 0; i < count; i++) {
      wall.doorFields.add({
        'length': TextEditingController(),
        'width': TextEditingController(),
      });
    }
  }

  void convert() async {
    try {
      isLoading.value = true;
      final body = {
        "walls": walls.map((wall) {
          String wallType = wall.selectedType.value
              .replaceAll('Wall', '')
              .trim()
              .toLowerCase();
          log(wall.selectedType.value.toLowerCase());
          return {
            "tag": wall.tagController.text,
            "wallType": wallType,
            "wallLength": double.tryParse(wall.heightController.text) ?? 0,
            "wallHeight": double.tryParse(wall.widthController.text) ?? 0,
            "windowCount": int.tryParse(wall.noOfWindowsController.text) ?? 0,
            "doorCount": int.tryParse(wall.noOfDoorsController.text) ?? 0,
            "primerCoats": int.tryParse(wall.noOfPrimeController.text) ?? 0,
            "puttyCoats": int.tryParse(wall.noOfPuttyController.text) ?? 0,
            "paintCoats": int.tryParse(wall.noOfPaintController.text) ?? 0,
            "paintType": wall.selectedPaintType.value,
            "windows": wall.windowFields.map((f) {
              return {
                "width": double.tryParse(f['width']!.text) ?? 0,
                "height": double.tryParse(f['length']!.text) ?? 0,
              };
            }).toList(),
            "doors": wall.doorFields.map((f) {
              return {
                "width": double.tryParse(f['width']!.text) ?? 0,
                "height": double.tryParse(f['length']!.text) ?? 0,
              };
            }).toList(),
          };
        }).toList(),
      };

      final res = await _repo.calculatePaintQuantity(body: body);

      result.value = PaintQuantityModel.fromJson(res);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error in convert(): $e");
    }
  }
}
