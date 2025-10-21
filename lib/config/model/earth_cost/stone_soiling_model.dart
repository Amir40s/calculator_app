class StoneSoilingResponse {
  final bool success;
  final StoneSoilingResults results;

  StoneSoilingResponse({required this.success, required this.results});

  factory StoneSoilingResponse.fromJson(Map<String, dynamic> json) {
    return StoneSoilingResponse(
      success: json['success'] ?? false,
      results: StoneSoilingResults.fromJson(json['results']),
    );
  }
}

class StoneSoilingResults {
  final List<AreaVolume> areaVolumes;
  final double totalFt3;
  final double totalM3;
  final double minTons;
  final double maxTons;

  StoneSoilingResults({
    required this.areaVolumes,
    required this.totalFt3,
    required this.totalM3,
    required this.minTons,
    required this.maxTons,
  });

  factory StoneSoilingResults.fromJson(Map<String, dynamic> json) {
    return StoneSoilingResults(
      areaVolumes: (json['areaVolumes'] as List)
          .map((e) => AreaVolume.fromJson(e))
          .toList(),
      totalFt3: (json['totalFt3'] ?? 0).toDouble(),
      totalM3: (json['totalM3'] ?? 0).toDouble(),
      minTons: (json['minTons'] ?? 0).toDouble(),
      maxTons: (json['maxTons'] ?? 0).toDouble(),
    );
  }
}

class AreaVolume {
  final String name;
  final double length;
  final double width;
  final double thicknessInches;
  final double volumeFt3;

  AreaVolume({
    required this.name,
    required this.length,
    required this.width,
    required this.thicknessInches,
    required this.volumeFt3,
  });

  factory AreaVolume.fromJson(Map<String, dynamic> json) {
    return AreaVolume(
      name: json['name'] ?? '',
      length: (json['length'] ?? 0).toDouble(),
      width: (json['width'] ?? 0).toDouble(),
      thicknessInches: (json['thicknessInches'] ?? 0).toDouble(),
      volumeFt3: (json['volumeFt3'] ?? 0).toDouble(),
    );
  }
}
