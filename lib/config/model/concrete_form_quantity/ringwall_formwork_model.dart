class RingwallFormworkConcreteModel {
  final RingwallResults? results;

  RingwallFormworkConcreteModel({this.results});

  factory RingwallFormworkConcreteModel.fromJson(Map<String, dynamic> json) {
    return RingwallFormworkConcreteModel(
      results: json['results'] != null
          ? RingwallResults.fromJson(json['results'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results?.toJson(),
    };
  }
}

class RingwallResults {
  final double? volumeFoundation;
  final double? volumeRingWall;
  final double? totalVolume;
  final double? formworkFoundation;
  final double? formworkRingWall;
  final double? totalFormwork;
  final double? cementVolume;
  final int? cementBags;
  final double? sandVolume;
  final double? crushVolume;
  final double? waterRequired;

  RingwallResults({
    this.volumeFoundation,
    this.volumeRingWall,
    this.totalVolume,
    this.formworkFoundation,
    this.formworkRingWall,
    this.totalFormwork,
    this.cementVolume,
    this.cementBags,
    this.sandVolume,
    this.crushVolume,
    this.waterRequired,
  });

  factory RingwallResults.fromJson(Map<String, dynamic> json) {
    return RingwallResults(
      volumeFoundation: (json['volumeFoundation'] ?? 0).toDouble(),
      volumeRingWall: (json['volumeRingWall'] ?? 0).toDouble(),
      totalVolume: (json['totalVolume'] ?? 0).toDouble(),
      formworkFoundation: (json['formworkFoundation'] ?? 0).toDouble(),
      formworkRingWall: (json['formworkRingWall'] ?? 0).toDouble(),
      totalFormwork: (json['totalFormwork'] ?? 0).toDouble(),
      cementVolume: (json['cementVolume'] ?? 0).toDouble(),
      cementBags: (json['cementBags'] ?? 0).toInt(),
      sandVolume: (json['sandVolume'] ?? 0).toDouble(),
      crushVolume: (json['crushVolume'] ?? 0).toDouble(),
      waterRequired: (json['waterRequired'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'volumeFoundation': volumeFoundation,
      'volumeRingWall': volumeRingWall,
      'totalVolume': totalVolume,
      'formworkFoundation': formworkFoundation,
      'formworkRingWall': formworkRingWall,
      'totalFormwork': totalFormwork,
      'cementVolume': cementVolume,
      'cementBags': cementBags,
      'sandVolume': sandVolume,
      'crushVolume': crushVolume,
      'waterRequired': waterRequired,
    };
  }
}
