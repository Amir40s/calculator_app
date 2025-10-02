import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';

import '../../config/enum/style_type.dart';
import 'app_text_widget.dart';

/// History Tile
class HistoryTile extends StatelessWidget {
  final String title;
  final String time;
  final String icon;
  const HistoryTile({
    super.key,
    required this.title,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey.shade900,
        child: SvgPicture.asset(icon, color: Colors.white),
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: AppTextWidget(text: title),
      ),
      subtitle: AppTextWidget(text: time, styleType: StyleType.subTitle,color: AppColors.greyColor,),
      trailing: AppTextWidget(text: "View Details",textStyle: TextStyle(
       fontSize: 14,
        decoration: TextDecoration.underline,
      )),
    );
  }
}