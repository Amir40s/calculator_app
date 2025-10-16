import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaintQuantityModel {
  final List<WallData>? walls;
  final SummaryData? summary;

  PaintQuantityModel({
    this.walls,
    this.summary,
  });

  factory PaintQuantityModel.fromJson(Map<String, dynamic> json) {
    return PaintQuantityModel(
      walls: (json['walls'] as List<dynamic>?)
          ?.map((e) => WallData.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: json['summary'] != null
          ? SummaryData.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'walls': walls?.map((e) => e.toJson()).toList(),
    'summary': summary?.toJson(),
  };
}

class WallData {
  final int? id;
  final String? tag;
  final String? wallType;
  final double? wallLength;
  final double? wallHeight;
  final double? windowArea;
  final double? doorArea;
  final double? areaFt;
  final double? areaM2;
  final double? primerQty;
  final double? puttyQty;
  final String? paintType;
  final double? paintQty;

  WallData({
    this.id,
    this.tag,
    this.wallType,
    this.wallLength,
    this.wallHeight,
    this.windowArea,
    this.doorArea,
    this.areaFt,
    this.areaM2,
    this.primerQty,
    this.puttyQty,
    this.paintType,
    this.paintQty,
  });

  factory WallData.fromJson(Map<String, dynamic> json) {
    return WallData(
      id: json['id'] as int?,
      tag: json['tag'] as String?,
      wallType: json['wallType'] as String?,
      wallLength: (json['wallLength'] as num?)?.toDouble(),
      wallHeight: (json['wallHeight'] as num?)?.toDouble(),
      windowArea: (json['windowArea'] as num?)?.toDouble(),
      doorArea: (json['doorArea'] as num?)?.toDouble(),
      areaFt: (json['areaFt'] as num?)?.toDouble(),
      areaM2: (json['areaM2'] as num?)?.toDouble(),
      primerQty: (json['primerQty'] as num?)?.toDouble(),
      puttyQty: (json['puttyQty'] as num?)?.toDouble(),
      paintType: json['paintType'] as String?,
      paintQty: (json['paintQty'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'tag': tag,
    'wallType': wallType,
    'wallLength': wallLength,
    'wallHeight': wallHeight,
    'windowArea': windowArea,
    'doorArea': doorArea,
    'areaFt': areaFt,
    'areaM2': areaM2,
    'primerQty': primerQty,
    'puttyQty': puttyQty,
    'paintType': paintType,
    'paintQty': paintQty,
  };
}

class SummaryData {
  final double? primer;
  final double? putty;
  final double? spd;
  final double? emulsion;
  final double? weatherCoat;

  SummaryData({
    this.primer,
    this.putty,
    this.spd,
    this.emulsion,
    this.weatherCoat,
  });

  factory SummaryData.fromJson(Map<String, dynamic> json) {
    return SummaryData(
      primer: (json['primer'] as num?)?.toDouble(),
      putty: (json['putty'] as num?)?.toDouble(),
      spd: (json['SPD'] as num?)?.toDouble(),
      emulsion: (json['Emulsion'] as num?)?.toDouble(),
      weatherCoat: (json['WeatherCoat'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'primer': primer,
    'putty': putty,
    'SPD': spd,
    'Emulsion': emulsion,
    'WeatherCoat': weatherCoat,
  };
}










class WallInput {
  final TextEditingController tagController;
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController noOfWindowsController;
  final TextEditingController noOfDoorsController;
  final TextEditingController noOfPrimeController;
  final TextEditingController noOfPuttyController;
  final TextEditingController noOfPaintController;
  RxString selectedPaintType;
  RxString selectedType;

  // 👇 Add these two reactive lists
  RxList<Map<String, TextEditingController>> windowFields;
  RxList<Map<String, TextEditingController>> doorFields;

  WallInput({
    required this.tagController,
    required this.heightController,
    required this.widthController,
    required this.noOfWindowsController,
    required this.noOfDoorsController,
    required this.noOfPrimeController,
    required this.noOfPuttyController,
    required this.noOfPaintController,
    required this.selectedPaintType,
    required this.selectedType,
    RxList<Map<String, TextEditingController>>? windowFields,
    RxList<Map<String, TextEditingController>>? doorFields,
  })  : windowFields = windowFields ?? <Map<String, TextEditingController>>[].obs,
        doorFields = doorFields ?? <Map<String, TextEditingController>>[].obs;
}
