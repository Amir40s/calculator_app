class StairCalculationResponse {
  final List<StairResult> stairResults;
  final Totals totals;
  final MixSummary mixSummary;
  final MixValues mixValues;

  StairCalculationResponse({
    required this.stairResults,
    required this.totals,
    required this.mixSummary,
    required this.mixValues,
  });

  factory StairCalculationResponse.fromJson(Map<String, dynamic> json) {
    return StairCalculationResponse(
      stairResults: (json['stairResults'] as List)
          .map((e) => StairResult.fromJson(e))
          .toList(),
      totals: Totals.fromJson(json['totals']),
      mixSummary: MixSummary.fromJson(json['mixSummary']),
      mixValues: MixValues.fromJson(json['mixValues']),
    );
  }

  Map<String, dynamic> toJson() => {
    'stairResults': stairResults.map((e) => e.toJson()).toList(),
    'totals': totals.toJson(),
    'mixSummary': mixSummary.toJson(),
    'mixValues': mixValues.toJson(),
  };
}
class StairResult {
  final String type;
  final double stairV;
  final double slabV;
  final double totalV;
  final double m3;
  final String name;
  final String typeLabel;

  StairResult({
    required this.type,
    required this.stairV,
    required this.slabV,
    required this.totalV,
    required this.m3,
    required this.name,
    required this.typeLabel,
  });

  factory StairResult.fromJson(Map<String, dynamic> json) {
    return StairResult(
      type: json['type'],
      stairV: (json['stairV'] as num).toDouble(),
      slabV: (json['slabV'] as num).toDouble(),
      totalV: (json['totalV'] as num).toDouble(),
      m3: (json['m3'] as num).toDouble(),
      name: json['name'],
      typeLabel: json['typeLabel'],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'stairV': stairV,
    'slabV': slabV,
    'totalV': totalV,
    'm3': m3,
    'name': name,
    'typeLabel': typeLabel,
  };
}
class Totals {
  final double stair;
  final double slab;
  final double total;

  Totals({
    required this.stair,
    required this.slab,
    required this.total,
  });

  factory Totals.fromJson(Map<String, dynamic> json) {
    return Totals(
      stair: (json['stair'] as num).toDouble(),
      slab: (json['slab'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'stair': stair,
    'slab': slab,
    'total': total,
  };
}
class MixSummary {
  final double Vcement;
  final double Vsand;
  final double Vagg;
  final double bags;
  final double cementKg;
  final double waterL;

  MixSummary({
    required this.Vcement,
    required this.Vsand,
    required this.Vagg,
    required this.bags,
    required this.cementKg,
    required this.waterL,
  });

  factory MixSummary.fromJson(Map<String, dynamic> json) {
    return MixSummary(
      Vcement: (json['Vcement'] as num).toDouble(),
      Vsand: (json['Vsand'] as num).toDouble(),
      Vagg: (json['Vagg'] as num).toDouble(),
      bags: (json['bags'] as num).toDouble(),
      cementKg: (json['cementKg'] as num).toDouble(),
      waterL: (json['waterL'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Vcement': Vcement,
    'Vsand': Vsand,
    'Vagg': Vagg,
    'bags': bags,
    'cementKg': cementKg,
    'waterL': waterL,
  };
}
class MixValues {
  final int c;
  final int s;
  final int a;
  final double dryFactor;
  final double wc;
  final int bagKg;
  final double bagFt3;

  MixValues({
    required this.c,
    required this.s,
    required this.a,
    required this.dryFactor,
    required this.wc,
    required this.bagKg,
    required this.bagFt3,
  });

  factory MixValues.fromJson(Map<String, dynamic> json) {
    return MixValues(
      c: json['c'],
      s: json['s'],
      a: json['a'],
      dryFactor: (json['dryFactor'] as num).toDouble(),
      wc: (json['wc'] as num).toDouble(),
      bagKg: json['bagKg'],
      bagFt3: (json['bagFt3'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'c': c,
    's': s,
    'a': a,
    'dryFactor': dryFactor,
    'wc': wc,
    'bagKg': bagKg,
    'bagFt3': bagFt3,
  };
}
