import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../config/model/concrete_form_quantity/plot_clean_model.dart';
import '../../../../config/model/door_windows_model/door_boq_model.dart';
import '../../../../config/repository/calculator_repository.dart';
import '../../../../config/utility/app_utils.dart';

class PlotCleanController extends GetxController{
  final _repo = CalculatorRepository();
  var plotResult = Rxn<PlotCleanModel>();
  var isLoading = false.obs;
  final plotLengthController = TextEditingController();
  final plotWidthController = TextEditingController();
  final thicknessController = TextEditingController();
  final cementController = TextEditingController();
  final sandController = TextEditingController();
  final crushController = TextEditingController();


  void convert() async {
    try {
      if (!AppUtils().isValidFeetInchFormat(plotLengthController.text)) {
        AppUtils().showInvalidFormatError("Plot Length");
        return;
      }
      if (!AppUtils().isValidFeetInchFormat(plotWidthController.text)) {
        AppUtils().showInvalidFormatError("Plot Width");
        return;
      }
      if (!AppUtils().isValidFeetInchFormat(thicknessController.text)) {
        AppUtils().showInvalidFormatError("Thickness");
        return;
      }

      isLoading.value = true;

      final body = {
        "length": plotLengthController.text.trim(),
        "width": plotWidthController.text.trim(),
        "thickness": thicknessController.text.trim(),
        "mixRatio": {
          "cement": cementController.text.trim(),
          "sand": sandController.text.trim(),
          "crush": crushController.text.trim(),
        }
      };

      log("message is ${plotLengthController.text}");

      final res = await _repo.calculatePlotConcrete(body: body);

      plotResult.value = PlotCleanModel.fromJson(res);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error: $e");
    }
  }


}