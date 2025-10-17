class SubstructureColumnFormworkModel {
  final List<ColumnEntry> entries;
  final double totalVolume;
  final double totalVolumeM3;
  final double totalFormwork;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double waterLiters;

  SubstructureColumnFormworkModel({
    required this.entries,
    required this.totalVolume,
    required this.totalVolumeM3,
    required this.totalFormwork,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.waterLiters,
  });

  factory SubstructureColumnFormworkModel.fromJson(Map<String, dynamic> json) {
    final data = json['results'] ?? json;

    return SubstructureColumnFormworkModel(
      entries: (data['entries'] as List<dynamic>? ?? [])
          .map((e) => ColumnEntry.fromJson(e))
          .toList(),
      totalVolume: (data['totalVolume'] ?? 0).toDouble(),
      totalVolumeM3: (data['totalVolumeM3'] ?? 0).toDouble(),
      totalFormwork: (data['totalFormwork'] ?? 0).toDouble(),
      cementBags: (data['cementBags'] ?? 0).toDouble(),
      sandVolume: (data['sandVolume'] ?? 0).toDouble(),
      crushVolume: (data['crushVolume'] ?? 0).toDouble(),
      waterLiters: (data['waterLiters'] ?? 0).toDouble(),
    );
  }
}

class ColumnEntry {
  final String tag;
  final String type;
  final double volume;
  final double cementBags;
  final double sandVolume;
  final double crushVolume;
  final double formwork;

  ColumnEntry({
    required this.tag,
    required this.type,
    required this.volume,
    required this.cementBags,
    required this.sandVolume,
    required this.crushVolume,
    required this.formwork,
  });

  factory ColumnEntry.fromJson(Map<String, dynamic> json) {
    return ColumnEntry(
      tag: json['tag'] ?? '',
      type: json['type'] ?? '',
      volume: (json['volume'] ?? 0).toDouble(),
      cementBags: (json['cementBags'] ?? 0).toDouble(),
      sandVolume: (json['sandVolume'] ?? 0).toDouble(),
      crushVolume: (json['crushVolume'] ?? 0).toDouble(),
      formwork: (json['formwork'] ?? 0).toDouble(),
    );
  }
}
