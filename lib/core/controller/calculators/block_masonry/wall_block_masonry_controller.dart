import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/block_masonry_model/wall_block_model.dart';
import '../../../../config/model/cost_estimation_calcutor/final_cost_model.dart';
import '../../../../config/model/cost_estimation_calcutor/grey_structure_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class WallBlockMasonryController
    extends BaseCalculatorController<WallBlockModel> {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;
  RxList<WallModel> walls = <WallModel>[WallModel()].obs;
  final Rx<WallBlockModel?> blackMasonry = Rx<WallBlockModel?>(null);
  void addWall() {
    walls.add(WallModel());
  }

  void addWindow(int wallIndex) {
    walls[wallIndex].windows.add(WindowDoorModel());
  }

  void removeWindow(int wallIndex, int windowIndex) {
    if (walls[wallIndex].windows.length > 1) {
      walls[wallIndex].windows.removeAt(windowIndex);
    }
  }

  void addDoor(int wallIndex) {
    walls[wallIndex].doors.add(WindowDoorModel());
  }

  void removeDoor(int wallIndex, int doorIndex) {
    if (walls[wallIndex].doors.length > 1) {
      walls[wallIndex].doors.removeAt(doorIndex);
    }
  }

  void removeWall(int index) {
    if (walls.length > 1) {
      walls.removeAt(index);
    } else {
      Get.snackbar("Warning", "At least one wall is required.");
    }
  }

  var isExpanded = false.obs;

  void toggleText() {
    isExpanded.value = !isExpanded.value;
  }

  Future<void> convert() async {
    setLoading(true);
    try {
      final wallsList = walls.map((wall) {
        final validWindows = wall.windows
            .where((w) =>
        w.width.text.trim().isNotEmpty && w.height.text.trim().isNotEmpty)
            .map((w) => {
          "width": w.width.text.trim(),
          "height": w.height.text.trim(),
        })
            .toList();

        // Filter out empty doors
        final validDoors = wall.doors
            .where((d) =>
        d.width.text.trim().isNotEmpty && d.height.text.trim().isNotEmpty)
            .map((d) => {
          "width": d.width.text.trim(),
          "height": d.height.text.trim(),
        })
            .toList();

        // Construct each wall map
        return {
          "id": wall.id,
          "tag": wall.tag.text.trim(),
          "grid": wall.grid.text.trim(),
          "wallHeight": wall.wallHeight.text.trim(),
          "wallLength": wall.wallLength.text.trim(),
          "blockLength": wall.blockLength.text.trim(),
          "blockHeight": wall.blockHeight.text.trim(),
          "blockWidth": wall.blockWidth.text.trim(),
          "joint": wall.joint.text.trim(),
          "mortarRatio": wall.mortarRatio.text.trim(),
          "waterCementRatio": wall.waterCementRatio.text.trim(),
          "windows": validWindows,
          "doors": validDoors,
        };
      }).toList();

      final body = {"walls": wallsList};

      log("📦 POST BODY: $body");

      final response = await _repo.calculateWallBlock(body: body);
      blackMasonry.value = WallBlockModel.fromJson(response);

      log("✅ API Response: $response");
    } catch (e) {
      log("❌ Error in convert: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
    }
  }
}
