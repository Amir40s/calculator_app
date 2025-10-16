import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_text_field.dart';
import 'dropdown_widget.dart';

class TextFieldWithDropdown extends StatelessWidget {
  final TextEditingController controller;
  final RxString selectedValue;
  final RxList<String> itemsList;
  final String hint2,
  heading;
  final void Function(String) onChangedCallback;
  const TextFieldWithDropdown({super.key,
    required this.controller,
    required this.selectedValue,
    required this.itemsList, required this.hint2, required this.heading, required this.onChangedCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: AppTextField(
            hintText: "0",
            heading: heading,
            controller: controller,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ReusableDropdown(
            selectedValue: selectedValue,
            itemsList: itemsList,
            hintText: hint2,
            alignWithTextFieldHeading: true,
            onChangedCallback: onChangedCallback,
          ),
        ),
      ],
    );
  }
}
