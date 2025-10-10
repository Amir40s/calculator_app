class BackfillModel {
  final bool success;
  final BackfillResult results;

  BackfillModel({
    required this.success,
    required this.results,
  });

  factory BackfillModel.fromJson(Map<String, dynamic> json) {
    return BackfillModel(
      success: json['success'] == true,
      results: BackfillResult.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'results': results.toJson(),
  };
}

class BackfillResult {
  final double adjustedLength;
  final double adjustedWidth;
  final double excavationVolume;
  final double stoneSoilingVolume;
  final double compactedBackfillVolume;
  final double looseFillVolume;
  final int numberOfTrucks;
  final double truckCapacity;

  BackfillResult({
    required this.adjustedLength,
    required this.adjustedWidth,
    required this.excavationVolume,
    required this.stoneSoilingVolume,
    required this.compactedBackfillVolume,
    required this.looseFillVolume,
    required this.numberOfTrucks,
    required this.truckCapacity,
  });

  factory BackfillResult.fromJson(Map<String, dynamic> json) {
    double _toDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return BackfillResult(
      adjustedLength: _toDouble(json['adjustedLength']),
      adjustedWidth: _toDouble(json['adjustedWidth']),
      excavationVolume: _toDouble(json['excavationVolume']),
      stoneSoilingVolume: _toDouble(json['stoneSoilingVolume']),
      compactedBackfillVolume: _toDouble(json['compactedBackfillVolume']),
      looseFillVolume: _toDouble(json['looseFillVolume']),
      numberOfTrucks: (json['numberOfTrucks'] ?? 0).toInt(),
      truckCapacity: _toDouble(json['truckCapacity']),
    );
  }

  Map<String, dynamic> toJson() => {
    'adjustedLength': adjustedLength,
    'adjustedWidth': adjustedWidth,
    'excavationVolume': excavationVolume,
    'stoneSoilingVolume': stoneSoilingVolume,
    'compactedBackfillVolume': compactedBackfillVolume,
    'looseFillVolume': looseFillVolume,
    'numberOfTrucks': numberOfTrucks,
    'truckCapacity': truckCapacity,
  };
}
