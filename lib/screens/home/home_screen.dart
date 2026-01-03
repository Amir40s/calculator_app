import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import 'package:smart_construction_calculator/screens/home/widgets/showAllCalculators.dart';
import '../../core/component/modern_calculator_card.dart';
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
                  return const Center(child: Loader());
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

                return SizedBox(
                  height: 12.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topPicks.length,
                    itemExtent: 45.w,
                    padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 2.h),
                    itemBuilder: (context, index) {
                      final pick = topPicks[index];
                      final calc =
                          _findCalcByKeywords(calculators, pick.keywords);

                      IconData iconPath = LucideIcons.building2;
                      if (pick.keywords.contains('bar') || pick.keywords.contains('bending')) {
                        iconPath = LucideIcons.building2;
                      } else if (pick.keywords.contains('concrete')) {
                        iconPath = LucideIcons.building2;
                      } else if (pick.keywords.contains('formwork')) {
                        iconPath =LucideIcons.circleSmall;
                      } else if (pick.keywords.contains('cost')) {
                        iconPath = LucideIcons.handCoins;
                      }

                      return Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: pick.tint.withOpacity(0.1),
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
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 12.w,
                                  height: 12.w,
                                  decoration: BoxDecoration(
                                    color: pick.tint.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    iconPath,
                                    size: 24.px,
                                    color: pick.tint,
                                  ),
                                ),
                                SizedBox(width: 1.h),
                                Flexible(
                                  child: AppTextWidget(
                                    text: calc?.title ?? pick.title,
                                    styleType: StyleType.subHeading,
                                    maxLine: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // SizedBox(height: 0.5.h),
                                // Flexible(
                                //   child: AppTextWidget(
                                //     text: pick.subtitle,
                                //     styleType: StyleType.subTitle,
                                //     color: AppColors.greyColor,
                                //     maxLine: 2,
                                //     overflow: TextOverflow.ellipsis,
                                //     textAlign: TextAlign.center,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 2.2.h),

              AppTextWidget(
                text: "Popular Categories",
                styleType: StyleType.dialogHeading,
              ),
              const SizedBox(height: 12),
              Obx(() {
                final calculators = controllerOf.data.value ?? <CalculatorModel>[];

                final popularPicks = <_HomePick>[
                  _HomePick(
                    title: 'Block & Plaster',
                    subtitle: 'Blockwork and plaster material estimates',
                    tint: const Color(0xFF60A5FA),
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

                return SizedBox(
                  height: 22.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularPicks.length,
                    itemExtent: 50.w,
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    itemBuilder: (context, index) {
                      final pick = popularPicks[index];
                      final calc =
                          _findCalcByKeywords(calculators, pick.keywords);

                      // Create a temporary CalculatorModel if calc is null
                      final displayCalc = calc ?? CalculatorModel(
                        id: 'temp_$index',
                        title: pick.title,
                        routeKey: 'temp_$index',
                      );

                      return Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: _PopularPickCard(
                                title: pick.title,
                                subtitle: pick.subtitle,
                                tint: pick.tint,
                                index: index,
                                onTap: () {
                                  Get.to(
                                    CategoryDetailScreen(
                                      title: calc?.title ??"",
                                      category: calc?.routeKey ??"",
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  ),
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
                    child: Row(
                      children: [
                        AppTextWidget(
                          text: "See all",
                          styleType: StyleType.dialogHeading,
                        ),
                        SizedBox(width: 1.w),
                        Icon(
                          LucideIcons.arrowRight,
                          size: 18.px,
                          color: AppColors.blueColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Obx(() {
                if (controllerOf.isLoading.value &&
                    (controllerOf.data.value == null ||
                        controllerOf.data.value!.isEmpty)) {
                  return const Center(child: Loader());
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
                  return Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppTextWidget(
                      text: "No more calculators found.",
                      styleType: StyleType.subTitle,
                      color: AppColors.greyColor,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                // Show up to 6 items in a 2x3 grid
                final displayItems = remaining.take(6).toList();

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.w,
                    mainAxisSpacing: 2.h,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final calc = displayItems[index];
                    return ModernCalculatorCard(
                      calculator: calc,
                      index: index,
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

class _PopularPickCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color tint;
  final int index;
  final VoidCallback onTap;

  const _PopularPickCard({
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icon = _getIconForPick(title);
    final image = _getImageForPick(title);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: tint.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: tint.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppAssets.splash,
                  fit: BoxFit.cover,
                );
              },
            ),
            // Tint Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    tint.withOpacity(0.6),
                    tint.withOpacity(0.5),
                  ],
                ),
              ),
            ),
            // Content on top
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Section
                  Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: tint.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: tint.withOpacity(0.8),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 28.px,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  // Title Section
                  AppTextWidget(
                    text: title,
                    styleType: StyleType.subHeading,
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                  SizedBox(height: 0.3.h),
                  // Subtitle Section
                  AppTextWidget(
                    text: subtitle,
                    styleType: StyleType.subTitle,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 11,
                  ),
                  const Spacer(),
                  // Explore Badge
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: tint.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        LucideIcons.arrowRight,
                        size: 12.px,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForPick(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('block') || lowerTitle.contains('plaster')) {
      return LucideIcons.hammer;
    } else if (lowerTitle.contains('concrete') || lowerTitle.contains('formwork')) {
      return LucideIcons.building2;
    } else if (lowerTitle.contains('finishing') || lowerTitle.contains('interior')) {
      return LucideIcons.palette;
    } else if (lowerTitle.contains('door') || lowerTitle.contains('window')) {
      return LucideIcons.doorOpen;
    }
    return LucideIcons.calculator;
  }

  String _getImageForPick(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('block') || lowerTitle.contains('plaster')) {
      return AppAssets.wallBlock;
    } else if (lowerTitle.contains('concrete') || lowerTitle.contains('formwork')) {
      return AppAssets.categoryConcrete;
    } else if (lowerTitle.contains('finishing') || lowerTitle.contains('interior')) {
      return AppAssets.finishingInteriorCategory;
    } else if (lowerTitle.contains('door') || lowerTitle.contains('window')) {
      return AppAssets.doorsWindowsCategory;
    }
    return AppAssets.splash;
  }
}
