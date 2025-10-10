import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_field.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/buttons_row_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/block_masonry/wall_block_masonry_controller.dart';

import '../../../../core/component/two_fields_widget.dart';
import '../../../../core/controller/calculators/cost_estimation/finishing_cost_controller.dart';

class BlockMasonryPlasterScreen extends StatelessWidget {
  final String itemName;
  BlockMasonryPlasterScreen({super.key, required this.itemName});
  final controller = Get.put(WallBlockMasonryController());

  @override
  Widget build(BuildContext context) {
    final text = AppUtils().wallBlock;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: 'Wall Inputs',
                styleType: StyleType.heading,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(2.w),
                  child: Image.asset(AppAssets.wallBlock)),
              Obx(() {
                return AppTextWidget(
                  text: text,
                  maxLine: controller.isExpanded.value ? null : 7,
                  overflow: controller.isExpanded.value
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  styleType: StyleType.subTitle,
                );
              }),
              if (text.length > 100)
                Obx(() {
                  return GestureDetector(
                      onTap: controller.toggleText,
                      child: AppTextWidget(
                        text: controller.isExpanded.value
                            ? 'See Less'
                            : 'See More',
                        textDecoration: TextDecoration.underline,
                        color: AppColors.blueColor,
                      ));
                }),
              SizedBox(
                height: 2.h,
              ),
              TwoFieldsWidget(
                  heading1: 'Wall Height',
                  controller1: controller.wallHeight,
                  controller2: controller.wallLength,
                  heading2: "Wall Length"),
              TwoFieldsWidget(
                  heading1: 'Block Height',
                  controller1: controller.blockHeight,
                  controller2: controller.blockWidth,
                  heading2: "Block Width"),
              TwoFieldsWidget(
                  heading1: 'Block Length',
                  controller1: controller.blockLength,
                  controller2: controller.mortarRatio,
                  heading2: "Mortar Mix Ratio"),
              TwoFieldsWidget(
                  heading1: 'Mortar Joint Thickness',
                  controller1: controller.joint,
                  controller2: controller.waterCementRatio,
                  heading2: "Water-Cement Ratio"),

              ReusableButtonRow(
                firstButtonText: "Add Wall",
                secondButtonText: "Calculate",
                firstButtonAction: () {},
                secondButtonAction: () {
                  controller.convert();
                },
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.blackMasonry.value == null) {
                  return Center(child: Text('No data available'));
                } else {
                  final result = controller.blackMasonry.value!.results[0];
                  return Column(
                    children: [
                      Text("Wall Length: ${result.wallLength}"),
                      Text("Wall Height: ${result.wallHeight}"),
                      // Display other data here
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
