import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' show ImageFilter;

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_constants.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';


class LoaderController extends GetxController {
  var isLoading = false.obs;

  void showLoader() => isLoading.value = true;
  void hideLoader() => isLoading.value = false;
}

class Loader extends StatefulWidget {
  final double size;
  final Color? color;
  final String text;
  final Widget? lottie;
  const Loader({super.key, this.size = 45.0, this.color, this.text = '', this.lottie});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: 5,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.lottie != null) widget.lottie ?? SizedBox(),
            if (widget.lottie == null)
              SizedBox(
                height: widget.size,
                width: widget.size,
                child: CustomPaint(
                  painter: _IOSIndicatorPainter(progress: _controller, color: widget.color ?? Colors.black),
                ),
              ),
            if (widget.text.isNotEmpty) SizedBox(height: 2.h),
            if (widget.text.isNotEmpty) AppTextWidget(fontSize: 12.5.sp, text: widget.text),
          ],
        ),
      ),
    );
  }
}

class GlobalLoader extends StatelessWidget {
  final Widget child;
  final Widget? lottie;
  final Color? color;
  const GlobalLoader({super.key, required this.child, this.color, this.lottie});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          AbsorbPointer(absorbing: loaderC.isLoading.value, child: child),
          if (loaderC.isLoading.value) Loader(color: color, lottie: lottie),
        ],
      );
    });
  }
}

class _IOSIndicatorPainter extends CustomPainter {
  final Animation<double> progress;
  final Color color;

  _IOSIndicatorPainter({required this.progress, required this.color}) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 7.0;
    final double radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    const double fullCircle = 2 * 3.141592653589793;
    const double visibleSweep = fullCircle * 0.8;
    final double startAngle = progress.value * fullCircle;

    for (double i = 0; i < visibleSweep; i += 0.1) {
      final double opacity = (i / visibleSweep).clamp(0.0, 1.0);
      paint.color = AppUtils.withOpacity(color: color, opacity: opacity);


      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle + i, 0.1, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BlurryContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double elevation;
  final Color shadowColor;
  final double blur;
  final EdgeInsetsGeometry padding;
  final Color color;
  final BorderRadius borderRadius;

  const BlurryContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.shadowColor = Colors.black26,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: shadowColor,
      color: Colors.transparent,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(height: height, width: width, padding: padding, color: color, child: child),
      ),
    );
  }
}
