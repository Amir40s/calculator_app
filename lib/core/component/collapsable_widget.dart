import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/model/faq_model.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/controller/common_controller.dart';

class CollapsibleHistoryWidget extends StatelessWidget {
  final int index;
  final RxList<FaqItem> list;
  final CommonController controller = Get.find<CommonController>();

  CollapsibleHistoryWidget({super.key, required this.index, required this.list});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = list[index];

      return Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () => controller.toggle(list, index),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppTextWidget(text:
                    item.title,
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    item.isVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),

            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: item.isVisible
                  ? Padding(
                padding: EdgeInsets.only(top: 10.px, bottom: 5.px),
                child: AppTextWidget(
                  text: item.content,
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5.px,
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),

            Divider(),
          ],
        ),
      );
    });
  }
}
