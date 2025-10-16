import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_text_field.dart';

class TwoFieldsWidget extends StatelessWidget {
  final String heading1,heading2;
  final String? hint,hint2;
  final TextEditingController controller1,controller2;
  const TwoFieldsWidget({super.key, required this.heading1,
    required this.heading2, required this.controller1, required this.controller2,
    this.hint = "0", this.hint2 = "0"});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: AppTextField(
            hintText: hint.toString(),
            controller: controller1,
            heading: heading1,
          ),
        ),
        SizedBox(width: 3.w,),
        Expanded(
          child: AppTextField(
            hintText: hint2.toString(),
            heading: heading2,
            controller: controller2,
          ),
        ),
      ],
    );
}
}
