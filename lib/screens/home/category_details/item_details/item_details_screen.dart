import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/custom_appbar.dart';

import '../../../../config/model/calculator_category_model.dart';
import '../../../../core/component/appbar_widget.dart';
import '../../../../core/component/calculator_table.dart';

class ItemDetailsScreen extends StatelessWidget {
  final CalculatorItem item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(
              text: item.name,
              centre: false,
              showDivider: true,
              // trailing: SvgPicture.asset(AppIcons.save),
            ),
        
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
              child: Column(
                spacing: 4.h,
                children: [
                  BuiltupAreaWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButtonWidget(text: 'Reset',width: 40.w,height: 5.h,
                      buttonColor: Colors.transparent,
                        borderColor: AppColors.blueColor,
                        radius: 2.w,
                        textColor: AppColors.blueColor,
                      ),
                      AppButtonWidget(text: 'Calculate',
                        width: 40.w,height: 5.h,
                        buttonColor: AppColors.blueColor,
                        radius: 2.w,
                        textColor: AppColors.whiteColor,
        
                      )
                    ],
                  ),
                  PricingTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuiltupAreaWidget extends StatelessWidget {
  const BuiltupAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppTextWidget(text:
          "Buildup Area:",

            styleType: StyleType.dialogHeading,
        ),
         SizedBox(width: 2.w),
        Container(
          decoration: BoxDecoration(
            color: AppColors.baseColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left side value
              Container(
                width: 45.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withOpacity(0.1),
                      offset: Offset(0, 1),
                      blurRadius: 1
                    )
                  ]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "0",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    filled: true,

                    fillColor: AppColors.baseColor,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: const Text(
                  "ft²",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}

