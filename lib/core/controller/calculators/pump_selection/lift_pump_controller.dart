import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/pump_selection/lift_pimp_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';

class LiftPumpController extends GetxController {
  final CalculatorRepository _repo = CalculatorRepository();

  // ====================== SUCTION ======================
  final staticSuctionHeadController = TextEditingController(); // h_suction_ft
  final staticSuctionLengthController = TextEditingController(); // L_suc_ft
  final suctionDiameterController = TextEditingController(); // D_suc_in
  final suctionElbowsController = TextEditingController(); // elbows_suc
  final suctionValvesController = TextEditingController(); // valves_suc
  var selectedSuctionMaterial = ''.obs; // mat_suc

  final suctionMaterialList = [
    'uPVC/cPVC (ε ≈ 0.0015 mm)',
    'PPR (ε ≈ 0.007 mm)',
    'GI (ε ≈ 0.150 mm)',
  ];

  // ====================== DISCHARGE ======================
  final dischargeElevationController = TextEditingController(); // h_dis_ft
  final dischargePipeLengthController = TextEditingController(); // L_dis_ft
  final dischargeDiameterController = TextEditingController(); // D_dis_in
  final dischargeElbowsController = TextEditingController(); // elbows_dis
  final dischargeValvesController = TextEditingController(); // valves_dis
  var selectedDischargeMaterial = ''.obs; // mat_dis

  final dischargeMaterialList = [
    'uPVC/cPVC (ε ≈ 0.0015 mm)',
    'PPR (ε ≈ 0.007 mm)',
    'GI (ε ≈ 0.150 mm)',
  ];

  String _extractMaterialName(String label) {
    if (label.contains('uPVC/cPVC')) return 'uPVC/cPVC';
    if (label.contains('PPR')) return 'PPR';
    if (label.contains('GI')) return 'GI';
    return label; // fallback
  }
  String _mapTankShape(String shape) {
    if (shape.toLowerCase().contains('rect')) return 'rect';
    if (shape.toLowerCase().contains('cyl')) return 'cyl';
    return 'rect'; // default fallback
  }


  // ====================== TANK GEOMETRY ======================
  var selectedTankShape = ''.obs; // tank_shape
  final internalLengthController = TextEditingController(); // tank_L_ft
  final internalWidthController = TextEditingController(); // tank_W_ft
  final internalWaterHeightController = TextEditingController(); // tank_H_ft (rectangular)
  final cylindricalDiameterController = TextEditingController(); // tank_D_ft (cylindrical)
  final cylindricalHeightController = TextEditingController(); // tank_Hc_ft (cylindrical)

  final tankShapeList = [
    'Rectangular',
    'Cylindrical',
  ];

  // ====================== DEMAND / FILL ======================
  final bathroomsController = TextEditingController(); // bathrooms
  final kitchensController = TextEditingController(); // kitchens
  final washingMachinesController = TextEditingController(); // washing_machines
  final manualPeakDrawController = TextEditingController(); // q_peak_manual
  final targetRefillTimeController = TextEditingController(); // refill_min
  var selectedDesignStrategy = ''.obs; // fill_mode

  final designStrategyList = [
    'Maintain level only (meet peak draw)',
    'Refill from empty in target time (no usage)',
    'Maintain + Refill simultaneously',
    'Refill while fully loaded (match drain time)',
  ];

  // ====================== EFFICIENCIES ======================
  final pumpHydraulicEfficiencyController = TextEditingController(); // pump_efficiency
  final motorEfficiencyController = TextEditingController(); // motor_efficiency
  var selectedSafetyFactor = ''.obs; // safety_factor

  final safetyFactorList = [
    '+15% (tight)',
    '+25% (typical)',
    '+30% (conservative)',
    '+50% (very conservative)',
  ];

  // ====================== RESULT ======================
  var isLoading = false.obs;
  var result = Rxn<LiftPumpModel>();

  // ====================== FUNCTION ======================
  Future<void> calculateLiftPump() async {
    log("selectedDischargeMaterial is ::${_extractMaterialName(selectedDischargeMaterial.value)}");
    log("tank shape is ::${selectedTankShape.value.toLowerCase()}");
    log("fill mode  is ::${selectedDesignStrategy.value}");
    try {
      isLoading.value = true;

      // 🔹 Prepare request body with all mapped keys
      final body = {
        // --- Suction ---
        "h_suction_ft": staticSuctionHeadController.text,
        "L_suc_ft": staticSuctionLengthController.text,
        "D_suc_in": suctionDiameterController.text,
        "mat_suc": _extractMaterialName(selectedSuctionMaterial.value),
        "elbows_suc": suctionElbowsController.text,
        "valves_suc": suctionValvesController.text,

        // --- Discharge ---
        "h_dis_ft": dischargeElevationController.text,
        "L_dis_ft": dischargePipeLengthController.text,
        "D_dis_in": dischargeDiameterController.text,
        "mat_dis": _extractMaterialName(selectedDischargeMaterial.value),
        "elbows_dis": dischargeElbowsController.text,
        "valves_dis": dischargeValvesController.text,

        // --- Tank ---
        "tank_shape":  _mapTankShape(selectedTankShape.value),
        "tank_L_ft": internalLengthController.text,
        "tank_W_ft": internalWidthController.text,
        "tank_H_ft": internalWaterHeightController.text,
        "tank_D_ft": cylindricalDiameterController.text,
        "tank_Hc_ft": cylindricalHeightController.text,

        // --- Demand / Fill Objective ---
        "bathrooms": bathroomsController.text,
        "kitchens": kitchensController.text,
        "washing_machines": washingMachinesController.text,
        "q_peak_manual": manualPeakDrawController.text,
        "fill_mode": selectedDesignStrategy.value.isNotEmpty
            ? _mapFillMode(selectedDesignStrategy.value)
            : 'matchdrain',
        "refill_min": targetRefillTimeController.text,

        // --- Efficiencies ---
        "pump_efficiency": pumpHydraulicEfficiencyController.text,
        "motor_efficiency": motorEfficiencyController.text,
        "safety_factor": _mapSafetyFactor(selectedSafetyFactor.value),
      };
      print("lift pump body is ${body}");

      // 🔹 API call
      final response = await _repo.calculateLiftPump( body:body);

      // 🔹 Parse response
      result.value = LiftPumpModel.fromJson(response);
    } catch (e) {
      Get.snackbar('Error', 'Failed to calculate lift pump: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ====================== HELPERS ======================
  String _mapFillMode(String strategy) {
    switch (strategy) {
      case 'Maintain level only (meet peak draw)':
        return 'maintain';
      case 'Refill from empty in target time (no usage)':
        return 'refill';
      case 'Maintain + Refill simultaneously':
        return 'both';
      case 'Refill while fully loaded (match drain time)':
        return 'matchdrain';
      default:
        return 'matchdrain';
    }
  }

  String _mapSafetyFactor(String factor) {
    if (factor.contains('15')) return '1.15';
    if (factor.contains('25')) return '1.25';
    if (factor.contains('30')) return '1.30';
    if (factor.contains('50')) return '1.50';
    return '1.25';
  }

  // ====================== CLEAR ======================
  void clearAll() {
    staticSuctionHeadController.clear();
    staticSuctionLengthController.clear();
    suctionDiameterController.clear();
    suctionElbowsController.clear();
    suctionValvesController.clear();
    dischargeElevationController.clear();
    dischargePipeLengthController.clear();
    dischargeDiameterController.clear();
    dischargeElbowsController.clear();
    dischargeValvesController.clear();
    internalLengthController.clear();
    internalWidthController.clear();
    internalWaterHeightController.clear();
    cylindricalDiameterController.clear();
    cylindricalHeightController.clear();
    bathroomsController.clear();
    kitchensController.clear();
    washingMachinesController.clear();
    manualPeakDrawController.clear();
    targetRefillTimeController.clear();
    pumpHydraulicEfficiencyController.clear();
    motorEfficiencyController.clear();

    selectedSuctionMaterial.value = '';
    selectedDischargeMaterial.value = '';
    selectedTankShape.value = '';
    selectedDesignStrategy.value = '';
    selectedSafetyFactor.value = '';
    result.value = null;
  }

  @override
  void onClose() {
    staticSuctionHeadController.dispose();
    staticSuctionLengthController.dispose();
    suctionDiameterController.dispose();
    suctionElbowsController.dispose();
    suctionValvesController.dispose();
    dischargeElevationController.dispose();
    dischargePipeLengthController.dispose();
    dischargeDiameterController.dispose();
    dischargeElbowsController.dispose();
    dischargeValvesController.dispose();
    internalLengthController.dispose();
    internalWidthController.dispose();
    internalWaterHeightController.dispose();
    cylindricalDiameterController.dispose();
    cylindricalHeightController.dispose();
    bathroomsController.dispose();
    kitchensController.dispose();
    washingMachinesController.dispose();
    manualPeakDrawController.dispose();
    targetRefillTimeController.dispose();
    pumpHydraulicEfficiencyController.dispose();
    motorEfficiencyController.dispose();
    super.onClose();
  }
}
