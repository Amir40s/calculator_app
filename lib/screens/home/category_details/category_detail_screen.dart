import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/base/base_url.dart';
import '../../../core/component/all_calculator/sub_categories_calculator.dart';
import '../../../core/component/app_text_widget.dart';
import '../../../core/component/appbar_widget.dart';
import '../../../config/res/app_color.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  final String title;

  const CategoryDetailScreen({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final subCategories = SubCategoryData.subCategories[category] ?? [];

    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(text: title,  showDivider: true),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5.w,),
              shrinkWrap: true,
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                final item = subCategories[index];
                return GestureDetector(
                  onTap: () {
                    // TODO: Navigate to inner calculator later
                    ScreenMapper.navigateToScreen( item.name);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppColors.premiumColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextWidget(
                            text: item.name,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            maxLine: 2,
                          ),
                          Icon(Icons.arrow_forward_ios,size: 16.px,),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
