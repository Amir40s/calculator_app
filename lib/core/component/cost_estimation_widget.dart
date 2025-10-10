import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_color.dart';
import 'app_text_widget.dart';

class BuiltupAreaWidget extends StatelessWidget {
  final void Function(String)? onChanged;

  const BuiltupAreaWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          AppTextWidget(text:
          "Buildup Area:",

            styleType: StyleType.dialogHeading,
          ),
          SizedBox(width: 2.w),
          Container(
            decoration: BoxDecoration(
              color: AppColors.baseColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Left side value
                Container(
                  width: 45.w,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.greyColor.withOpacity(0.1),
                            offset: Offset(0, 1),
                            blurRadius: 1
                        )
                      ]
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "0",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      filled: true,

                      fillColor: AppColors.baseColor,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onChanged,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "ft²",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
