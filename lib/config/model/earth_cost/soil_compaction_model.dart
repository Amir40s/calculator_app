class SoilCompactionModel {
  final bool success;
  final SoilCompactionResult results;

  SoilCompactionModel({
    required this.success,
    required this.results,
  });

  factory SoilCompactionModel.fromJson(Map<String, dynamic> json) {
    return SoilCompactionModel(
      success: json['success'] ?? false,
      results: SoilCompactionResult.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'results': results.toJson(),
    };
  }
}

class SoilCompactionResult {
  final double compactedVolume;
  final double looseVolume;
  final String unit;

  SoilCompactionResult({
    required this.compactedVolume,
    required this.looseVolume,
    required this.unit,
  });

  factory SoilCompactionResult.fromJson(Map<String, dynamic> json) {
    return SoilCompactionResult(
      compactedVolume: (json['compactedVolume'] ?? 0).toDouble(),
      looseVolume: (json['looseVolume'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'compactedVolume': compactedVolume,
      'looseVolume': looseVolume,
      'unit': unit,
    };
  }
}
