import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/controller/common_controller.dart';

class FilterWidget extends StatelessWidget {
  final  controller = Get.find<CommonController>();

  final List<String> filters = ["Today", "Last 7 Days", "Last Month"];

  FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(filters.length, (index) {
            bool isSelected = controller.selectedIndex.value == index;
            return GestureDetector(
              onTap: () => controller.changeFilter(index),
              child: Container(
                padding:
                 EdgeInsets.symmetric(horizontal: 25.px, vertical: 5.px),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blueColor : AppColors.baseColor,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: AppTextWidget(text:
                  filters[index],
                  textStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        )),
        const SizedBox(height: 20),

        Obx(() {
          switch (controller.selectedIndex.value) {
            case 0:
              return const Text("Showing data for Today");
            case 1:
              return const Text("Showing data for Last 7 Days");
            case 2:
              return const Text("Showing data for Last Month");
            default:
              return const SizedBox.shrink();
          }
        })
      ],
    );
  }
}
