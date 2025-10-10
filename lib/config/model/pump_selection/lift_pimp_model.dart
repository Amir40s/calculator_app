class LiftPumpModel {
  final bool success;
  final LiftPumpResult results;

  LiftPumpModel({
    required this.success,
    required this.results,
  });

  factory LiftPumpModel.fromJson(Map<String, dynamic> json) {
    return LiftPumpModel(
      success: json['success'] ?? false,
      results: LiftPumpResult.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'results': results.toJson(),
    };
  }
}

class LiftPumpResult {
  final String? type;
  final double? tankVolume;
  final double? peakDrawEst;
  final double? peakDrawManual;
  final double? drainTime;
  final String? fillMode;
  final double? refillRate;
  final double? refillMin;
  final double? flowLpm;
  final double? hSuctionM;
  final double? hFs;
  final double? hMs;
  final double? hDisM;
  final double? hFd;
  final double? hMd;
  final double? totalHead;
  final double? vs;
  final double? vd;
  final double? hydraulicPower;
  final double? inputPower;
  final double? hp;
  final double? hpSf;
  final double? safetyFactor;

  LiftPumpResult({
    this.type,
    this.tankVolume,
    this.peakDrawEst,
    this.peakDrawManual,
    this.drainTime,
    this.fillMode,
    this.refillRate,
    this.refillMin,
    this.flowLpm,
    this.hSuctionM,
    this.hFs,
    this.hMs,
    this.hDisM,
    this.hFd,
    this.hMd,
    this.totalHead,
    this.vs,
    this.vd,
    this.hydraulicPower,
    this.inputPower,
    this.hp,
    this.hpSf,
    this.safetyFactor,
  });

  factory LiftPumpResult.fromJson(Map<String, dynamic> json) {
    return LiftPumpResult(
      type: json['type'],
      tankVolume: (json['tank_volume'] as num?)?.toDouble(),
      peakDrawEst: (json['peak_draw_est'] as num?)?.toDouble(),
      peakDrawManual: (json['peak_draw_manual'] as num?)?.toDouble(),
      drainTime: (json['drain_time'] as num?)?.toDouble(),
      fillMode: json['fill_mode'],
      refillRate: (json['refill_rate'] as num?)?.toDouble(),
      refillMin: (json['refill_min'] as num?)?.toDouble(),
      flowLpm: (json['flow_lpm'] as num?)?.toDouble(),
      hSuctionM: (json['h_suction_m'] as num?)?.toDouble(),
      hFs: (json['h_fs'] as num?)?.toDouble(),
      hMs: (json['h_ms'] as num?)?.toDouble(),
      hDisM: (json['h_dis_m'] as num?)?.toDouble(),
      hFd: (json['h_fd'] as num?)?.toDouble(),
      hMd: (json['h_md'] as num?)?.toDouble(),
      totalHead: (json['total_head'] as num?)?.toDouble(),
      vs: (json['vs'] as num?)?.toDouble(),
      vd: (json['vd'] as num?)?.toDouble(),
      hydraulicPower: (json['hydraulic_power'] as num?)?.toDouble(),
      inputPower: (json['input_power'] as num?)?.toDouble(),
      hp: (json['hp'] as num?)?.toDouble(),
      hpSf: (json['hp_sf'] as num?)?.toDouble(),
      safetyFactor: (json['safety_factor'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'tank_volume': tankVolume,
      'peak_draw_est': peakDrawEst,
      'peak_draw_manual': peakDrawManual,
      'drain_time': drainTime,
      'fill_mode': fillMode,
      'refill_rate': refillRate,
      'refill_min': refillMin,
      'flow_lpm': flowLpm,
      'h_suction_m': hSuctionM,
      'h_fs': hFs,
      'h_ms': hMs,
      'h_dis_m': hDisM,
      'h_fd': hFd,
      'h_md': hMd,
      'total_head': totalHead,
      'vs': vs,
      'vd': vd,
      'hydraulic_power': hydraulicPower,
      'input_power': inputPower,
      'hp': hp,
      'hp_sf': hpSf,
      'safety_factor': safetyFactor,
    };
  }
}
