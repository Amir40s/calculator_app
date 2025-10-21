import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/block_masonry_model/wall_block_model.dart';

class WallPlasterModel {
  final bool success;
  final List<WallPlasterResult> results;
  final WallPlasterTotals totals;

  WallPlasterModel({
    required this.success,
    required this.results,
    required this.totals,
  });

  factory WallPlasterModel.fromJson(Map<String, dynamic> json) {
    return WallPlasterModel(
      success: json['success'] ?? false,
      results: (json['results'] as List<dynamic>)
          .map((e) => WallPlasterResult.fromJson(e))
          .toList(),
      totals: WallPlasterTotals.fromJson(json['totals']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'results': results.map((e) => e.toJson()).toList(),
    'totals': totals.toJson(),
  };
}

class WallPlasterResult {
  final String type;
  final String tag;
  final String grid;
  final double wallLength;
  final double wallHeight;
  final double wallArea;
  final double windowArea;
  final double windowJambArea;
  final double doorArea;
  final double netWallArea;
  final double plasterThickness;
  final double plasterVolume;
  final double cementVol;
  final double cementBags;
  final double sandVol;
  final double waterLiters;

  WallPlasterResult({
    required this.type,
    required this.tag,
    required this.grid,
    required this.wallLength,
    required this.wallHeight,
    required this.wallArea,
    required this.windowArea,
    required this.windowJambArea,
    required this.doorArea,
    required this.netWallArea,
    required this.plasterThickness,
    required this.plasterVolume,
    required this.cementVol,
    required this.cementBags,
    required this.sandVol,
    required this.waterLiters,
  });

  factory WallPlasterResult.fromJson(Map<String, dynamic> json) {
    return WallPlasterResult(
      type: json['type'] ?? '',
      tag: json['tag'] ?? '',
      grid: json['grid'] ?? '',
      wallLength: (json['wallLength'] ?? 0).toDouble(),
      wallHeight: (json['wallHeight'] ?? 0).toDouble(),
      wallArea: (json['wallArea'] ?? 0).toDouble(),
      windowArea: (json['windowArea'] ?? 0).toDouble(),
      windowJambArea: (json['windowJambArea'] ?? 0).toDouble(),
      doorArea: (json['doorArea'] ?? 0).toDouble(),
      netWallArea: (json['netWallArea'] ?? 0).toDouble(),
      plasterThickness: (json['plasterThickness'] ?? 0).toDouble(),
      plasterVolume: (json['plasterVolume'] ?? 0).toDouble(),
      cementVol: (json['cementVol'] ?? 0).toDouble(),
      cementBags: (json['cementBags'] ?? 0).toDouble(),
      sandVol: (json['sandVol'] ?? 0).toDouble(),
      waterLiters: (json['waterLiters'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'tag': tag,
    'grid': grid,
    'wallLength': wallLength,
    'wallHeight': wallHeight,
    'wallArea': wallArea,
    'windowArea': windowArea,
    'windowJambArea': windowJambArea,
    'doorArea': doorArea,
    'netWallArea': netWallArea,
    'plasterThickness': plasterThickness,
    'plasterVolume': plasterVolume,
    'cementVol': cementVol,
    'cementBags': cementBags,
    'sandVol': sandVol,
    'waterLiters': waterLiters,
  };
}

class WallPlasterTotals {
  final double totalNetArea;
  final double totalPlaster;
  final double totalCement;
  final double totalCementBags;
  final double totalSand;
  final double totalWater;

  WallPlasterTotals({
    required this.totalNetArea,
    required this.totalPlaster,
    required this.totalCement,
    required this.totalCementBags,
    required this.totalSand,
    required this.totalWater,
  });

  factory WallPlasterTotals.fromJson(Map<String, dynamic> json) {
    return WallPlasterTotals(
      totalNetArea: (json['totalNetArea'] ?? 0).toDouble(),
      totalPlaster: (json['totalPlaster'] ?? 0).toDouble(),
      totalCement: (json['totalCement'] ?? 0).toDouble(),
      totalCementBags: (json['totalCementBags'] ?? 0).toDouble(),
      totalSand: (json['totalSand'] ?? 0).toDouble(),
      totalWater: (json['totalWater'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalNetArea': totalNetArea,
    'totalPlaster': totalPlaster,
    'totalCement': totalCement,
    'totalCementBags': totalCementBags,
    'totalSand': totalSand,
    'totalWater': totalWater,
  };
}
class WindowPlasterModel {
  final width = TextEditingController();
  final height = TextEditingController();
}

class WallPlasterDynamic {
  int id = DateTime.now().millisecondsSinceEpoch;
  final tag = TextEditingController();
  final grid = TextEditingController();
  final wallHeight = TextEditingController();
  final wallLength = TextEditingController();
  final wallThickness = TextEditingController();
  final RxString selectedType = 'Wall'.obs;
  final plasterThickness = TextEditingController();
  final mortarRatio = TextEditingController();
  final waterCementRatio = TextEditingController();

  RxList<WindowPlasterModel> windows = <WindowPlasterModel>[WindowPlasterModel()].obs;
  RxList<WindowPlasterModel> doors = <WindowPlasterModel>[WindowPlasterModel()].obs;
}