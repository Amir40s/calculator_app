import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/all_calculator_model.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/component/modern_calculator_card.dart';
import 'package:smart_construction_calculator/core/controller/calculators/all_calculators.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
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
            const AppBarWidget(text: 'All Calculators',showDivider: true,),
            Obx(() {
              if (controller.isLoading.value &&
                  (controller.data.value == null ||
                      controller.data.value!.isEmpty)) {
                return const Center(child: Loader());
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
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allCalculators.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.w,
                    mainAxisSpacing: 2.h,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final calc = allCalculators[index];
                    return ModernCalculatorCard(
                      calculator: calc,
                      index: index,
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

