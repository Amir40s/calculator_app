import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/controller/common_controller.dart';

import '../../core/component/history_card.dart';


class HistoryScreen extends StatelessWidget {
  final  controller = Get.put(CommonController(),);

  final List<String> filters = ["Today", "Last 7 Days", "Last Month"];

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 4.h,),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(filters.length, (index) {
                bool isSelected = controller.selectedIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.changeFilter(index),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.blueColor : Colors.white,
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
        
            // Dynamic Content
            Expanded(
              child: Obx(() {
                final index = controller.selectedIndex.value;
                final list = index == 0
                    ? controller.todayList
                    : index == 1
                    ? controller.weekList
                    : controller.monthList;
        
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    return HistoryCard(
                      history: list[i],
                      onDetailsTap: () {},
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
