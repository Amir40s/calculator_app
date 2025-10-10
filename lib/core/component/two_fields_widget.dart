import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_text_field.dart';

class TwoFieldsWidget extends StatelessWidget {
  final String heading1,heading2;
  final TextEditingController controller1,controller2;
  const TwoFieldsWidget({super.key, required this.heading1, required this.heading2, required this.controller1, required this.controller2});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: AppTextField(
            hintText: "0",
            controller: controller1,
            heading: heading1,
          ),
        ),
        SizedBox(width: 3.w,),
        Expanded(
          child: AppTextField(
            hintText: "0",
            heading: heading2,
            controller: controller2,
          ),
        ),
      ],
    );
}
}
