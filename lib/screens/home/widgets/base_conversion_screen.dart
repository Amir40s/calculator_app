import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/controller/base_calculator_controller.dart';

class BaseConversionScreen<T extends BaseCalculatorController> extends StatelessWidget {
  final String itemName;
  final T controller;
  final String inputLabel;
  final String buttonLabel;
  final String resultLabel;
  final RxString selectedUnit;
  final List<String> availableUnits;
  final Function(String) onValueChanged;
  final Function(String) onUnitChanged;
  final VoidCallback onConvert;

  const BaseConversionScreen({
    super.key,
    required this.itemName,
    required this.controller,
    required this.inputLabel,
    required this.buttonLabel,
    required this.resultLabel,
    required this.selectedUnit,
    required this.availableUnits,
    required this.onValueChanged,
    required this.onUnitChanged,
    required this.onConvert,
  });

  @override
  Widget build(BuildContext context) {
    log("in base conversion screen itemname is $itemName");
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: _buildContent(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Main conditional content builder
  Widget _buildContent() {
    if (itemName == 'Power/Energy Unit Converter') {
      return _buildPowerEnergyUI();
    } else {
      return _buildDefaultConversionUI();
    }
  }

  // ----------------------------------------------------------------------
  // 🔹 GREY STRUCTURE UI
  // ----------------------------------------------------------------------

  // ----------------------------------------------------------------------
  // 🔹 POWER/ENERGY UI
  // ----------------------------------------------------------------------
  Widget _buildPowerEnergyUI() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final data = controller.data.value;
      if (data == null) {
        return const Center(child: Text('Enter a value to see conversions.'));
      }

      final results = (data as dynamic).results as Map<String, dynamic>?;

      if (results == null || results.isEmpty) {
        return const Center(child: Text('No results available.'));
      }

      final List<List<String>> rows = results.entries.map((entry) {
        final name = entry.value['name']?.toString() ?? entry.key.toString();
        final value = entry.value['value']?.toString() ?? '';
        return [name, value];
      }).toList();

      return Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: DynamicTable(
          headers: const ['Unit', 'Value'],
          rows: rows,
        ),
      );
    });
  }

  // ----------------------------------------------------------------------
  // 🔹 DEFAULT CONVERSION UI
  // ----------------------------------------------------------------------
  Widget _buildDefaultConversionUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          heading: inputLabel,
          hintText: 'Enter value',
          onChanged: onValueChanged,
        ),
        SizedBox(height: 2.h),
        Obx(() => DropdownButtonFormField<String>(
          value: selectedUnit.value.isEmpty ? null : selectedUnit.value,
          decoration: const InputDecoration(
            hintText: 'Select Unit',
            border: OutlineInputBorder(),
          ),
          items: availableUnits
              .map((unit) => DropdownMenuItem(
            value: unit,
            child: Text(
              itemName == 'Concrete Mix and Volume Conversions'
                  ? unit
                  : AppUtils().formatUnit(unit),
            ),
          ))
              .toList(),
          onChanged: (value) {
            if (value != null) onUnitChanged(value);
          },
        )),
        SizedBox(height: 2.h),
        AppButtonWidget(
          text: buttonLabel,
          height: 5.h,
          width: 100.w,
          onPressed: onConvert,
        ),
        SizedBox(height: 2.h),
        AppTextWidget(
          text: resultLabel,
          styleType: StyleType.dialogHeading,
        ),
        SizedBox(height: 2.h),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.data.value;
          if (data == null) {
            return const Center(
              child: Text('Enter a value to see conversions.'),
            );
          }

          final conversions = (data as dynamic).conversions as Map<String, double>?;

          if (conversions == null || conversions.isEmpty) {
            return const Center(
              child: Text('Enter a value to see conversions.'),
            );
          }

          final List<List<String>> rows = conversions.entries
              .map((e) => [e.key.toString(), e.value.toString()])
              .toList();

          return Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: DynamicTable(
              headers: const ['Unit', 'Value'],
              rows: rows,
            ),
          );
        }),
      ],
    );
  }
}
