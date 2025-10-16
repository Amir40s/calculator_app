class PlinthBeamLeanModel {
  final List<BeamItem> beams;
  final double totalVolume;
  final double totalM3;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double waterLiter;

  PlinthBeamLeanModel({
    required this.beams,
    required this.totalVolume,
    required this.totalM3,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiter,
  });

  factory PlinthBeamLeanModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] ?? {};
    final beamsList = results['beams'] as List<dynamic>? ?? [];

    return PlinthBeamLeanModel(
      beams: beamsList.map((e) => BeamItem.fromJson(e)).toList(),
      totalVolume: double.tryParse(results['totalVolume'].toString()) ?? 0.0,
      totalM3: double.tryParse(results['totalM3'].toString()) ?? 0.0,
      cementBags: (results['cementBags'] ?? 0).toDouble(),
      sandVolume: (results['sandVolume'] ?? 0).toDouble(),
      crushVolume: (results['crushVolume'] ?? 0).toDouble(),
      waterLiter: (results['waterLiter'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "results": {
        "beams": beams.map((e) => e.toJson()).toList(),
        "totalVolume": totalVolume,
        "totalM3": totalM3,
        "cementBags": cementBags,
        "sandVolume": sandVolume,
        "crushVolume": crushVolume,
        "waterLiter": waterLiter,
      }
    };
  }
}

class BeamItem {
  final String grid;
  final String tag;
  final String length;
  final String width;
  final String height;
  final double volFt3;
  final double volM3;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double waterLiter;

  BeamItem({
    required this.grid,
    required this.tag,
    required this.length,
    required this.width,
    required this.height,
    required this.volFt3,
    required this.volM3,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiter,
  });

  factory BeamItem.fromJson(Map<String, dynamic> json) {
    return BeamItem(
      grid: json['grid'] ?? '',
      tag: json['tag'] ?? '',
      length: json['length'] ?? '',
      width: json['width'] ?? '',
      height: json['height'] ?? '',
      volFt3: double.tryParse(json['volFt3'].toString()) ?? 0.0,
      volM3: double.tryParse(json['volM3'].toString()) ?? 0.0,
      cementBags: (json['cementBags'] ?? 0).toDouble(),
      sandVolume: (json['sandVolume'] ?? 0).toDouble(),
      crushVolume: (json['crushVolume'] ?? 0).toDouble(),
      waterLiter: (json['waterLiter'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "grid": grid,
      "tag": tag,
      "length": length,
      "width": width,
      "height": height,
      "volFt3": volFt3,
      "volM3": volM3,
      "cementBags": cementBags,
      "sandVolume": sandVolume,
      "crushVolume": crushVolume,
      "waterLiter": waterLiter,
    };
  }
}
