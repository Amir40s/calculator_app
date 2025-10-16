class PlinthBeamConcretModel {
  final List<BeamItem> beams;
  final double totalVolume;
  final double totalM3;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double totalFormwork;
  final double waterLiter;

  PlinthBeamConcretModel({
    required this.beams,
    required this.totalVolume,
    required this.totalM3,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiter,
    required this.totalFormwork,
  });

  factory PlinthBeamConcretModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] ?? {};
    final beamsList = results['beams'] as List<dynamic>? ?? [];

    return PlinthBeamConcretModel(
      beams: beamsList.map((e) => BeamItem.fromJson(e)).toList(),
      totalVolume: _toDouble(results['totalVolume']),
      totalM3: _toDouble(results['totalM3']),
      totalFormwork: _toDouble(results['totalFormwork']),
      cementBags: _toDouble(results['cementBags']),
      sandVolume: _toDouble(results['sandVolume']),
      crushVolume: _toDouble(results['crushVolume']),
      waterLiter: _toDouble(results['waterLiter']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "results": {
        "beams": beams.map((e) => e.toJson()).toList(),
        "totalVolume": totalVolume,
        "totalM3": totalM3,
        "totalFormwork": totalFormwork,
        "cementBags": cementBags,
        "sandVolume": sandVolume,
        "crushVolume": crushVolume,
        "waterLiter": waterLiter,
      }
    };
  }

  /// ✅ Safe conversion helper
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
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
  final double formworkFt2;

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
    required this.formworkFt2,
  });

  factory BeamItem.fromJson(Map<String, dynamic> json) {
    return BeamItem(
      grid: json['grid']?.toString() ?? '',
      tag: json['tag']?.toString() ?? '',
      length: json['length']?.toString() ?? '',
      width: json['width']?.toString() ?? '',
      height: json['height']?.toString() ?? '',
      volFt3: PlinthBeamConcretModel._toDouble(json['volFt3']),
      volM3: PlinthBeamConcretModel._toDouble(json['volM3']),
      formworkFt2: PlinthBeamConcretModel._toDouble(json['formworkFt2']),
      cementBags: PlinthBeamConcretModel._toDouble(json['cementBags']),
      sandVolume: PlinthBeamConcretModel._toDouble(json['sandVolume']),
      crushVolume: PlinthBeamConcretModel._toDouble(json['crushVolume']),
      waterLiter: PlinthBeamConcretModel._toDouble(json['waterLiter']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "grid": grid,
      "tag": tag,
      "length": length,
      "width": width,
      "height": height,
      "formworkFt2": formworkFt2,
      "volFt3": volFt3,
      "volM3": volM3,
      "cementBags": cementBags,
      "sandVolume": sandVolume,
      "crushVolume": crushVolume,
      "waterLiter": waterLiter,
    };
  }
}
