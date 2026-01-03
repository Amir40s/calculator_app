import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../config/enum/style_type.dart';
import '../../config/model/conversion_calculator/all_calculator_model.dart';
import '../utility/calculator_helpers.dart';
import 'app_text_widget.dart';

class ModernCalculatorCard extends StatelessWidget {
  final CalculatorModel calculator;
  final int index;
  final VoidCallback onTap;

  const ModernCalculatorCard({
    super.key,
    required this.calculator,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tint = CalculatorHelpers.getColorForCalculator(calculator, index);
    final icon = CalculatorHelpers.getIconForCalculator(calculator);
    final image = CalculatorHelpers.getImageForCalculator(calculator);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
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
                  'assets/images/splash.webp',
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                      child: calculator.iconBytes != null
                          ? SizedBox(
                              width: 10.w,
                              height: 10.w,
                              child: calculator.iconWidget,
                            )
                          : Icon(
                              icon,
                              size: 28.px,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  // Title Section
                  Flexible(
                    child: AppTextWidget(
                      text: calculator.title,
                      styleType: StyleType.subHeading,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
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
}

