import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/pump_selection/booster_pump_model.dart';
import 'package:smart_construction_calculator/config/model/pump_selection/lift_pimp_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';

class BoosterPumpController extends GetxController {
  final CalculatorRepository _repo = CalculatorRepository();

  // ====================== LEVELS ======================
  final staticSuctionHeadController = TextEditingController(); // h_suction_ft
  final dischargeElevationController = TextEditingController(); // h_dis_ft

  // ====================== DEMAND ======================
  final bathroomsController = TextEditingController(); // bathrooms
  final kitchensController = TextEditingController(); // kitchens
  final washingMachinesController = TextEditingController(); // washing_machines
  final autoEstimateController = TextEditingController(); // target refill or design flow
  final manualPeakDrawController = TextEditingController(); // q_peak_manual

  // ====================== DISCHARGE PIPING ======================
  final straightPipeLController = TextEditingController(); // L_dis_ft
  final straightPipeDiameterController = TextEditingController(); // D_dis_in

  var selectedDesignStrategy = ''.obs; // mat_dis
  var selectedEntryExitLoss = ''.obs; // mat_dis
  final suctionMaterialList = [
    'uPVC/cPVC (ε ≈ 0.0015 mm)',
    'PPR (ε ≈ 0.007 mm)',
    'GI (ε ≈ 0.150 mm)',
  ];  final selectedEntryExitLossList = [
    'yes (recommended)',
    'no',
  ];

  var selectedSafetyFactor = ''.obs;

  final safetyFactorList = [
    '+15% (tight)',
    '+25% (typical)',
    '+30% (conservative)',
    '+50% (very conservative)',
  ];
  String _mapSafetyFactor(String factor) {
    if (factor.contains('15')) return '1.15';
    if (factor.contains('25')) return '1.25';
    if (factor.contains('30')) return '1.30';
    if (factor.contains('50')) return '1.50';
    return '1.25';
  }
  String _extractEntryExitValue(String text) {
    // Will return only 'yes' or 'no'
    return text.startsWith('yes') ? 'yes' : 'no';
  }
  // ====================== MINOR LOSSES ======================
  final elbowsController = TextEditingController(); // elbows_dis
  final valvesController = TextEditingController(); // valves_dis
  final teesController = TextEditingController(); // tees_dis

  // ====================== EFFICIENCIES ======================
  final desiredPressureController = TextEditingController(); // desired_pressure
  final pumpHydraulicEfficiencyController = TextEditingController(); // pump_efficiency
  final motorEfficiencyController = TextEditingController(); // motor_efficiency
  final waterTemperatureController = TextEditingController(); // water_temp

  // ====================== RESULT ======================
  var isLoading = false.obs;
  var result = Rxn<BoosterPumpModel>();

  // ====================== HELPERS ======================
  String _extractMaterialName(String label) {
    if (label.contains('uPVC/cPVC')) return 'uPVC/cPVC';
    if (label.contains('PPR')) return 'PPR';
    if (label.contains('GI')) return 'GI';
    return label;
  }

  // ====================== API CALL ======================
  Future<void> calculatePump() async {
    try {
      isLoading.value = true;

      final body = {
        "bathrooms": bathroomsController.text.trim(),
        "desired_unit": "bar",
        "desired_val": "3.0",
        "dia_in": straightPipeDiameterController.text.trim(),
        "elbows": elbowsController.text.trim(),
        "ends": _extractEntryExitValue(selectedEntryExitLoss.value),
        "flow_manual_lpm": manualPeakDrawController.text.trim(),
        "h_discharge_ft": dischargeElevationController.text.trim(),
        "h_suction_ft": staticSuctionHeadController.text.trim(),
        "kitchens": kitchensController.text.trim(),
        "material": _extractMaterialName(selectedDesignStrategy.value),
        "motor_efficiency": motorEfficiencyController.text.trim(),
        "pl_ft": straightPipeLController.text.trim(),
        "pump_efficiency": pumpHydraulicEfficiencyController.text.trim(),
        "safety_factor":_mapSafetyFactor (selectedSafetyFactor.value),
        "tees": teesController.text.trim(),
        "tempC": waterTemperatureController.text.trim(),
        "valves": valvesController.text.trim(),
        "washing_machines": washingMachinesController.text.trim(),
      };

      log("🟢 Booster Pump Body: $body");

      final response = await _repo.calculateBoosterPump(body: body);
      result.value = BoosterPumpModel.fromJson(response);
      log("✅ Booster Pump Response: ${response.toString()}");

    } catch (e) {
      Get.snackbar('Error', 'Failed to calculate booster pump: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ====================== CLEAR ======================
  void clearAll() {
    staticSuctionHeadController.clear();
    dischargeElevationController.clear();
    bathroomsController.clear();
    kitchensController.clear();
    washingMachinesController.clear();
    manualPeakDrawController.clear();
    straightPipeLController.clear();
    straightPipeDiameterController.clear();
    elbowsController.clear();
    valvesController.clear();
    teesController.clear();
    desiredPressureController.clear();
    pumpHydraulicEfficiencyController.clear();
    motorEfficiencyController.clear();
    waterTemperatureController.clear();
    selectedDesignStrategy.value = '';
    selectedEntryExitLoss.value = '';
    selectedSafetyFactor.value = '';
    result.value = null;
  }

  @override
  void onClose() {
    staticSuctionHeadController.dispose();
    dischargeElevationController.dispose();
    bathroomsController.dispose();
    kitchensController.dispose();
    washingMachinesController.dispose();
    manualPeakDrawController.dispose();
    straightPipeLController.dispose();
    straightPipeDiameterController.dispose();
    elbowsController.dispose();
    valvesController.dispose();
    teesController.dispose();
    desiredPressureController.dispose();
    pumpHydraulicEfficiencyController.dispose();
    motorEfficiencyController.dispose();
    waterTemperatureController.dispose();
    super.onClose();
  }
}
