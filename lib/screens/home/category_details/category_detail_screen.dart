import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/core/component/category_card.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';
import 'package:smart_construction_calculator/screens/home/category_details/item_details/item_details_screen.dart';

import '../../../config/model/calculator_category_model.dart';
import '../../../config/res/app_color.dart';
import '../../../core/component/app_text_widget.dart';
import '../../../core/component/appbar_widget.dart';
import '../../../core/component/custom_appbar.dart';

class CategoryDetailScreen extends StatelessWidget {
  final CalculatorCategory category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppbar(text: 'Conversion Calculator'),
      body: Column(
        children: [
          AppBarWidget(
            text: category.title,
            centre: false,
            showDivider: true,
          ),
          Expanded(
            child: GridView.builder(

              padding: EdgeInsets.symmetric(horizontal: 5.w,),
              shrinkWrap: true,
              itemCount: category.items.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 3.h,
                crossAxisSpacing: 4.w,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final item = category.items[index];
                log('icons are ${item.icon}');

              return GestureDetector(
                onTap: () {
                  Get.to(ItemDetailsScreen(item: item,));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(2.w),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyColor,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.5.w),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(1.w)
                        ),
                        child: SvgPicture.asset(item.icon,height: 30.px,
                          placeholderBuilder: (context) => const Icon(Icons.image_not_supported),

                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal:  2.w),
                        child: AppTextWidget(
                          text: item.name,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLine: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },),
          )
        ],
      ),
    );
  }
}
