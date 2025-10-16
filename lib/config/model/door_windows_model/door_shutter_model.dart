import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoorShutterModel {
  final List<DoorShutterResult> results;
  final DoorShutterTotals totals;

  DoorShutterModel({
    required this.results,
    required this.totals,
  });

  factory DoorShutterModel.fromJson(Map<String, dynamic> json) {
    return DoorShutterModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => DoorShutterResult.fromJson(e))
          .toList() ??
          [],
      totals: DoorShutterTotals.fromJson(json['totals'] ?? {}),
    );
  }
}

class DoorShutterResult {
  final double perDoorIn3;
  final double totalIn3;
  final double totalFt3;
  final double totalBdFt;

  DoorShutterResult({
    required this.perDoorIn3,
    required this.totalIn3,
    required this.totalFt3,
    required this.totalBdFt,
  });

  factory DoorShutterResult.fromJson(Map<String, dynamic> json) {
    return DoorShutterResult(
      perDoorIn3: (json['perDoorIn3'] ?? 0).toDouble(),
      totalIn3: (json['totalIn3'] ?? 0).toDouble(),
      totalFt3: (json['totalFt3'] ?? 0).toDouble(),
      totalBdFt: (json['totalBdFt'] ?? 0).toDouble(),
    );
  }
}

class DoorShutterTotals {
  final double totalIn3;
  final double totalFt3;
  final double totalBdFt;

  DoorShutterTotals({
    required this.totalIn3,
    required this.totalFt3,
    required this.totalBdFt,
  });

  factory DoorShutterTotals.fromJson(Map<String, dynamic> json) {
    return DoorShutterTotals(
      totalIn3: (json['totalIn3'] ?? 0).toDouble(),
      totalFt3: (json['totalFt3'] ?? 0).toDouble(),
      totalBdFt: (json['totalBdFt'] ?? 0).toDouble(),
    );
  }
}
class DoorItemModel {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController thicknessController = TextEditingController();
  final TextEditingController stileWidthController = TextEditingController();
  final TextEditingController topRailController = TextEditingController();
  final TextEditingController midRailController = TextEditingController();
  final TextEditingController bottomRailController = TextEditingController();
  final TextEditingController panelsController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  RxString selectedDoorType = 'solid'.obs;

  // 🔹 Each field gets its own dropdown value
  RxString selectedHeightUnit = 'Feet (ft)'.obs;
  RxString selectedWidthUnit = 'Feet (ft)'.obs;
  RxString selectedThicknessUnit = 'Inches (in)'.obs;
  RxString selectedStileWidthUnit = 'Inches (in)'.obs;
  RxString selectedTopRailUnit = 'Inches (in)'.obs;
  RxString selectedMidRailUnit = 'Inches (in)'.obs;
  RxString selectedBottomRailUnit = 'Inches (in)'.obs;
}
extension DoorItemModelToJson on DoorItemModel {
  Map<String, dynamic> toJson() {
    return {
      "height": double.tryParse(heightController.text) ?? 0,
      "heightUnit": selectedHeightUnit.value,
      "width": double.tryParse(widthController.text) ?? 0,
      "widthUnit": selectedWidthUnit.value,
      "thickness": double.tryParse(thicknessController.text) ?? 0,
      "thicknessUnit": selectedThicknessUnit.value,
      "stile": double.tryParse(stileWidthController.text) ?? 0,
      "stileUnit": selectedStileWidthUnit.value,
      "top": double.tryParse(topRailController.text) ?? 0,
      "topUnit": selectedTopRailUnit.value,
      "mid": double.tryParse(midRailController.text) ?? 0,
      "midUnit": selectedMidRailUnit.value,
      "bottom": double.tryParse(bottomRailController.text) ?? 0,
      "bottomUnit": selectedBottomRailUnit.value,
      "panels": int.tryParse(panelsController.text) ?? 0,
      "quantity": int.tryParse(quantityController.text) ?? 1,
      "doorType": selectedDoorType.value,
      "id": 0,
    };
  }
}
