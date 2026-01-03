class SpiralStairModel {
  final bool success;
  final SpiralStairResults results;

  SpiralStairModel({
    required this.success,
    required this.results,
  });

  factory SpiralStairModel.fromJson(Map<String, dynamic> json) {
    return SpiralStairModel(
      success: json['success'] ?? false,
      results: SpiralStairResults.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'results': results.toJson(),
    };
  }
}

class SpiralStairResults {
  final List<SpiralStairItem> items;
  final double totalWeight;
  final int numTreads;

  SpiralStairResults({
    required this.items,
    required this.totalWeight,
    required this.numTreads,
  });

  factory SpiralStairResults.fromJson(Map<String, dynamic> json) {
    return SpiralStairResults(
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => SpiralStairItem.fromJson(item))
              .toList() ??
          [],
      totalWeight: (json['totalWeight'] ?? 0).toDouble(),
      numTreads: json['numTreads'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalWeight': totalWeight,
      'numTreads': numTreads,
    };
  }
}

class SpiralStairItem {
  final String desc;
  final double lenArea;
  final double weight;
  final String type; // "length" or "area"

  SpiralStairItem({
    required this.desc,
    required this.lenArea,
    required this.weight,
    required this.type,
  });

  factory SpiralStairItem.fromJson(Map<String, dynamic> json) {
    return SpiralStairItem(
      desc: json['desc'] ?? '',
      lenArea: (json['lenArea'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      type: json['type'] ?? 'length',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'desc': desc,
      'lenArea': lenArea,
      'weight': weight,
      'type': type,
    };
  }
}

