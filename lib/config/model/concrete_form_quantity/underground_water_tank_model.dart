class UndergroundWaterTankModel {
  final double pickupVolume;
  final double wallVolume;
  final double bottomVolume;
  final double roofVolume;
  final double totalFt3;
  final double totalM3;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double waterLiters;

  UndergroundWaterTankModel({
    required this.pickupVolume,
    required this.wallVolume,
    required this.bottomVolume,
    required this.roofVolume,
    required this.totalFt3,
    required this.totalM3,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiters,
  });

  /// ✅ Factory constructor for deserialization
  factory UndergroundWaterTankModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] ?? {};
    return UndergroundWaterTankModel(
      pickupVolume: _toDouble(results['pickupVolume']),
      wallVolume: _toDouble(results['wallVolume']),
      bottomVolume: _toDouble(results['bottomVolume']),
      roofVolume: _toDouble(results['roofVolume']),
      totalFt3: _toDouble(results['totalFt3']),
      totalM3: _toDouble(results['totalM3']),
      cementBags: _toDouble(results['cementBags']),
      sandVolume: _toDouble(results['sandVolume']),
      crushVolume: _toDouble(results['crushVolume']),
      waterLiters: _toDouble(results['waterLiters']),
    );
  }

  /// ✅ Convert back to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      "results": {
        "pickupVolume": pickupVolume,
        "wallVolume": wallVolume,
        "bottomVolume": bottomVolume,
        "roofVolume": roofVolume,
        "totalFt3": totalFt3,
        "totalM3": totalM3,
        "cementBags": cementBags,
        "sandVolume": sandVolume,
        "crushVolume": crushVolume,
        "waterLiters": waterLiters,
      }
    };
  }

  /// 🔹 Safe double conversion helper
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
