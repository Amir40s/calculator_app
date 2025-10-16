
class PlotCleanModel {
  final Results? results;

  PlotCleanModel({this.results});

  factory PlotCleanModel.fromJson(Map<String, dynamic> json) {
    return PlotCleanModel(
      results: json['results'] != null
          ? Results.fromJson(json['results'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results?.toJson(),
    };
  }
}

class Results {
  final String? wetVolume;
  final String? dryVolume;
  final String? cementBags;
  final String? sandVol;
  final String? crushVol;
  final String? waterLiters;

  Results({
    this.wetVolume,
    this.dryVolume,
    this.cementBags,
    this.sandVol,
    this.crushVol,
    this.waterLiters,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      wetVolume: json['wetVolume']?.toString(),
      dryVolume: json['dryVolume']?.toString(),
      cementBags: json['cementBags']?.toString(),
      sandVol: json['sandVol']?.toString(),
      crushVol: json['crushVol']?.toString(),
      waterLiters: json['waterLiters']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wetVolume': wetVolume,
      'dryVolume': dryVolume,
      'cementBags': cementBags,
      'sandVol': sandVol,
      'crushVol': crushVol,
      'waterLiters': waterLiters,
    };
  }
}
