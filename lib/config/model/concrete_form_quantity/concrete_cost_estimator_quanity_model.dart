import 'dart:convert';

ConcreteCostEstimatorQuantityModel concreteCostResponseFromJson(String str) =>
    ConcreteCostEstimatorQuantityModel.fromJson(json.decode(str));

String concreteCostResponseToJson(ConcreteCostEstimatorQuantityModel data) =>
    json.encode(data.toJson());

class ConcreteCostEstimatorQuantityModel {
  final double totalCost;
  final double wetVolume;
  final double dryVolumeWithWastage;
  final double cementBags;
  final List<MaterialQuantity> materialQuantities;
  final List<CostBreakdown> costBreakdown;

  ConcreteCostEstimatorQuantityModel({
    required this.totalCost,
    required this.wetVolume,
    required this.dryVolumeWithWastage,
    required this.cementBags,
    required this.materialQuantities,
    required this.costBreakdown,
  });

  factory ConcreteCostEstimatorQuantityModel.fromJson(Map<String, dynamic> json) {
    return ConcreteCostEstimatorQuantityModel(
      totalCost: (json['totalCost'] ?? 0).toDouble(),
      wetVolume: (json['wetVolume'] ?? 0).toDouble(),
      dryVolumeWithWastage: (json['dryVolumeWithWastage'] ?? 0).toDouble(),
      cementBags: (json['cementBags'] ?? 0).toDouble(),
      materialQuantities: (json['materialQuantities'] as List<dynamic>?)
          ?.map((x) => MaterialQuantity.fromJson(x))
          .toList() ??
          [],
      costBreakdown: (json['costBreakdown'] as List<dynamic>?)
          ?.map((x) => CostBreakdown.fromJson(x))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'totalCost': totalCost,
    'wetVolume': wetVolume,
    'dryVolumeWithWastage': dryVolumeWithWastage,
    'cementBags': cementBags,
    'materialQuantities':
    materialQuantities.map((x) => x.toJson()).toList(),
    'costBreakdown': costBreakdown.map((x) => x.toJson()).toList(),
  };
}

class MaterialQuantity {
  final String material;
  final double volume;
  final double mass;

  MaterialQuantity({
    required this.material,
    required this.volume,
    required this.mass,
  });

  factory MaterialQuantity.fromJson(Map<String, dynamic> json) =>
      MaterialQuantity(
        material: json['material'] ?? '',
        volume: (json['volume'] ?? 0).toDouble(),
        mass: (json['mass'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    'material': material,
    'volume': volume,
    'mass': mass,
  };
}

class CostBreakdown {
  final String item;
  final double cost;
  final double percentage;

  CostBreakdown({
    required this.item,
    required this.cost,
    required this.percentage,
  });

  factory CostBreakdown.fromJson(Map<String, dynamic> json) => CostBreakdown(
    item: json['item'] ?? '',
    cost: (json['cost'] ?? 0).toDouble(),
    percentage: (json['percentage'] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'item': item,
    'cost': cost,
    'percentage': percentage,
  };
}
