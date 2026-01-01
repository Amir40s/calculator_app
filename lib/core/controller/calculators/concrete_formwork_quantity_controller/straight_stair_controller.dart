import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/model/concrete_form_quantity/straight_stair_model.dart';
import 'package:smart_construction_calculator/config/repository/calculator_repository.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';

import '../../../../config/model/concrete_form_quantity/stair_concrete_model.dart';

class StraightStairController extends GetxController {
  final _repo = CalculatorRepository();

  // List of stairs
  RxList<Map<String, TextEditingController>> stairs = <Map<String, TextEditingController>>[].obs;
  RxList<RxString> stairTypes = <RxString>[].obs;
  RxList<RxString> winderStepMethods = <RxString>[].obs;

  // Mix ratio (shared across all stairs)
  final cementController = TextEditingController(text: '1');
  final sandController = TextEditingController(text: '2');
  final aggregateController = TextEditingController(text: '4');
  final dryFactorController = TextEditingController(text: '1.54');
  final waterCementRatioController = TextEditingController(text: '0.5');
  final cementBagKgController = TextEditingController(text: '50');
  final bagVolController = TextEditingController(text: '1.25');

  // Available stair types
  final List<String> availableStairTypes = [
    'Straight (with Optional Landings)',
    'L-shaped with Landing',
    'L-shaped with Winder',
    'U-shaped with Landing',
    'U-shaped with Winder',
  ];

  // State
  var isLoading = false.obs;
  var result = Rxn<StairCalculationResponse>();

  @override
  void onInit() {
    super.onInit();
    addStair();
  }

  void addStair() {
    stairs.add({
      'stairWidth': TextEditingController(),
      'goingPerStep': TextEditingController(),
      'riserPerStep': TextEditingController(),
      'waistThickness': TextEditingController(),
      // Straight stair fields
      'numberOfSteps': TextEditingController(),
      'bottomLandingLength': TextEditingController(),
      'bottomLandingWidth': TextEditingController(),
      'topLandingLength': TextEditingController(),
      'topLandingWidth': TextEditingController(),
      // L/U-shaped fields
      'flight1Steps': TextEditingController(),
      'flight2Steps': TextEditingController(),
      'midLandingLength': TextEditingController(),
      'midLandingWidth': TextEditingController(),
      // Winder fields
      'winderSteps1': TextEditingController(),
      'winderGoing': TextEditingController(),
      'winderPlatform1Length': TextEditingController(),
      'winderPlatform1Width': TextEditingController(),
      'winderPlatform2Length': TextEditingController(),
      'winderPlatform2Width': TextEditingController(),
      // Common fields
      'slabThickness': TextEditingController(),
    });
    stairTypes.add('Straight (with Optional Landings)'.obs);
    winderStepMethods.add('Walking-line (recommended)'.obs);
  }

  // Helper method to check if stair type needs winder fields
  bool needsWinderFields(String stairType) {
    return stairType.contains('Winder');
  }

  bool needsFlightSteps(String stairType) {
    return stairType.contains('L-shaped') || stairType.contains('U-shaped');
  }

  // Helper method to check if stair type needs mid landing
  bool needsMidLanding(String stairType) {
    return stairType.contains('L-shaped') || stairType.contains('U-shaped');
  }

  void deleteStair(int index) {
    if (stairs.length > 1) {
      for (var controller in stairs[index].values) {
        controller.dispose();
      }
      stairs.removeAt(index);
      stairTypes.removeAt(index);
      winderStepMethods.removeAt(index);
    } else {
      AppUtils.showToast(
        text: "At least one stair is required.",
        bgColor: Colors.orange,
      );
    }
  }

  bool isValidFeetInchFormat(String input) {
    input = input.trim();
    if (input.isEmpty) return false;
    if (!input.contains("'") || !input.contains('"')) return false;
    try {
      final parts = input.split("'");
      if (parts.length != 2) return false;
      final feetPart = parts[0].trim();
      final inchPart = parts[1].replaceAll('"', '').trim();
      final feet = int.tryParse(feetPart);
      final inches = double.tryParse(inchPart);
      if (feet == null || inches == null) return false;
      if (feet < 0 || inches < 0 || inches >= 12) return false;
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> calculate() async {
    try {
      // Validate mix ratio
      if (cementController.text.trim().isEmpty ||
          sandController.text.trim().isEmpty ||
          aggregateController.text.trim().isEmpty) {
        AppUtils.showToast(
          text: "Please enter mix ratio values (Cement, Sand, Aggregate).",
          bgColor: Colors.red,
        );
        return;
      }

      // Validate all stairs
      for (int i = 0; i < stairs.length; i++) {
        final stair = stairs[i];
        final stairType = stairTypes[i].value;

        // Common required fields for all types
        final commonFields = {
          'Stair Width': stair['stairWidth']!.text.trim(),
          'Going per step': stair['goingPerStep']!.text.trim(),
          'Riser per step': stair['riserPerStep']!.text.trim(),
          'Waist Thickness': stair['waistThickness']!.text.trim(),
        };

        for (final entry in commonFields.entries) {
          if (entry.value.isEmpty) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Please enter ${entry.key}.",
              bgColor: Colors.red,
            );
            return;
          }
          if (!isValidFeetInchFormat(entry.value)) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: ${entry.key} must be in format like 4'6\" or 8'0\".",
              bgColor: Colors.red,
            );
            return;
          }
        }

        // Validate based on stair type
        if (stairType == 'Straight (with Optional Landings)') {
          if (stair['numberOfSteps']!.text.trim().isEmpty) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Please enter Number of Steps.",
              bgColor: Colors.red,
            );
            return;
          }
          final numSteps = int.tryParse(stair['numberOfSteps']!.text.trim());
          if (numSteps == null || numSteps <= 0) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Please enter a valid number of steps.",
              bgColor: Colors.red,
            );
            return;
          }
          if (stair['slabThickness']!.text.trim().isEmpty) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Please enter Slab/landing thickness.",
              bgColor: Colors.red,
            );
            return;
          }
          if (!isValidFeetInchFormat(stair['slabThickness']!.text.trim())) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Slab/landing thickness must be in format like 4'6\" or 8'0\".",
              bgColor: Colors.red,
            );
            return;
          }
        } else if (needsFlightSteps(stairType)) {
          // L/U-shaped stairs
          if (stair['flight1Steps']!.text.trim().isEmpty || 
              stair['flight2Steps']!.text.trim().isEmpty) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Please enter Flight 1 Steps and Flight 2 Steps.",
              bgColor: Colors.red,
            );
            return;
          }
          final flight1 = int.tryParse(stair['flight1Steps']!.text.trim());
          final flight2 = int.tryParse(stair['flight2Steps']!.text.trim());
          if (flight1 == null || flight1 <= 0 || flight2 == null || flight2 <= 0) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Please enter valid flight steps.",
              bgColor: Colors.red,
            );
            return;
          }
          if (stair['slabThickness']!.text.trim().isEmpty) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: Please enter ${stairType.contains('Winder') ? 'Landing/Slab' : 'Slab/landing'} thickness.",
              bgColor: Colors.red,
            );
            return;
          }
          if (!isValidFeetInchFormat(stair['slabThickness']!.text.trim())) {
            AppUtils.showToast(
              text: "Stair ${i + 1}: ${stairType.contains('Winder') ? 'Landing/Slab' : 'Slab/landing'} thickness must be in format like 4'6\" or 8'0\".",
              bgColor: Colors.red,
            );
            return;
          }
          if (needsMidLanding(stairType)) {
            if (stair['midLandingLength']!.text.trim().isEmpty ||
                stair['midLandingWidth']!.text.trim().isEmpty) {
              AppUtils.showToast(
                text: "Stair ${i + 1}: Please enter Mid Landing dimensions.",
                bgColor: Colors.red,
              );
              return;
            }
          }
        }
      }

      isLoading.value = true;

      // Helper to convert stair type to API type code
      String getStairTypeCode(String stairType) {
        switch (stairType) {
          case 'Straight (with Optional Landings)':
            return 'straight';
          case 'L-shaped with Landing':
            return 'L_landing';
          case 'U-shaped with Landing':
            return 'U_landing';
          case 'L-shaped with Winder':
            return 'L_winder';
          case 'U-shaped with Winder':
            return 'U_winder';
          default:
            return 'straight';
        }
      }

      // Helper to convert winder method to API code
      String getWinderMethodCode(String method) {
        if (method.contains('Walking-line') || method.contains('walking')) {
          return 'walking';
        } else if (method.contains('Width/√2') || method.contains('legacy')) {
          return 'width_sqrt2';
        }
        return 'walking';
      }

      // Helper to get stair name
      String getStairName(String stairType) {
        switch (stairType) {
          case 'Straight (with Optional Landings)':
            return 'Straight Stair';
          case 'L-shaped with Landing':
            return 'L-Shaped Landing';
          case 'U-shaped with Landing':
            return 'U-Shaped Landing';
          case 'L-shaped with Winder':
            return 'L-Shaped Winder';
          case 'U-shaped with Winder':
            return 'U-Shaped Winder';
          default:
            return 'Straight Stair';
        }
      }

      // Build stairs list with exact payload structure
      final stairsList = <Map<String, dynamic>>[];
      for (int i = 0; i < stairs.length; i++) {
        final stair = stairs[i];
        final stairType = stairTypes[i].value;
        final typeCode = getStairTypeCode(stairType);
        
        // Base fields common to all types (using short codes)
        final fields = <String, dynamic>{
          'type': typeCode,
          'W': stair['stairWidth']!.text.trim(),  // Stair Width
          'G': stair['goingPerStep']!.text.trim(),  // Going per step
          'R': stair['riserPerStep']!.text.trim(),  // Riser per step
          'Tw': stair['waistThickness']!.text.trim(),  // Waist Thickness
          'Tl': stair['slabThickness']!.text.trim(),  // Landing/Slab Thickness
        };

        // Type-specific fields
        if (typeCode == 'straight') {
          fields['N_straight'] = stair['numberOfSteps']!.text.trim();
          fields['L_bot'] = stair['bottomLandingLength']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['bottomLandingLength']!.text.trim();
          fields['W_bot'] = stair['bottomLandingWidth']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['bottomLandingWidth']!.text.trim();
          fields['L_top'] = stair['topLandingLength']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['topLandingLength']!.text.trim();
          fields['W_top'] = stair['topLandingWidth']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['topLandingWidth']!.text.trim();
        } else if (typeCode == 'L_landing' || typeCode == 'U_landing') {
          fields['N1'] = stair['flight1Steps']!.text.trim();
          fields['N2'] = stair['flight2Steps']!.text.trim();
          fields['L_mid'] = stair['midLandingLength']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['midLandingLength']!.text.trim();
          fields['W_mid'] = stair['midLandingWidth']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['midLandingWidth']!.text.trim();
        } else if (typeCode == 'L_winder') {
          fields['N1'] = stair['flight1Steps']!.text.trim();
          fields['N2'] = stair['flight2Steps']!.text.trim();
          fields['nv1'] = stair['winderSteps1']!.text.trim();
          fields['winderMethod'] = getWinderMethodCode(winderStepMethods[i].value);
          fields['Gw'] = stair['winderGoing']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['winderGoing']!.text.trim();
          fields['l1'] = stair['winderPlatform1Length']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['winderPlatform1Length']!.text.trim();
          fields['w1'] = stair['winderPlatform1Width']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['winderPlatform1Width']!.text.trim();
        } else if (typeCode == 'U_winder') {
          fields['N1'] = stair['flight1Steps']!.text.trim();
          fields['N2'] = stair['flight2Steps']!.text.trim();
          fields['nv1'] = stair['winderSteps1']!.text.trim();
          fields['winderMethod'] = getWinderMethodCode(winderStepMethods[i].value);
          fields['Gw'] = stair['winderGoing']!.text.trim();
          fields['l1'] = stair['winderPlatform1Length']!.text.trim();
          fields['w1'] = stair['winderPlatform1Width']!.text.trim();
          // U-winder uses same nv1 for both winders typically, but can have nv2 if different
          // For now, using nv1 for both as per example payload
          fields['nv2'] = stair['winderSteps1']!.text.trim(); // Using same value as nv1
          fields['l2'] = stair['winderPlatform2Length']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['winderPlatform2Length']!.text.trim();
          fields['w2'] = stair['winderPlatform2Width']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['winderPlatform2Width']!.text.trim();
          fields['L_mid'] = stair['midLandingLength']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['midLandingLength']!.text.trim();
          fields['W_mid'] = stair['midLandingWidth']!.text.trim().isEmpty 
              ? "0'0\"" 
              : stair['midLandingWidth']!.text.trim();
        }
        
        stairsList.add({
          'name': getStairName(stairType),
          'fields': fields,
        });
      }

      // Build payload with exact structure
      final body = {
        'mixValues': {
          'c': int.parse(cementController.text.trim()),
          's': int.parse(sandController.text.trim()),
          'a': int.parse(aggregateController.text.trim()),
          'dryFactor': double.tryParse(dryFactorController.text.trim()) ?? 1.54,
          'wc': double.tryParse(waterCementRatioController.text.trim()) ?? 0.5,
          'bagKg': double.tryParse(cementBagKgController.text.trim()) ?? 50,
          'bagFt3': double.tryParse(bagVolController.text.trim()) ?? 1.25,
        },
        'stairs': stairsList,
      };

      log("📦 Straight Stair Payload: $body");

      // TODO: Add calculateStraightStair method to repository with correct endpoint
      // For now, using L-shaped stair endpoint as placeholder
      // Update this when the correct endpoint is available
      final response = await _repo.calculateStairConcrete(body: body);
      result.value = StairCalculationResponse.fromJson(response);
      log("✅ Straight Stair Response: $response");
    } catch (e, stackTrace) {
      log("❌ Error: $e");
      log("❌ StackTrace: $stackTrace");
      AppUtils.showToast(
        text: "Failed to calculate: ${e.toString()}",
        bgColor: Colors.red,
        timeInSecForIosWeb: 4,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    for (var stair in stairs) {
      for (var controller in stair.values) {
        controller.dispose();
      }
    }
    cementController.dispose();
    sandController.dispose();
    aggregateController.dispose();
    dryFactorController.dispose();
    waterCementRatioController.dispose();
    cementBagKgController.dispose();
    bagVolController.dispose();
    super.onClose();
  }
}

