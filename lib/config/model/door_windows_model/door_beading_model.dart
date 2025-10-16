import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DoorBeadingWoodModel {
  final List<DoorShutterSimpleResult> results;
  final DoorBeadingWoodTotals totals;

  DoorBeadingWoodModel({
    required this.results,
    required this.totals,
  });

  factory DoorBeadingWoodModel.fromJson(Map<String, dynamic> json) {
    return DoorBeadingWoodModel(
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => DoorShutterSimpleResult.fromJson(e))
          .toList(),
      totals: DoorBeadingWoodTotals.fromJson(json['totals'] ?? {}),
    );
  }
}

class DoorShutterSimpleResult {
  final double totalFt3;

  DoorShutterSimpleResult({required this.totalFt3});

  factory DoorShutterSimpleResult.fromJson(Map<String, dynamic> json) {
    return DoorShutterSimpleResult(
      totalFt3: (json['totalFt3'] ?? 0).toDouble(),
    );
  }
}

class DoorBeadingWoodTotals {
  final double totalFt3;

  DoorBeadingWoodTotals({required this.totalFt3});

  factory DoorBeadingWoodTotals.fromJson(Map<String, dynamic> json) {
    return DoorBeadingWoodTotals(
      totalFt3: (json['totalFt3'] ?? 0).toDouble(),
    );
  }
}

class DoorBeadingModel {
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController beadingThicknessController = TextEditingController();
  final TextEditingController beadingWidthController = TextEditingController();
  final TextEditingController topRailController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();


  // 🔹 Each field gets its own dropdown value
  RxString selectedLengthUnit = 'Feet (ft)'.obs;
  RxString selectedWidthUnit = 'Feet (ft)'.obs;
  RxString selectedBeadingThicknessUnit = 'Inches (in)'.obs;
  RxString selectedBeadingWidthUnit = 'Inches (in)'.obs;
}
extension DoorBeadingModelToJson on DoorBeadingModel {
  String extractUnit(String fullUnit) {
    if (fullUnit.contains('(in)')) return 'inch';
    if (fullUnit.contains('(ft)')) return 'feet';
    if (fullUnit.contains('(cm)')) return 'cm';
    if (fullUnit.contains('(mm)')) return 'mm';
    return fullUnit;
  }
  Map<String, dynamic> toJson(int id) {
    return {
      "beadingThickness": double.tryParse(beadingThicknessController.text) ?? 0,
      "beadingThicknessUnit": extractUnit(selectedBeadingThicknessUnit.value),
      "beadingWidth": double.tryParse(beadingWidthController.text) ?? 0,
      "beadingWidthUnit": extractUnit(selectedBeadingWidthUnit.value),
      "doorLength": double.tryParse(lengthController.text) ?? 0,
      "doorLengthUnit": extractUnit(selectedLengthUnit.value),
      "doorWidth": double.tryParse(widthController.text) ?? 0,
      "doorWidthUnit": extractUnit(selectedWidthUnit.value),
      "quantity": int.tryParse(quantityController.text) ?? 1,
      "id": id,
    };
  }
}