class BoosterPumpModel {
  final bool success;
  final PumpResults results;

  BoosterPumpModel({
    required this.success,
    required this.results,
  });

  factory BoosterPumpModel.fromJson(Map<String, dynamic> json) {
    return BoosterPumpModel(
      success: json['success'] ?? false,
      results: PumpResults.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'results': results.toJson(),
    };
  }
}

class PumpResults {
  final String type;
  final Hydraulics hydraulics;
  final Power power;

  PumpResults({
    required this.type,
    required this.hydraulics,
    required this.power,
  });

  factory PumpResults.fromJson(Map<String, dynamic> json) {
    return PumpResults(
      type: json['type'] ?? '',
      hydraulics: Hydraulics.fromJson(json['hydraulics'] ?? {}),
      power: Power.fromJson(json['power'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'hydraulics': hydraulics.toJson(),
      'power': power.toJson(),
    };
  }
}

class Hydraulics {
  final double designFlowLMin;
  final double velocityMS;
  final String velocityStatus;
  final double reynoldsNumber;
  final double frictionFactorF;
  final double staticSuctionHeadM;
  final double dischargeElevationM;
  final double majorLossFrictionM;
  final double minorLossFittingsM;
  final double desiredPressureHeadM;
  final double totalHeadTDHM;

  Hydraulics({
    required this.designFlowLMin,
    required this.velocityMS,
    required this.velocityStatus,
    required this.reynoldsNumber,
    required this.frictionFactorF,
    required this.staticSuctionHeadM,
    required this.dischargeElevationM,
    required this.majorLossFrictionM,
    required this.minorLossFittingsM,
    required this.desiredPressureHeadM,
    required this.totalHeadTDHM,
  });

  factory Hydraulics.fromJson(Map<String, dynamic> json) {
    return Hydraulics(
      designFlowLMin: (json['design_flow_L_min'] ?? 0).toDouble(),
      velocityMS: (json['velocity_m_s'] ?? 0).toDouble(),
      velocityStatus: json['velocity_status'] ?? '',
      reynoldsNumber: (json['reynolds_number'] ?? 0).toDouble(),
      frictionFactorF: (json['friction_factor_f'] ?? 0).toDouble(),
      staticSuctionHeadM: (json['static_suction_head_m'] ?? 0).toDouble(),
      dischargeElevationM: (json['discharge_elevation_m'] ?? 0).toDouble(),
      majorLossFrictionM: (json['major_loss_friction_m'] ?? 0).toDouble(),
      minorLossFittingsM: (json['minor_loss_fittings_m'] ?? 0).toDouble(),
      desiredPressureHeadM: (json['desired_pressure_head_m'] ?? 0).toDouble(),
      totalHeadTDHM: (json['total_head_TDH_m'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'design_flow_L_min': designFlowLMin,
      'velocity_m_s': velocityMS,
      'velocity_status': velocityStatus,
      'reynolds_number': reynoldsNumber,
      'friction_factor_f': frictionFactorF,
      'static_suction_head_m': staticSuctionHeadM,
      'discharge_elevation_m': dischargeElevationM,
      'major_loss_friction_m': majorLossFrictionM,
      'minor_loss_fittings_m': minorLossFittingsM,
      'desired_pressure_head_m': desiredPressureHeadM,
      'total_head_TDH_m': totalHeadTDHM,
    };
  }
}

class Power {
  final double hydraulicPowerKW;
  final double motorInputPowerKW;
  final double motorInputPowerHP;
  final double withSafetyFactorX;
  final double finalPowerHP;
  final double suggestedMotorSizeHP;

  Power({
    required this.hydraulicPowerKW,
    required this.motorInputPowerKW,
    required this.motorInputPowerHP,
    required this.withSafetyFactorX,
    required this.finalPowerHP,
    required this.suggestedMotorSizeHP,
  });

  factory Power.fromJson(Map<String, dynamic> json) {
    return Power(
      hydraulicPowerKW: (json['hydraulic_power_kW'] ?? 0).toDouble(),
      motorInputPowerKW: (json['motor_input_power_kW'] ?? 0).toDouble(),
      motorInputPowerHP: (json['motor_input_power_HP'] ?? 0).toDouble(),
      withSafetyFactorX: (json['with_safety_factor_x'] ?? 0).toDouble(),
      finalPowerHP: (json['final_power_HP'] ?? 0).toDouble(),
      suggestedMotorSizeHP: (json['suggested_motor_size_HP'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hydraulic_power_kW': hydraulicPowerKW,
      'motor_input_power_kW': motorInputPowerKW,
      'motor_input_power_HP': motorInputPowerHP,
      'with_safety_factor_x': withSafetyFactorX,
      'final_power_HP': finalPowerHP,
      'suggested_motor_size_HP': suggestedMotorSizeHP,
    };
  }
}
