import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/all_calculators.dart';
import '../../../config/model/conversion_calculator/all_calculator_model.dart';
import '../../../core/controller/calculators/conversion/conversion_controller.dart';

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
            AppBarWidget(text: 'All Calculators'),
            Column(
              children: [
                Obx(() {
                  if (controller.isLoading()) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final calculators = controller.data.value ?? [];

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: calculators.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2-column grid
                        crossAxisSpacing: 2.w,
                        mainAxisSpacing: 1.h,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        final calc = calculators[index];
                        return CalculatorGridCard(
                          calc: calc,
                          onTap: () {
                            Get.toNamed(calc.routeKey);
                          },
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class CalculatorGridCard extends StatelessWidget {
  final CalculatorModel calc;
  final VoidCallback? onTap;

  const CalculatorGridCard({
    super.key,
    required this.calc,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.baseColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.baseColor.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 Icon
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: AppColors.blueColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: calc.iconWidget),
            ),
            const SizedBox(height: 10),

            // 🔹 Title
            Text(
              calc.title,
              textAlign: TextAlign.center,

            ),

            const SizedBox(height: 4),

          ],
        ),
      ),
    );
  }
}
