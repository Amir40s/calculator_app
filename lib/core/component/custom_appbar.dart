
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../config/enum/style_type.dart';
import '../../config/res/app_color.dart';
import 'app_text_widget.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool showBackButton;
  final Widget? trailing;
  final StyleType? styleType;

  const CustomAppbar({
    super.key,
    required this.text,

    this.trailing,
    this.showBackButton = true, this.styleType,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SafeArea(
        child: Container(
          height: 56.px,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (showBackButton)
                GestureDetector(
                  child: const Icon(Icons.arrow_back_ios, size: 20,color: Colors.white),
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              Expanded(
                child:
                AppTextWidget(text: text,
                  styleType: styleType ?? StyleType.subHeading,color: AppColors.whiteColor,),

              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
