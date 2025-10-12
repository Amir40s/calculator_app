class LiftPumpModel {
  final bool success;
  final LiftPumpResults results;

  LiftPumpModel({
    required this.success,
    required this.results,
  });

  factory LiftPumpModel.fromJson(Map<String, dynamic> json) {
    return LiftPumpModel(
      success: json['success'] ?? false,
      results: LiftPumpResults.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'results': results.toJson(),
  };
}

class LiftPumpResults {
  final String type;
  final TankVolumeDrainTime tankVolumeDrainTime;
  final DesignFlow designFlow;
  final Heads heads;
  final Velocities velocities;
  final Power power;

  LiftPumpResults({
    required this.type,
    required this.tankVolumeDrainTime,
    required this.designFlow,
    required this.heads,
    required this.velocities,
    required this.power,
  });

  factory LiftPumpResults.fromJson(Map<String, dynamic> json) {
    return LiftPumpResults(
      type: json['type'] ?? '',
      tankVolumeDrainTime:
      TankVolumeDrainTime.fromJson(json['tank_volume_drain_time'] ?? {}),
      designFlow: DesignFlow.fromJson(json['design_flow'] ?? {}),
      heads: Heads.fromJson(json['heads'] ?? {}),
      velocities: Velocities.fromJson(json['velocities'] ?? {}),
      power: Power.fromJson(json['power'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'tank_volume_drain_time': tankVolumeDrainTime.toJson(),
    'design_flow': designFlow.toJson(),
    'heads': heads.toJson(),
    'velocities': velocities.toJson(),
    'power': power.toJson(),
  };
}

class TankVolumeDrainTime {
  final double tankVolumeL;
  final double peakDrawEstimateLMin;
  final double? manualPeakOverrideLMin;
  final double drainTimeAtPeakMin;

  TankVolumeDrainTime({
    required this.tankVolumeL,
    required this.peakDrawEstimateLMin,
    this.manualPeakOverrideLMin,
    required this.drainTimeAtPeakMin,
  });

  factory TankVolumeDrainTime.fromJson(Map<String, dynamic> json) {
    return TankVolumeDrainTime(
      tankVolumeL: (json['tank_volume_L'] ?? 0).toDouble(),
      peakDrawEstimateLMin: (json['peak_draw_estimate_L_min'] ?? 0).toDouble(),
      manualPeakOverrideLMin:
      json['manual_peak_override_L_min'] != null ? (json['manual_peak_override_L_min']).toDouble() : null,
      drainTimeAtPeakMin: (json['drain_time_at_peak_min'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'tank_volume_L': tankVolumeL,
    'peak_draw_estimate_L_min': peakDrawEstimateLMin,
    'manual_peak_override_L_min': manualPeakOverrideLMin,
    'drain_time_at_peak_min': drainTimeAtPeakMin,
  };
}

class DesignFlow {
  final String strategy;
  final double refillOnlyRateLMin;
  final double refillTargetMin;
  final double chosenDesignFlowLMin;

  DesignFlow({
    required this.strategy,
    required this.refillOnlyRateLMin,
    required this.refillTargetMin,
    required this.chosenDesignFlowLMin,
  });

  factory DesignFlow.fromJson(Map<String, dynamic> json) {
    return DesignFlow(
      strategy: json['strategy'] ?? '',
      refillOnlyRateLMin: (json['refill_only_rate_L_min'] ?? 0).toDouble(),
      refillTargetMin: (json['refill_target_min'] ?? 0).toDouble(),
      chosenDesignFlowLMin: (json['chosen_design_flow_L_min'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'strategy': strategy,
    'refill_only_rate_L_min': refillOnlyRateLMin,
    'refill_target_min': refillTargetMin,
    'chosen_design_flow_L_min': chosenDesignFlowLMin,
  };
}

class Heads {
  final double staticSuctionHeadM;
  final double suctionFrictionM;
  final double suctionMinorLossM;
  final double dischargeElevationM;
  final double dischargeFrictionM;
  final double dischargeMinorLossM;
  final double totalDynamicHeadM;

  Heads({
    required this.staticSuctionHeadM,
    required this.suctionFrictionM,
    required this.suctionMinorLossM,
    required this.dischargeElevationM,
    required this.dischargeFrictionM,
    required this.dischargeMinorLossM,
    required this.totalDynamicHeadM,
  });

  factory Heads.fromJson(Map<String, dynamic> json) {
    return Heads(
      staticSuctionHeadM: (json['static_suction_head_m'] ?? 0).toDouble(),
      suctionFrictionM: (json['suction_friction_m'] ?? 0).toDouble(),
      suctionMinorLossM: (json['suction_minor_loss_m'] ?? 0).toDouble(),
      dischargeElevationM: (json['discharge_elevation_m'] ?? 0).toDouble(),
      dischargeFrictionM: (json['discharge_friction_m'] ?? 0).toDouble(),
      dischargeMinorLossM: (json['discharge_minor_loss_m'] ?? 0).toDouble(),
      totalDynamicHeadM: (json['total_dynamic_head_m'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'static_suction_head_m': staticSuctionHeadM,
    'suction_friction_m': suctionFrictionM,
    'suction_minor_loss_m': suctionMinorLossM,
    'discharge_elevation_m': dischargeElevationM,
    'discharge_friction_m': dischargeFrictionM,
    'discharge_minor_loss_m': dischargeMinorLossM,
    'total_dynamic_head_m': totalDynamicHeadM,
  };
}

class Velocities {
  final double suctionVelocityMS;
  final String suctionVelocityAim;
  final double dischargeVelocityMS;
  final String dischargeVelocityAim;

  Velocities({
    required this.suctionVelocityMS,
    required this.suctionVelocityAim,
    required this.dischargeVelocityMS,
    required this.dischargeVelocityAim,
  });

  factory Velocities.fromJson(Map<String, dynamic> json) {
    return Velocities(
      suctionVelocityMS: (json['suction_velocity_m_s'] ?? 0).toDouble(),
      suctionVelocityAim: json['suction_velocity_aim'] ?? '',
      dischargeVelocityMS: (json['discharge_velocity_m_s'] ?? 0).toDouble(),
      dischargeVelocityAim: json['discharge_velocity_aim'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'suction_velocity_m_s': suctionVelocityMS,
    'suction_velocity_aim': suctionVelocityAim,
    'discharge_velocity_m_s': dischargeVelocityMS,
    'discharge_velocity_aim': dischargeVelocityAim,
  };
}

class Power {
  final double hydraulicPowerKW;
  final double motorInputPowerKW;
  final double motorInputPowerHP;
  final double withSafetyFactorX;
  final double finalPowerHP;

  Power({
    required this.hydraulicPowerKW,
    required this.motorInputPowerKW,
    required this.motorInputPowerHP,
    required this.withSafetyFactorX,
    required this.finalPowerHP,
  });

  factory Power.fromJson(Map<String, dynamic> json) {
    return Power(
      hydraulicPowerKW: (json['hydraulic_power_kW'] ?? 0).toDouble(),
      motorInputPowerKW: (json['motor_input_power_kW'] ?? 0).toDouble(),
      motorInputPowerHP: (json['motor_input_power_HP'] ?? 0).toDouble(),
      withSafetyFactorX: (json['with_safety_factor_x'] ?? 0).toDouble(),
      finalPowerHP: (json['final_power_HP'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'hydraulic_power_kW': hydraulicPowerKW,
    'motor_input_power_kW': motorInputPowerKW,
    'motor_input_power_HP': motorInputPowerHP,
    'with_safety_factor_x': withSafetyFactorX,
    'final_power_HP': finalPowerHP,
  };
}
