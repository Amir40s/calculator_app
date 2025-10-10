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
import '../../../../core/component/buttons_row_widget.dart';
import '../../../../core/component/calculator_table.dart';
import '../../../../core/component/cost_estimation_widget.dart';

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
                  ReusableButtonRow(
                    firstButtonText: 'Reset',
                    secondButtonText: 'Calculate',
                    firstButtonAction: () {
                      // Your Reset button action
                    },
                    secondButtonAction: () {
                      // Your Calculate button action
                    },
                    firstButtonColor: Colors.transparent,
                    secondButtonColor: AppColors.blueColor,
                    firstButtonTextColor: AppColors.blueColor,
                    secondButtonTextColor: AppColors.whiteColor,
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


