import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WallBlockModel {
  final List<ResultModel> results;

  WallBlockModel({required this.results});

  factory WallBlockModel.fromJson(Map<String, dynamic> json) {
    return WallBlockModel(
      results: (json['results'] as List)
          .map((resultJson) => ResultModel.fromJson(resultJson))
          .toList(),
    );
  }
}

class ResultModel {
  final String tag;
  final String grid;
  final double wallLength;
  final double wallHeight;
  final double windowArea;
  final double doorArea;
  final double netWallArea;
  final double blocksNeeded;
  final double totalMortar;
  final double cementVol;
  final double sandVol;
  final double waterLiters;

  ResultModel({
    required this.tag,
    required this.grid,
    required this.wallLength,
    required this.wallHeight,
    required this.windowArea,
    required this.doorArea,
    required this.netWallArea,
    required this.blocksNeeded,
    required this.totalMortar,
    required this.cementVol,
    required this.sandVol,
    required this.waterLiters,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      tag: json['tag'] ?? '',
      grid: json['grid'] ?? '',
      wallLength: json['wallLength'].toDouble(),
      wallHeight: json['wallHeight'].toDouble(),
      windowArea: json['windowArea'].toDouble(),
      doorArea: json['doorArea'].toDouble(),
      netWallArea: json['netWallArea'].toDouble(),
      blocksNeeded: json['blocksNeeded'].toDouble(),
      totalMortar: json['totalMortar'].toDouble(),
      cementVol: json['cementVol'].toDouble(),
      sandVol: json['sandVol'].toDouble(),
      waterLiters: json['waterLiters'].toDouble(),
    );
  }
}
class WindowDoorModel {
  final width = TextEditingController();
  final height = TextEditingController();
}

class WallModel {
  int id = DateTime.now().millisecondsSinceEpoch;

  final tag = TextEditingController();
  final grid = TextEditingController();
  final wallHeight = TextEditingController();
  final wallLength = TextEditingController();

  final blockLength = TextEditingController();
  final blockHeight = TextEditingController();
  final blockWidth = TextEditingController();
  final joint = TextEditingController();
  final mortarRatio = TextEditingController();
  final waterCementRatio = TextEditingController();

  RxList<WindowDoorModel> windows = <WindowDoorModel>[WindowDoorModel()].obs;
  RxList<WindowDoorModel> doors = <WindowDoorModel>[WindowDoorModel()].obs;
}