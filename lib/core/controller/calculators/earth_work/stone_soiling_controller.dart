import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';

import '../../../../config/model/earth_cost/stone_soiling_model.dart';

class StoneSoilingController extends GetxController {
  final _repo = CalculatorRepository();

  final RxBool isLoading = false.obs;

  final RxList<Map<String, TextEditingController>> areas = <Map<String, TextEditingController>>[].obs;

  final Rx<StoneSoilingResponse?> result = Rx<StoneSoilingResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    addArea(); // Start with one area
  }

  void addArea() {
    areas.add({
      'name': TextEditingController(),
      'length': TextEditingController(),
      'width': TextEditingController(),
      'thickness': TextEditingController(),
    });
  }
  void removeArea(int index) {
    if (areas.length > 1) {
      areas.removeAt(index);
      update();
    } else {
      Get.snackbar("Warning", "At least one area is required");
    }
  }

  Future<void> calculate() async {
    if (areas.isEmpty) {
      Get.snackbar('Error', 'Please add at least one area');
      return;
    }

    final List<Map<String, dynamic>> areaList = [];

    for (var area in areas) {
      final name = area['name']!.text.trim();
      final length = double.tryParse(area['length']!.text) ?? 0;
      final width = double.tryParse(area['width']!.text) ?? 0;
      final thickness = double.tryParse(area['thickness']!.text) ?? 0;

      if (name.isEmpty || length <= 0 || width <= 0 || thickness <= 0) {
        Get.snackbar('Error', 'Please fill all fields for each area correctly.');
        return;
      }

      areaList.add({
        "name": name,
        "length": length.toString(),
        "width": width.toString(),
        "thicknessInches": thickness.toString(),
      });
    }

    final payload = {"areas": areaList};

    try {
      isLoading.value = true;
      final response = await _repo.calculateStoneSoiling(body: payload);

      if (response['success'] == true) {
        result.value = StoneSoilingResponse.fromJson(response);
      } else {
        Get.snackbar('Error', 'Invalid response from server.');
      }
    } catch (e, st) {
      log("❌ Error: $e\n$st");
      Get.snackbar('Error', 'Something went wrong during calculation');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    for (var area in areas) {
      area.values.forEach((c) => c.dispose());
    }
    super.onClose();
  }
}
