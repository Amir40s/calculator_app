class SlabConcreteModel {
  final Results? results;

  SlabConcreteModel({this.results});

  factory SlabConcreteModel.fromJson(Map<String, dynamic> json) {
    return SlabConcreteModel(
      results: json['results'] != null ? Results.fromJson(json['results']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results?.toJson(),
    };
  }
}

class Results {
  final List<SlabVolume>? slabVolumes;
  final double? totalFt3;
  final double? totalFormwork;
  final double? dryVolume;
  final double? totalM3;
  final double? cementBags;
  final double? sandVolume;
  final double? crushVolume;
  final double? waterLiters;

  Results({
    this.slabVolumes,
    this.totalFt3,
    this.totalFormwork,
    this.dryVolume,
    this.totalM3,
    this.cementBags,
    this.sandVolume,
    this.crushVolume,
    this.waterLiters,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      slabVolumes: json['slabVolumes'] != null
          ? List<SlabVolume>.from(
          json['slabVolumes'].map((x) => SlabVolume.fromJson(x)))
          : [],
      totalFt3: (json['totalFt3'] ?? 0).toDouble(),
      totalFormwork: (json['totalFormwork'] ?? 0).toDouble(),
      dryVolume: (json['dryVolume'] ?? 0).toDouble(),
      totalM3: (json['totalM3'] ?? 0).toDouble(),
      cementBags: (json['cementBags'] ?? 0).toDouble(),
      sandVolume: (json['sandVolume'] ?? 0).toDouble(),
      crushVolume: (json['crushVolume'] ?? 0).toDouble(),
      waterLiters: (json['waterLiters'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slabVolumes': slabVolumes?.map((x) => x.toJson()).toList(),
      'totalFt3': totalFt3,
      'totalFormwork': totalFormwork,
      'dryVolume': dryVolume,
      'totalM3': totalM3,
      'cementBags': cementBags,
      'sandVolume': sandVolume,
      'crushVolume': crushVolume,
      'waterLiters': waterLiters,
    };
  }
}

class SlabVolume {
  final String? grid;
  final String? tag;
  final double? volume;
  final double? slabDryVolume;
  final double? slabCementVolume;
  final double? slabSandVolume;
  final double? slabCrushVolume;
  final double? slabCementBags;
  final double? formwork;

  SlabVolume({
    this.grid,
    this.tag,
    this.volume,
    this.slabDryVolume,
    this.slabCementVolume,
    this.slabSandVolume,
    this.slabCrushVolume,
    this.slabCementBags,
    this.formwork,
  });

  factory SlabVolume.fromJson(Map<String, dynamic> json) {
    return SlabVolume(
      grid: json['grid'] ?? '',
      tag: json['tag'] ?? '',
      volume: (json['volume'] ?? 0).toDouble(),
      slabDryVolume: (json['slabdryvolume'] ?? 0).toDouble(),
      slabCementVolume: (json['slabcementVolume'] ?? 0).toDouble(),
      slabSandVolume: (json['slabSandVolume'] ?? 0).toDouble(),
      slabCrushVolume: (json['slabcrushVolume'] ?? 0).toDouble(),
      slabCementBags: (json['slabcementbags'] ?? 0).toDouble(),
      formwork: (json['formwork'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'grid': grid,
      'tag': tag,
      'volume': volume,
      'slabdryvolume': slabDryVolume,
      'slabcementVolume': slabCementVolume,
      'slabSandVolume': slabSandVolume,
      'slabcrushVolume': slabCrushVolume,
      'slabcementbags': slabCementBags,
      'formwork': formwork,
    };
  }
}
