import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/all_calculator_model.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/all_calculators.dart';
import '../category_details/category_detail_screen.dart';

class ShowAllCalculatorsScreen extends StatelessWidget {
  final List<CalculatorModel> calculators;
  const ShowAllCalculatorsScreen({super.key, required this.calculators});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculatorController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(text: 'All Calculators'),
            Obx(() {
              if (controller.isLoading.value &&
                  (controller.data.value == null ||
                      controller.data.value!.isEmpty)) {
                return const Center(child: CircularProgressIndicator());
              }
            
              final allCalculators = controller.data.value ?? [];
            
              if (allCalculators.isEmpty) {
                return Center(
                  child: AppTextWidget(
                    text: "No calculators found",
                    styleType: StyleType.subTitle,
                    color: AppColors.greyColor,
                  ),
                );
              }
            
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: allCalculators.length,
                  itemBuilder: (context, index) {
                    final calc = allCalculators[index];
                    return _CalculatorCard(
                      title: calc.title,
                      subtitle: "Explore",
                      tint: AppUtils().randomColor(),
                      onTap: () {
                        Get.to(
                          CategoryDetailScreen(
                            title: calc.title,
                            category: calc.routeKey,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _CalculatorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color tint;
  final VoidCallback onTap;

  const _CalculatorCard({
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 1.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child:Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withOpacity(0.06)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextWidget(
                          text: title,
                          styleType: StyleType.subHeading,
                          maxLine: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3.px),
                        AppTextWidget(
                          text: subtitle,
                          styleType: StyleType.subTitle,
                          color: AppColors.themeColor,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: 3.w),
                    child: Icon(Icons.arrow_forward_ios_sharp,size: 16.px,color: AppColors.themeColor,),
                  )
                ],
              ),
            )
      ),
    );
    }
  
  }
