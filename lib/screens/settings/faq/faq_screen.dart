import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/controller/common_controller.dart';

import '../../../core/component/app_text_widget.dart';
import '../../../core/component/collapsable_widget.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommonController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(text: 'FAQs',showDivider: true,),
          Padding(
            padding:  EdgeInsets.symmetric( horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: controller.sections.length,
                    itemBuilder: (context, sectionIndex) {
                      final section = controller.sections[sectionIndex];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(bottom: 1.6.h),
                            child: AppTextWidget(text:
                              section.title,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.premiumColor
                              ),
                            ),
                          ),

                          // Section Items
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: section.items.length,
                            itemBuilder: (context, index) {
                              return CollapsibleHistoryWidget(
                                index: index,
                                list: section.items,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
