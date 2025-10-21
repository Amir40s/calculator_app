class RebarConversionModel {
  final RebarInput input;
  final RebarResults results;

  RebarConversionModel({
    required this.input,
    required this.results,
  });

  factory RebarConversionModel.fromJson(Map<String, dynamic> json) {
    return RebarConversionModel(
      input: RebarInput.fromJson(json['input'] ?? {}),
      results: RebarResults.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "input": input.toJson(),
    "results": results.toJson(),
  };

  /// Optional: convenient access
  Map<String, dynamic> get conversions => results.toJson();
}

class RebarInput {
  final String mode;
  final String rebarSize;
  final String customDiameter;
  final String customUnit;
  final double lengthFt;

  RebarInput({
    required this.mode,
    required this.rebarSize,
    required this.customDiameter,
    required this.customUnit,
    required this.lengthFt,
  });

  factory RebarInput.fromJson(Map<String, dynamic> json) {
    return RebarInput(
      mode: json['mode'] ?? '',
      rebarSize: json['rebarSize'] ?? '',
      customDiameter: json['customDiameter']?.toString() ?? '0',
      customUnit: json['customUnit'] ?? '',
      lengthFt: (json['lengthFt'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    "mode": mode,
    "rebarSize": rebarSize,
    "customDiameter": customDiameter,
    "customUnit": customUnit,
    "lengthFt": lengthFt,
  };
}

class RebarResults {
  final double diameterIn;
  final double diameterMm;
  final double weightPerFt;
  final double totalWeight;

  RebarResults({
    required this.diameterIn,
    required this.diameterMm,
    required this.weightPerFt,
    required this.totalWeight,
  });

  factory RebarResults.fromJson(Map<String, dynamic> json) {
    return RebarResults(
      diameterIn: (json['diameterIn'] as num?)?.toDouble() ?? 0.0,
      diameterMm: (json['diameterMm'] as num?)?.toDouble() ?? 0.0,
      weightPerFt: (json['weightPerFt'] as num?)?.toDouble() ?? 0.0,
      totalWeight: (json['totalWeight'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    "diameterIn": diameterIn,
    "diameterMm": diameterMm,
    "weightPerFt": weightPerFt,
    "totalWeight": totalWeight,
  };
}
