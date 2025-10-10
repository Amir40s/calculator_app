import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/block_masonry_model/wall_block_model.dart';
import '../../../../config/model/cost_estimation_calcutor/final_cost_model.dart';
import '../../../../config/model/cost_estimation_calcutor/grey_structure_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../base_calculator_controller.dart';

class WallBlockMasonryController extends BaseCalculatorController<WallBlockModel> {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;
  final Rx<WallBlockModel?> blackMasonry = Rx<WallBlockModel?>(null);

  var wallHeight = TextEditingController();
  var wallLength = TextEditingController();
  var blockLength = TextEditingController();
  var blockHeight = TextEditingController();
  var blockWidth = TextEditingController();
  var joint = TextEditingController();
  var mortarRatio = TextEditingController();
  var waterCementRatio = TextEditingController();

  var isExpanded = false.obs;

  // Method to toggle the text state
  void toggleText() {
    isExpanded.value = !isExpanded.value;
  }
  // Fetch the data and update controller state
  Future<void> convert() async {
    setLoading(true);
    try {
      final response = await _repo.calculateWallBlock(

          wallHeight: wallHeight.text,
          wallLength: wallLength.text,
          blockLength: blockLength.text,
          blockHeight: blockHeight.text,
          blockWidth: blockWidth.text,
          joint: joint.text,
          mortarRatio: mortarRatio.text,
          waterCementRatio: waterCementRatio.text
      );

      // Assuming response is a map, parse it to your model
      blackMasonry.value = WallBlockModel.fromJson(response);

      // Optionally log or handle any specific data
      log("Fetched data: $response");

    } catch (e) {
      log("Error in convert: $e");
      Get.snackbar('Error', e.toString());
    } finally {
      setLoading(false);
    }
  }

}
