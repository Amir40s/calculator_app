class StraightStairModel {
  final List<StairResult> stairs;
  final ProjectTotals projectTotals;
  final GrandTotalMix grandTotalMix;

  StraightStairModel({
    required this.stairs,
    required this.projectTotals,
    required this.grandTotalMix,
  });

  factory StraightStairModel.fromJson(Map<String, dynamic> json) {
    final data = json['results'] ?? json;

    return StraightStairModel(
      stairs: (data['stairs'] as List<dynamic>? ?? [])
          .map((e) => StairResult.fromJson(e))
          .toList(),
      projectTotals: ProjectTotals.fromJson(data['projectTotals'] ?? {}),
      grandTotalMix: GrandTotalMix.fromJson(data['grandTotalMix'] ?? {}),
    );
  }
}

class StairResult {
  final double stairVolume;
  final double slabVolume;
  final double totalVolume;
  final double stairVolumeM3;
  final double slabVolumeM3;
  final double totalVolumeM3;

  StairResult({
    required this.stairVolume,
    required this.slabVolume,
    required this.totalVolume,
    required this.stairVolumeM3,
    required this.slabVolumeM3,
    required this.totalVolumeM3,
  });

  factory StairResult.fromJson(Map<String, dynamic> json) {
    return StairResult(
      stairVolume: (json['stairVolume'] ?? json['stairFt3'] ?? 0).toDouble(),
      slabVolume: (json['slabVolume'] ?? json['slabFt3'] ?? 0).toDouble(),
      totalVolume: (json['totalVolume'] ?? json['totalFt3'] ?? 0).toDouble(),
      stairVolumeM3: (json['stairVolumeM3'] ?? json['stairM3'] ?? 0).toDouble(),
      slabVolumeM3: (json['slabVolumeM3'] ?? json['slabM3'] ?? 0).toDouble(),
      totalVolumeM3: (json['totalVolumeM3'] ?? json['totalM3'] ?? 0).toDouble(),
    );
  }
}

class ProjectTotals {
  final double totalStairFt3;
  final double totalSlabFt3;
  final double totalFt3;
  final double totalM3;

  ProjectTotals({
    required this.totalStairFt3,
    required this.totalSlabFt3,
    required this.totalFt3,
    required this.totalM3,
  });

  factory ProjectTotals.fromJson(Map<String, dynamic> json) {
    return ProjectTotals(
      totalStairFt3: (json['totalStairFt3'] ?? json['stairFt3'] ?? 0).toDouble(),
      totalSlabFt3: (json['totalSlabFt3'] ?? json['slabFt3'] ?? 0).toDouble(),
      totalFt3: (json['totalFt3'] ?? 0).toDouble(),
      totalM3: (json['totalM3'] ?? 0).toDouble(),
    );
  }
}

class GrandTotalMix {
  final double cementBags;
  final double cementKg;
  final double sandVolume;
  final double crushVolume;
  final double waterLiters;
  final double waterCementRatio;

  GrandTotalMix({
    required this.cementBags,
    required this.cementKg,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiters,
    required this.waterCementRatio,
  });

  factory GrandTotalMix.fromJson(Map<String, dynamic> json) {
    return GrandTotalMix(
      cementBags: (json['cementBags'] ?? 0).toDouble(),
      cementKg: (json['cementKg'] ?? 0).toDouble(),
      sandVolume: (json['sandVolume'] ?? 0).toDouble(),
      crushVolume: (json['crushVolume'] ?? 0).toDouble(),
      waterLiters: (json['waterLiters'] ?? 0).toDouble(),
      waterCementRatio: (json['waterCementRatio'] ?? 0).toDouble(),
    );
  }
}

