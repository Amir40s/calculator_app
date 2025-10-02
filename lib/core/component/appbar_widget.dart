import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';

import 'app_text_widget.dart';
import 'custom_backButton.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    this.showButton = true,
    this.showDivider = false,
    required this.text,
    this.padding,
    this.trailing,
    this.centre = false,
  });
  final bool showButton;
  final bool showDivider;
  final bool centre;
  final String text;
  final EdgeInsets? padding;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding ??
                EdgeInsets.only(
                  right: 4.w,
                  top: 3.h,
                  left: 4.w,
                  bottom: 1.h,
                ),
            child: Row(
              mainAxisAlignment: centre ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                if (showButton)
                  Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: const AppBackButton(),
                  ),
                AppTextWidget(
                  text: text,
                  styleType: StyleType.dialogHeading,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: trailing ?? const SizedBox.shrink(),
                )
              ],
            ),
          ),
          if (showDivider)
            const Divider(
              color: Color(0xffCBCBCB),
            )
        ],
      ),
    );
  }
}
