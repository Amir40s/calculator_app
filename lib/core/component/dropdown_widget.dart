import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';

class ReusableDropdown extends StatelessWidget {
  final RxString selectedValue; // The currently selected value
  final RxList<String> itemsList; // The list of available items
  final String hintText; // The hint text for the dropdown
  final void Function(String) onChangedCallback; // The callback function when a value is selected


  // Constructor for ReusableDropdown
  const ReusableDropdown({
    super.key,
    required this.selectedValue,
    required this.itemsList,
    required this.hintText,
    required this.onChangedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        value: selectedValue.value.isEmpty ? null : selectedValue.value,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(borderSide: BorderSide(
            color: AppColors.blueColor
          )),
        ),
        items: itemsList
            .map((unit) => DropdownMenuItem<String>(
          value: unit,
          child: AppTextWidget(text: unit.capitalizeFirst.toString(),styleType: StyleType.subHeading,),
        ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            onChangedCallback(value);
          }
        },
      );
    });
  }
}

class ReactiveDropdown extends StatelessWidget {
  final RxString selectedValue;
  final List<String> itemsList;
  final String hintText, heading;
  final Function(String) onChangedCallback;

  const ReactiveDropdown({
    super.key,
    required this.selectedValue,
    required this.itemsList,
    required this.hintText,
    required this.heading,
    required this.onChangedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: heading,
          styleType: StyleType.subHeading,
        ),
        SizedBox(height: 1.h),
        // ✅ Only this part rebuilds on change
        Obx(() {
          return DropdownButtonFormField<String>(
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            items: itemsList.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: AppTextWidget(text: item),
              );
            }).toList(),
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueColor),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            onChanged: (newValue) {
              if (newValue != null) {
                selectedValue.value = newValue;
                onChangedCallback(newValue);
              }
            },
          );
        }),
      ],
    );
  }
}
