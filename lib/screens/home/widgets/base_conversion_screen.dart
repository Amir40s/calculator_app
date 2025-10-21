import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dropdown_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/textFieldWithDropdown.dart';
import 'package:smart_construction_calculator/core/controller/base_calculator_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';

import '../../../config/model/conversion_calculator/power_energy_model.dart';

class BaseConversionScreen<T extends BaseCalculatorController>
    extends StatelessWidget {
  final String itemName;
  final T controller;
  final String inputLabel;
  final String buttonLabel;
  final String resultLabel;
  final RxString selectedUnit;
  final RxString? selectedUnit2;
  final List<String> availableUnits;
  final RxList<String>? availableUnits2;
  final Function(String) onValueChanged;
  final Function(String) onUnitChanged;
  final VoidCallback onConvert, onDownload;
  final TextEditingController? controller2;

  const BaseConversionScreen({
    super.key,
    required this.itemName,
    required this.controller,
    required this.inputLabel,
    required this.buttonLabel,
    required this.resultLabel,
    required this.selectedUnit,
    this.selectedUnit2,
    required this.availableUnits,
    this.availableUnits2,
    required this.onValueChanged,
    required this.onUnitChanged,
    required this.onConvert,
    required this.onDownload,
    this.controller2,
  });

  @override
  Widget build(BuildContext context) {
    log("in base conversion screen itemname is $itemName");
    return LayoutBuilder(
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
    );
  }

  /// 🔹 Main conditional content builder
  Widget _buildContent() {
    if (itemName == 'Power / Energy Conversions') {
      return _buildPowerEnergyDefaultUI();
    } else if (itemName == 'Rebar / Steel Conversion') {
      return _buildRebarUI();
    } else {
      return _buildDefaultConversionUI();
    }
  }

  Widget _buildPowerEnergyDefaultUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          heading: inputLabel,
          hintText: 'Enter value',
          onChanged: onValueChanged,
        ),
        SizedBox(height: 2.h),

        // 🔹 Unit Dropdown
        Obx(() => DropdownButtonFormField<String>(
              value: selectedUnit.value.isEmpty ? null : selectedUnit.value,
              decoration: const InputDecoration(
                hintText: 'Select Unit',
                border: OutlineInputBorder(),
              ),
              items: availableUnits
                  .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
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
        SizedBox(height: 1.h),
        AppButtonWidget(
          text: 'Download PDF',
          height: 5.h,
          width: 100.w,
          onPressed: onDownload,
        ),
        SizedBox(height: 2.h),

        AppTextWidget(
          text: resultLabel,
          styleType: StyleType.dialogHeading,
        ),
        SizedBox(height: 2.h),

        // 🔹 Results table
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: Loader());
          }

          final data = controller.data.value;
          if (data == null) {
            return const Center(
                child: Text('Enter a value to see conversions.'));
          }
          final results = (data as dynamic).results as Map<String, PowerEnergyResult>?;

          if (results == null || results.isEmpty) {
            return const Center(child: Text('No results available.'));
          }

          final List<List<String>> rows = results.entries.map((entry) {
            final result = entry.value;

            final RegExp regex = RegExp(r'^(.*)\s*\((.*)\)$');
            String name = result.name;
            String unitSymbol = '';

            final match = regex.firstMatch(result.name);
            if (match != null) {
              name = match.group(1) ?? result.name;
              unitSymbol = match.group(2) ?? '';
            }

            final valueStr = '${result.value.toStringAsFixed(0)} ${unitSymbol.isNotEmpty ? unitSymbol : ''}';

            return [name, valueStr.trim()];
          }).toList();

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

  Widget _buildRebarUI() {
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
                  .toSet()
                  .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) onUnitChanged(value);
              },
            )),
        SizedBox(height: 1.h),

        /// 🔹 Second section (depends on first dropdown)
        Obx(() {
          if (selectedUnit.value == 'Standard Rebar Size (#2 - #10)') {
            // ✅ Show dropdown for standard rebar sizes
            final validUnits =
                (controller as dynamic).inputType2 as RxList<String>;
            if (!validUnits.contains(selectedUnit2?.value)) {
              selectedUnit2?.value = validUnits.first;
            }

            return ReusableDropdown(
              selectedValue: selectedUnit2!,
              alignWithTextFieldHeading: true,
              itemsList: validUnits,
              hintText: "Select Rebar Size",
              onChangedCallback: (value) {
                selectedUnit2?.value = value;
              },
            );
          } else if (selectedUnit.value == 'Custom Diameter') {
            // ✅ Show TextField + Dropdown for diameter type
            final validDiameterUnits =
                (controller as dynamic).inputDiameterType as List<String>;
            final selectedDiameter =
                (controller as dynamic).selectedDiameterInput as RxString;

            if (!validDiameterUnits.contains(selectedDiameter.value)) {
              selectedDiameter.value = validDiameterUnits.first;
            }

            return TextFieldWithDropdown(
              heading: 'Enter Custom Diameter',
              hint2: 'e.g., 12 mm',
              controller: controller2 ?? TextEditingController(),
              selectedValue: selectedDiameter,
              itemsList: validDiameterUnits.obs,
              onChangedCallback: (val) {
                onValueChanged(val);
              },
            );
          }

          return const SizedBox.shrink();
        }),

        SizedBox(height: 2.h),
        AppButtonWidget(
          text: buttonLabel,
          height: 5.h,
          width: 100.w,
          onPressed: onConvert,
        ),
        SizedBox(height: 1.h),
        AppButtonWidget(
          text: 'Download PDF',
          height: 5.h,
          width: 100.w,
          onPressed: onDownload,
        ),
        SizedBox(height: 2.h),
        AppTextWidget(
          text: resultLabel,
          styleType: StyleType.dialogHeading,
        ),
        SizedBox(height: 2.h),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: Loader());
          }

          final data = controller.data.value;
          if (data == null) {
            return const Center(
                child: Text('Enter a value to see conversions.'));
          }

          final conversions =
              (data as dynamic).conversions as Map<String, dynamic>?;

          if (conversions == null || conversions.isEmpty) {
            return const Center(
                child: Text('Enter a value to see conversions.'));
          }
          String formatNum(dynamic value) {
            if (value is num) return value.toStringAsFixed(0);
            final parsed = double.tryParse(value.toString());
            return parsed?.toStringAsFixed(0) ?? value.toString();
          }

          final List<List<String>> rows = [
            ["Diameter (in)", formatNum(conversions['diameterIn'])],
            ["Diameter (mm)", formatNum(conversions['diameterMm'])],
            ["Weight per ft", formatNum(conversions['weightPerFt'])],
            ["Total Weight", formatNum(conversions['totalWeight'])],
          ];

          return Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: DynamicTable(
              headers: ['Unit', 'Value'],
              rows: rows,
            ),
          );
        }),
      ],
    );
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
        SizedBox(height: 1.h),
        AppButtonWidget(
          text: 'Download PDF',
          height: 5.h,
          width: 100.w,
          onPressed: onDownload,
        ),
        SizedBox(height: 2.h),
        AppTextWidget(
          text: resultLabel,
          styleType: StyleType.dialogHeading,
        ),
        SizedBox(height: 2.h),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: Loader());
          }

          final data = controller.data.value;
          if (data == null) {
            return const Center(
              child: Text('Enter a value to see conversions.'),
            );
          }

          final conversions =
              (data as dynamic).conversions as Map<String, dynamic>?;

          if (conversions == null || conversions.isEmpty) {
            return const Center(
              child: Text('Enter a value to see conversions.'),
            );
          }

          final List<List<String>> rows = conversions.entries
              .map((e) =>
                  [e.key.toString(), (e.value as num).toStringAsFixed(0) ?? ""])
              .toList();

          return Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: DynamicTable(
              headers: ['Unit', 'Value'],
              rows: rows,
            ),
          );
        }),
      ],
    );
  }
}
