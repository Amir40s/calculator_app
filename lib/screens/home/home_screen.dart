import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/model/conversion_calculator/all_calculator_model.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/icon_box_widget.dart';
import 'package:smart_construction_calculator/core/component/success_dialog.dart';
import 'package:smart_construction_calculator/core/controller/calculators/all_calculators.dart';
import 'package:smart_construction_calculator/screens/home/widgets/showAllCalculators.dart';
import '../notification/notification_screen.dart';
import 'category_details/category_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  CalculatorModel? _findCalcByKeywords(
    List<CalculatorModel> calculators,
    List<String> keywords,
  ) {
    final keys = keywords.map((e) => e.trim().toLowerCase()).toList();
    for (final c in calculators) {
      final hay = '${c.title} ${c.routeKey}'.toLowerCase();
      final ok = keys.every((k) => k.isNotEmpty && hay.contains(k));
      if (ok) return c;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final controllerOf = Get.isRegistered<CalculatorController>()
        ? Get.find<CalculatorController>()
        : Get.put(CalculatorController(), permanent: true);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                        text: "Welcome 👋",
                        styleType: StyleType.heading,
                      ),
                      SizedBox(height: 4),
                      AppTextWidget(
                        text: "Need a helping hand today?",
                        styleType: StyleType.subTitle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconBoxWidget(
                        assetPath: AppIcons.search,
                        fit: BoxFit.contain,
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        onTap: () {
                          SuccessDialog.show(context, message: "Added Successfully");
                        },
                      ),
                      SizedBox(width: 3.w),
                      IconBoxWidget(
                        assetPath: AppIcons.notification,
                        fit: BoxFit.contain,
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        onTap: () {
                          Get.to(NotificationScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              /// Top Calculators (fixed picks)
              AppTextWidget(
                text: "Top Calculators",
                styleType: StyleType.dialogHeading,
              ),
              const SizedBox(height: 12),
              Obx(() {
                if (controllerOf.isLoading.value &&
                    (controllerOf.data.value == null ||
                        controllerOf.data.value!.isEmpty)) {
                  return const Center(child: CircularProgressIndicator());
                }

                final calculators = controllerOf.data.value ?? <CalculatorModel>[];

                final topPicks = <_HomePick>[
                  _HomePick(
                    title: 'Bar Bending',
                    subtitle: 'Estimate steel bars and rebar quantity',
                    tint: const Color(0xFFE91E63),
                    keywords: const ['bar', 'bending'],
                  ),
                  _HomePick(
                    title: 'Concrete',
                    subtitle: 'Quick concrete quantity and mix estimates',
                    tint: const Color(0xFF00BCD4),
                    keywords: const ['concrete'],
                  ),
                  _HomePick(
                    title: 'Formwork',
                    subtitle: 'Formwork area and shuttering estimates',
                    tint: const Color(0xFF4CAF50),
                    keywords: const ['formwork'],
                  ),
                  _HomePick(
                    title: 'Cost Estimation',
                    subtitle: 'Cost & material estimation tools',
                    tint: const Color(0xFF7C4DFF),
                    keywords: const ['cost'],
                  ),
                ];

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: topPicks.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.w,
                    mainAxisSpacing: 1.h,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final pick = topPicks[index];
                    final calc =
                        _findCalcByKeywords(calculators, pick.keywords);

                    return _HomeCalculatorCard(
                      title: calc?.title ?? pick.title,
                      subtitle: pick.subtitle,
                      tint: pick.tint,
                      onTap: () {
                        if (calc == null) {
                          AppUtils.showToast(
                            text: 'Coming soon',
                            bgColor: Colors.black87,
                          );
                          return;
                        }
                        Get.to(
                          CategoryDetailScreen(
                            title: calc.title,
                            category: calc.routeKey,
                          ),
                        );
                      },
                    );
                  },
                );
              }),
              SizedBox(height: 2.2.h),

              /// Popular (fixed picks)
              AppTextWidget(
                text: "Popular",
                styleType: StyleType.dialogHeading,
              ),
              const SizedBox(height: 12),
              Obx(() {
                final calculators = controllerOf.data.value ?? <CalculatorModel>[];

                final popularPicks = <_HomePick>[
                  _HomePick(
                    title: 'Block & Plaster',
                    subtitle: 'Blockwork and plaster material estimates',
                    tint: const Color(0xFFFF9800),
                    keywords: const ['block'],
                  ),
                  _HomePick(
                    title: 'Concrete & Formwork Quantity Calculator',
                    subtitle: 'Concrete + formwork quantities in one place',
                    tint: const Color(0xFF3F51B5),
                    keywords: const ['concrete', 'formwork'],
                  ),
                  _HomePick(
                    title: 'Finishing and Interior Estimator',
                    subtitle: 'Finishing & interior quantity estimates',
                    tint: const Color(0xFFD81B60),
                    keywords: const ['finishing'],
                  ),
                  _HomePick(
                    title: 'Doors & Windows Material Calculator',
                    subtitle: 'Door and window material estimates',
                    tint: const Color(0xFF1E88E5),
                    keywords: const ['door', 'window'],
                  ),
                ];

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: popularPicks.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.w,
                    mainAxisSpacing: 1.h,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final pick = popularPicks[index];
                    final calc =
                        _findCalcByKeywords(calculators, pick.keywords);

                    return _HomeCalculatorCard(
                      title: calc?.title ?? pick.title,
                      subtitle: pick.subtitle,
                      tint: pick.tint,
                      onTap: () {
                        if (calc == null) {
                          AppUtils.showToast(
                            text: 'Coming soon',
                            bgColor: Colors.black87,
                          );
                          return;
                        }
                        Get.to(
                          CategoryDetailScreen(
                            title: calc.title,
                            category: calc.routeKey,
                          ),
                        );
                      },
                    );
                  },
                );
              }),
              SizedBox(height: 2.2.h),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: "Find more calculators",
                    styleType: StyleType.dialogHeading,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ShowAllCalculatorsScreen(
                          calculators: controllerOf.data.value ?? [],
                        ),
                      );
                    },
                    child: AppTextWidget(
                      text: "See all",
                      styleType: StyleType.dialogHeading,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Obx(() {
                if (controllerOf.isLoading.value &&
                    (controllerOf.data.value == null ||
                        controllerOf.data.value!.isEmpty)) {
                  return const Center(child: CircularProgressIndicator());
                }

                final calculators = controllerOf.data.value ?? <CalculatorModel>[];

                // Exclude anything already shown in the "Top" and "Popular" sections.
                final shown = <String>{};
                for (final keys in const [
                  ['bar', 'bending'],
                  ['concrete'],
                  ['formwork'],
                  ['cost'],
                  ['block'],
                  ['concrete', 'formwork'],
                  ['finishing'],
                  ['door', 'window'],
                ]) {
                  final c = _findCalcByKeywords(calculators, keys);
                  if (c != null) shown.add(c.routeKey);
                }

                final remaining =
                    calculators.where((c) => !shown.contains(c.routeKey)).toList();

                if (remaining.isEmpty) {
                  return AppTextWidget(
                    text: "No more calculators found.",
                    styleType: StyleType.subTitle,
                    color: AppColors.greyColor,
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.w,
                    mainAxisSpacing: 1.h,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final calc = remaining[index];
                    return _HomeCalculatorCard(
                      title: calc.title,
                      subtitle: "Explore",
                      tint: AppUtils().randomColor(),
                      onTap: () {
                        Get.to(
                          CategoryDetailScreen(
                            title: calc.title,
                            category: calc.routeKey,
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomePick {
  final String title;
  final String subtitle;
  final Color tint;
  final List<String> keywords;

  const _HomePick({
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.keywords,
  });
}

class _HomeCalculatorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color tint;
  final VoidCallback onTap;

  const _HomeCalculatorCard({
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.06)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    AppAssets.splash,
                    fit: BoxFit.cover,
                  ),
                  Container(color: tint.withOpacity(0.35)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h
                ),
                child: AppTextWidget(
                  text: title,
                  styleType: StyleType.subHeading,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
