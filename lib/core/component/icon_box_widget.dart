import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IconBoxWidget extends StatelessWidget {
  final String? assetPath;
  final IconData? iconData;
  final double size;
  final BoxFit fit;
  final Color? color;
  final Color? bgColor;
  final BoxDecoration? decoration;
  final Widget? errorWidget;
  final AlignmentDirectional? align;
  final VoidCallback? onTap;

  const IconBoxWidget({
    Key? key,
    this.assetPath,
    this.iconData,
    this.size = 25.0,
    this.fit = BoxFit.contain,
    this.color,
    this.bgColor,
    this.decoration,
    this.errorWidget,
    this.align,
    this.onTap,
  })  : assert(assetPath != null || iconData != null, 'Either assetPath or iconData must be provided.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon;

    if (iconData != null) {
      icon = Icon(
        iconData,
        size: size.sp,
        color: color,
      );
    } else {
      final lowerAssetPath = assetPath!.toLowerCase();
      if (lowerAssetPath.endsWith('.svg')) {
        icon = SvgPicture.asset(
          assetPath!,
          width: size.sp,
          height: size.sp,
          fit: fit,
          color: color,
          placeholderBuilder: (context) => Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      } else {
        icon = Image.asset(
          assetPath!,
          width: size.sp,
          height: size.sp,
          fit: fit,
          color: color,
          errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? const Icon(Icons.error_outline),
        );
      }
    }

    return Align(
      alignment: align ??  AlignmentDirectional.center,
      child: GestureDetector(
        onTap: onTap ,
        child: Container(
          width: size.sp,
          height: size.sp,
          decoration: decoration ??
              BoxDecoration(
                color: bgColor,
                shape: BoxShape.rectangle,
              ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          )),
        ),
      ),
    );
  }
}