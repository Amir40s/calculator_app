class OverheadWaterTankFormworkModel {
  final double bottomVolume;
  final double wallVolume;
  final double roofVolume;
  final double columnVolume;
  final double totalVolume;
  final double wallShuttering;
  final double roofShuttering;
  final double columnShuttering;
  final double totalShuttering;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double waterLiters;

  OverheadWaterTankFormworkModel({
    required this.bottomVolume,
    required this.wallVolume,
    required this.roofVolume,
    required this.columnVolume,
    required this.totalVolume,
    required this.wallShuttering,
    required this.roofShuttering,
    required this.columnShuttering,
    required this.totalShuttering,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiters,
  });

  factory OverheadWaterTankFormworkModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] ?? {};
    return OverheadWaterTankFormworkModel(
      bottomVolume: (results['bottomVolume'] ?? 0).toDouble(),
      wallVolume: (results['wallVolume'] ?? 0).toDouble(),
      roofVolume: (results['roofVolume'] ?? 0).toDouble(),
      columnVolume: (results['columnVolume'] ?? 0).toDouble(),
      totalVolume: (results['totalVolume'] ?? 0).toDouble(),
      wallShuttering: (results['wallShuttering'] ?? 0).toDouble(),
      roofShuttering: (results['roofShuttering'] ?? 0).toDouble(),
      columnShuttering: (results['columnShuttering'] ?? 0).toDouble(),
      totalShuttering: (results['totalShuttering'] ?? 0).toDouble(),
      cementBags: (results['cementBags'] ?? 0).toDouble(),
      sandVolume: (results['sandVolume'] ?? 0).toDouble(),
      crushVolume: (results['crushVolume'] ?? 0).toDouble(),
      waterLiters: (results['waterLiters'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "results": {
      "bottomVolume": bottomVolume,
      "wallVolume": wallVolume,
      "roofVolume": roofVolume,
      "columnVolume": columnVolume,
      "totalVolume": totalVolume,
      "wallShuttering": wallShuttering,
      "roofShuttering": roofShuttering,
      "columnShuttering": columnShuttering,
      "totalShuttering": totalShuttering,
      "cementBags": cementBags,
      "sandVolume": sandVolume,
      "crushVolume": crushVolume,
      "waterLiters": waterLiters,
    },
  };
}
