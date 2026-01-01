import 'package:flutter/material.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';

import '../../config/enum/style_type.dart';
import '../../config/res/app_assets.dart';

class LogoTextWidget extends StatelessWidget {
  final Color? color;
  const LogoTextWidget({super.key,  this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.logo,
            height: 80,
              fit: BoxFit.cover
          ),
          // const SizedBox(height: 12.0),
          // AppTextWidget(
          //   text: 'UHCONST',
          //   styleType: StyleType.premiumSize,
          //   lineHeight: 2.0,
          //   color: color,
          // ),
        ],
      ),
    );
  }
}
