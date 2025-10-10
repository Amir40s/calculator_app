import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/pump_selection/lift_pimp_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';

class LiftPumpController extends GetxController {
  final CalculatorRepository _repo = CalculatorRepository();

  // ====================== PUMP INPUTS ======================
  final staticSuctionHeadController = TextEditingController();
  final staticSuctionLengthController = TextEditingController();

  var selectedSuctionMaterial = ''.obs;
  final suctionMaterialList = [
    'uPVC/cPVC (ε ≈ 0.0015 mm)',
    'PPR (ε ≈ 0.007 mm)',
    'GI (ε ≈ 0.150 mm)',
  ];

  final suctionDiameterController = TextEditingController();
  final suctionElbowsController = TextEditingController();
  final suctionValvesController = TextEditingController();

  // ====================== DISCHARGE ======================
  final dischargeElevationController = TextEditingController();
  final dischargePipeLengthController = TextEditingController();
  final dischargeDiameterController = TextEditingController();
  final dischargeElbowsController = TextEditingController();
  final dischargeValvesController = TextEditingController();

  var selectedDischargeMaterial = ''.obs;
  final dischargeMaterialList = [
    'uPVC/cPVC (ε ≈ 0.0015 mm)',
    'PPR (ε ≈ 0.007 mm)',
    'GI (ε ≈ 0.150 mm)',
  ];

  // ====================== TANK GEOMETRY & VOLUME ======================
  final internalLengthController = TextEditingController();
  final internalWidthController = TextEditingController();
  final internalWaterHeightController = TextEditingController();

  var selectedTankShape = ''.obs;
  final tankShapeList = [
    'Rectangular',
    'Cylindrical',
  ];

  // ====================== DEMAND / FILL OBJECTIVE ======================
  final bathroomsController = TextEditingController();
  final kitchensController = TextEditingController();
  final washingMachinesController = TextEditingController();
  final targetRefillTimeController = TextEditingController();
  final manualPeakDrawController = TextEditingController();

  var selectedDesignStrategy = ''.obs;
  final designStrategyList = [
    'Maintain level only (meet peak draw)',
    'Refill from empty in target time (no usage)',
    'Maintain + Refill simultaneously',
    'Refill while fully loaded (match drain time)',
  ];

  // ====================== EFFICIENCIES ======================
  final pumpHydraulicEfficiencyController = TextEditingController();
  final motorEfficiencyController = TextEditingController();

  var selectedSafetyFactor = ''.obs;
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
    try {
      isLoading.value = true;

      final response = await _repo.calculateLiftPump(
        compactionFactor: '', // not used here
        material: '', // optional
        depth: internalWaterHeightController.text,
        length: internalLengthController.text,
        unit: 'ft',
        width: internalWidthController.text,
        dDisIn: dischargeDiameterController.text,
        dSucIn: suctionDiameterController.text,
        lDisFt: dischargePipeLengthController.text,
        lSucFt: staticSuctionLengthController.text,
        bathrooms: bathroomsController.text,
        elbowsDis: dischargeElbowsController.text,
        elbowsSuc: suctionElbowsController.text,
        fillMode: selectedDesignStrategy.value.isNotEmpty
            ? _mapFillMode(selectedDesignStrategy.value)
            : 'matchdrain',
        hDisFt: dischargeElevationController.text,
        hSuctionFt: staticSuctionHeadController.text,
        kitchens: kitchensController.text,
        matDis: selectedDischargeMaterial.value,
        matSuc: selectedSuctionMaterial.value,
        motorEfficiency: motorEfficiencyController.text,
        pumpEfficiency: pumpHydraulicEfficiencyController.text,
        qPeakManual: manualPeakDrawController.text,
        refillMin: targetRefillTimeController.text,
        safetyFactor: _mapSafetyFactor(selectedSafetyFactor.value),
        tankDFt: internalWidthController.text,
        tankHFt: internalWaterHeightController.text,
        tankHcFt: internalWaterHeightController.text,
        tankLFt: internalLengthController.text,
        tankWFt: internalWidthController.text,
        tankShape: selectedTankShape.value.toLowerCase(),
        valvesDis: dischargeValvesController.text,
        valvesSuc: suctionValvesController.text,
        washingMachines: washingMachinesController.text,
      );

      // Parse response
      result.value = LiftPumpModel.fromJson(response['results']);
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
        return 'maintainonly';
      case 'Refill from empty in target time (no usage)':
        return 'refill';
      case 'Maintain + Refill simultaneously':
        return 'maintainrefill';
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
    bathroomsController.clear();
    kitchensController.clear();
    washingMachinesController.clear();
    targetRefillTimeController.clear();
    manualPeakDrawController.clear();
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
    bathroomsController.dispose();
    kitchensController.dispose();
    washingMachinesController.dispose();
    targetRefillTimeController.dispose();
    manualPeakDrawController.dispose();
    pumpHydraulicEfficiencyController.dispose();
    motorEfficiencyController.dispose();
    super.onClose();
  }
}
