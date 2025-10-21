import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import '../../config/res/app_text_style.dart';


class ReusableDropdown extends StatelessWidget {
  final RxString selectedValue;
  final RxList<String> itemsList;
  final String hintText;
  final void Function(String) onChangedCallback;
  final bool alignWithTextFieldHeading;

  const ReusableDropdown({
    super.key,
    required this.selectedValue,
    required this.itemsList,
    required this.hintText,
    required this.onChangedCallback,
    this.alignWithTextFieldHeading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final dropdown = Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.baseColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1.px,
            color: AppColors.greyColor.withOpacity(0.4),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: DropdownButtonFormField<String>(
          value: selectedValue.value.isEmpty ? null : selectedValue.value,
          style: AppTextStyle().bodyText(context: context),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.px,
              horizontal: 6.px,
            ),
            hintText: hintText,
            hintStyle: AppTextStyle().bodyText(
              context: context,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w100,
              size: 12.px,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.blueColor.withOpacity(0.4),
                width: 0.5,
              ),
            ),
            filled: true,
            fillColor: AppColors.baseColor,
          ),
          dropdownColor: AppColors.baseColor,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.blueColor),
          isExpanded: true, // ✅ prevents overflow in both directions
          items: itemsList.map((unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: AppTextWidget(
                text: unit.capitalizeFirst.toString(),
                styleType: StyleType.subHeading,
                overflow: TextOverflow.ellipsis,
                maxLine: 1,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChangedCallback(value);
            }
          },
        ),
      );

      return alignWithTextFieldHeading
          ? Padding(
        padding: EdgeInsets.only(top: 30.px),
        child: dropdown,
      )
          : dropdown;
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(color: AppColors.blueColor.withOpacity(0.4), width: 0.5),
              ),
              fillColor: AppColors.baseColor,
              filled: true,
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
