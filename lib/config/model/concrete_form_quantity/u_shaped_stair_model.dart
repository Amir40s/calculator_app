class UShapedStairResultModel {
  final double waistVolume;
  final double stepVolume;
  final double winderVolume;
  final double midSlabVolume;
  final double totalFt3;
  final double totalM3;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double waterLiters;

  UShapedStairResultModel({
    required this.waistVolume,
    required this.stepVolume,
    required this.winderVolume,
    required this.midSlabVolume,
    required this.totalFt3,
    required this.totalM3,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiters,
  });

  /// Factory constructor to create an instance from JSON
  factory UShapedStairResultModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] ?? {};

    return UShapedStairResultModel(
      waistVolume: (results['waistVolume'] ?? 0).toDouble(),
      stepVolume: (results['stepVolume'] ?? 0).toDouble(),
      winderVolume: (results['winderVolume'] ?? 0).toDouble(),
      midSlabVolume: (results['midSlabVolume'] ?? 0).toDouble(),
      totalFt3: (results['totalFt3'] ?? 0).toDouble(),
      totalM3: (results['totalM3'] ?? 0).toDouble(),
      cementBags: (results['cementBags'] ?? 0).toDouble(),
      sandVolume: (results['sandVolume'] ?? 0).toDouble(),
      crushVolume: (results['crushVolume'] ?? 0).toDouble(),
      waterLiters: (results['waterLiters'] ?? 0).toDouble(),
    );
  }

  /// Convert model back to JSON (useful if sending data to API)
  Map<String, dynamic> toJson() {
    return {
      "results": {
        "waistVolume": waistVolume,
        "stepVolume": stepVolume,
        "winderVolume": winderVolume,
        "midSlabVolume": midSlabVolume,
        "totalFt3": totalFt3,
        "totalM3": totalM3,
        "cementBags": cementBags,
        "sandVolume": sandVolume,
        "crushVolume": crushVolume,
        "waterLiters": waterLiters,
      }
    };
  }
}
