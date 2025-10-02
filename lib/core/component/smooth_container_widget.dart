import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SmoothContainerWidget extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double smoothness;
  final Color? color;
  final BorderSide? border;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry alignment;
  final BoxConstraints? constraints;

  const SmoothContainerWidget({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.smoothness = 0.8,
    this.color,
    this.border,
    this.boxShadow,
    this.alignment = Alignment.center,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: alignment,
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 0),
            blurRadius: 20,
            spreadRadius: 0
          )
        ]
      ),
      constraints: constraints,
      child: SmoothContainer(
        smoothness: smoothness,
        borderRadius: borderRadius ?? BorderRadius.circular(15.px),
        color: color ?? Theme.of(context).cardColor,
        padding: padding ?? EdgeInsets.symmetric(
          horizontal: 15.px,
          vertical: 15.px
        ),
        side: border ?? BorderSide.none,
        child: child,
      ),
    );
  }
}
