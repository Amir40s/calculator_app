class ExcavationModel {
  final bool success;
  final VolumeResult results;

  ExcavationModel({
    required this.success,
    required this.results,
  });

  factory ExcavationModel.fromJson(Map<String, dynamic> json) {
    return ExcavationModel(
      success: json['success'] == true,
      results: VolumeResult.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'results': results.toJson(),
  };
}

class VolumeResult {
  final double vorig;    // original volume
  final double vorigYd;  // original volume (yards)
  final double l;        // L
  final double w;        // W
  final double d;        // D
  final double vext;     // extended volume
  final double vextYd;   // extended volume (yards)
  final double effLx;    // effective L
  final double effWx;    // effective W
  final double vdiff;    // difference volume
  final double vdiffYd;  // difference volume (yards)
  final bool showYards;  // show in yards or not

  VolumeResult({
    required this.vorig,
    required this.vorigYd,
    required this.l,
    required this.w,
    required this.d,
    required this.vext,
    required this.vextYd,
    required this.effLx,
    required this.effWx,
    required this.vdiff,
    required this.vdiffYd,
    this.showYards = false, // default to false for safety
  });

  factory VolumeResult.fromJson(Map<String, dynamic> json) {
    double _toDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return VolumeResult(
      vorig: _toDouble(json['Vorig']),
      vorigYd: _toDouble(json['VorigYd']),
      l: _toDouble(json['L']),
      w: _toDouble(json['W']),
      d: _toDouble(json['D']),
      vext: _toDouble(json['Vext']),
      vextYd: _toDouble(json['VextYd']),
      effLx: _toDouble(json['effLx']),
      effWx: _toDouble(json['effWx']),
      vdiff: _toDouble(json['vdiff']),
      vdiffYd: _toDouble(json['vdiffYd']),
      showYards: json['showYards'] == true,
    );
  }

  Map<String, dynamic> toJson() => {
    'Vorig': vorig,
    'VorigYd': vorigYd,
    'L': l,
    'W': w,
    'D': d,
    'Vext': vext,
    'VextYd': vextYd,
    'effLx': effLx,
    'effWx': effWx,
    'vdiff': vdiff,
    'vdiffYd': vdiffYd,
    'showYards': showYards,
  };
}
