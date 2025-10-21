import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/block_masonry_model/wall_plaster_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class WallRoofPlasterController extends BaseCalculatorController<WallPlasterModel> {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;

  RxList<WallPlasterDynamic> walls = <WallPlasterDynamic>[WallPlasterDynamic()].obs;
  final Rx<WallPlasterModel?> blackMasonry = Rx<WallPlasterModel?>(null);

  final RxString selectedType = 'Wall'.obs;
  final RxList<String> typeItems = RxList<String>(['Wall', 'Roof']);

  var isExpanded = false.obs;

  void toggleText() => isExpanded.value = !isExpanded.value;

  void addWall() => walls.add(WallPlasterDynamic());

  void removeWall(int index) {
    if (walls.length > 1) {
      walls.removeAt(index);
    } else {
      Get.snackbar("Warning", "At least one wall is required.");
    }
  }

  void addWindow(int wallIndex) => walls[wallIndex].windows.add(WindowPlasterModel());

  void removeWindow(int wallIndex, int windowIndex) {
    if (walls[wallIndex].windows.isNotEmpty) {
      walls[wallIndex].windows.removeAt(windowIndex);
    }
  }

  void addDoor(int wallIndex) => walls[wallIndex].doors.add(WindowPlasterModel());

  void removeDoor(int wallIndex, int doorIndex) {
    if (walls[wallIndex].doors.isNotEmpty) {
      walls[wallIndex].doors.removeAt(doorIndex);
    }
  }

  Future<void> convert() async {
    setLoading(true);
    try {
      final wallsList = walls.map((wall) {
        final validWindows = wall.windows
            .where((w) => w.width.text.trim().isNotEmpty && w.height.text.trim().isNotEmpty)
            .map((w) => {"width": w.width.text.trim(), "height": w.height.text.trim()})
            .toList();

        final validDoors = wall.doors
            .where((d) => d.width.text.trim().isNotEmpty && d.height.text.trim().isNotEmpty)
            .map((d) => {"width": d.width.text.trim(), "height": d.height.text.trim()})
            .toList();

        return {
          "id" : wall.id,
          "type": wall.selectedType.value.toLowerCase(),
          "tag": wall.tag.text.trim(),
          "grid": wall.grid.text.trim(),
          "height": wall.wallHeight.text.trim(),
          "length": wall.wallLength.text.trim(),
          "plasterThickness": wall.plasterThickness.text.trim(),
          "mortarRatio": wall.mortarRatio.text.trim(),
          "wallThickness": wall.wallThickness.text.trim(),
          "waterCementRatio": wall.waterCementRatio.text.trim(),
          "windows": validWindows,
          "doors": validDoors,
        };
      }).toList();

      final body = {"walls": wallsList};
      log("📦 POST BODY: $body");

      final response = await _repo.calculateWallPlaster(body: body);
      blackMasonry.value = WallPlasterModel.fromJson(response);

      log("✅ API Response Parsed Successfully");
    } catch (e) {
      log("❌ Error in convert(): $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
    }
  }
}
