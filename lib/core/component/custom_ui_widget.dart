import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/result_box_widget.dart';

class CustomUiWidget extends StatelessWidget {
  final String header,total;
  final List<Widget> children;
  const CustomUiWidget({
    super.key,
    required this.header,
    required this.children,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          CostBreakdownHeader(title: header),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
            child: Column(
              spacing: 1.h,
              children: children,
            ),
          ),
          CostBreakdownTotal(
          result: "${total} Rs",
          ),
          SizedBox(height: 2.h,),
        ],
      ),
    );
  }
}
