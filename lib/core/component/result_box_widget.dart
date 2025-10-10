import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import '../../../../config/res/app_color.dart';
import '../../../../core/controller/calculators/cost_estimation/finishing_cost_controller.dart';
import '../../config/enum/style_type.dart';

class CostBreakdown extends StatelessWidget {
  final FinishingCostController controller;

  const CostBreakdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        final result = controller.finishingCostData.value;
        // Check if the result is null or if the required data is empty
        if (result == null || result.groups.isEmpty) {
          return Center(
              child: Text(
            "No data available",
          ));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Static Header for "Cost Breakdown"
            Container(
              width: 100.w,
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CostBreakdownHeader(
                        title: "Cost Breakdown",
                      ),
                      ...result.groups.map((group) {
                            double totalGroupAmount = group.rows
                                .fold(0.0, (sum, row) => sum + row.amount);

                            return Padding(
                              padding: EdgeInsets.all(2.5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                      text: group.name,
                                      styleType: StyleType.subHeading),

                                  ...group.rows.map((row) {
                                    return ResultBoxTile(
                                      subHeading: row.note,
                                      price: row.amount.toStringAsFixed(0),
                                      heading: row.name,
                                    );
                                  }),

                                  // Display subtotal for the group
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: "Subtotal:",
                                      ),
                                      AppTextWidget(
                                        text: totalGroupAmount.toStringAsFixed(0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h), // Space between groups
                                ],
                              ),
                            );
                          }).toList() ??
                          [],
                    ],
                  ),
                  CostBreakdownTotal(result: result.total.toStringAsFixed(0))
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CostBreakdownHeader(title: "Monthly Expense"),
                  ...result.monthly.asMap().entries.map((entry) {
                    int index = entry.key + 1;
                    double monthAmount = entry.value;
                    return CostBreakdownTotal(
                      title: ' Month $index ',
                      result: "PKR ${monthAmount.toStringAsFixed(0)}",
                      color: Colors.transparent,
                    );
                  }),
                ],
              ),
            ),
            CostBreakdownTotal(result: result.total.toStringAsFixed(0)),
            SizedBox(
              height: 2.h,
            )
          ],
        );
      }
    });
  }
}

class ResultBoxTile extends StatelessWidget {
  final String heading, subHeading;
  final String price;

  const ResultBoxTile({
    super.key,
    required this.heading,
    required this.subHeading,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: heading,
                    textStyle: TextStyle(fontSize: 16.px),
                  ),
                  Container(
                    width: MediaQuery.widthOf(context) * 0.6,
                    child: AppTextWidget(
                      text: subHeading,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      styleType: StyleType.subTitle,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: AppTextWidget(
                  text: "PKR ${price.toString()}",
                  textStyle:
                      TextStyle(fontSize: 14.px, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Container(height: 0.1.h, color: AppColors.greyColor),
        ],
      ),
    );
  }
}

class CostBreakdownHeader extends StatelessWidget {
  final String title;

  const CostBreakdownHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(2.5.w),
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2.w),
          topRight: Radius.circular(2.w),
        ),
      ),
      child: AppTextWidget(
        text: title,
        color: AppColors.whiteColor,
        styleType: StyleType.dialogHeading,
      ),
    );
  }
}

class CostBreakdownTotal extends StatelessWidget {
  final String? title;
  final String? result;
  final Color color;

  const CostBreakdownTotal({
    super.key,
    this.title = 'Total',
    this.result,
    this.color = AppColors.blueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(2.5.w),
      margin: EdgeInsets.symmetric(vertical: 0.5.w, horizontal: 2.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(2.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextWidget(
            text: title.toString(),
            color: color == AppColors.blueColor
                ? AppColors.whiteColor
                : AppColors.blackColor,
            styleType: StyleType.dialogHeading,
          ),
          AppTextWidget(
            text: result.toString().isNotEmpty == true ? result.toString() : 'N/A',

            textStyle: TextStyle(fontSize: 14.px, fontWeight: FontWeight.w500, color: color == AppColors.blueColor
                ? AppColors.whiteColor
                : AppColors
                .blackColor,),
          ),
        ],
      ),
    );
  }
}

class ResultList extends StatelessWidget {
  final String value,price;
  const ResultList({super.key, required this.value, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          text: value,
          textStyle: TextStyle(fontSize: 16.px,fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: AppTextWidget(
            text: "${price.toString()} Rs",
            textStyle: TextStyle(fontSize: 14.px, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
