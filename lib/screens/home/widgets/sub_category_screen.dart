import 'package:flutter/material.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/screens/home/widgets/length_distance.dart';
import 'package:smart_construction_calculator/screens/home/widgets/volume_conversion_screen.dart';
import '../../../config/routes/routes_name.dart';
import 'area_conversion.dart';

class SubCategoryScreen extends StatelessWidget {
  final String itemName;

  const SubCategoryScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    /// 🔹 Decide which conversion screen to show
    final Widget child = _getScreenForItem(itemName);

    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            text: itemName,
            showDivider: true,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Helper function to map category name to its respective screen
  Widget _getScreenForItem(String itemName) {
    switch (itemName) {
      case SubCategoryNames.lengthDistance:
        return LengthConversionScreen(itemName: itemName);
      case SubCategoryNames.volumeUnit:
        return VolumeConversionScreen(itemName: itemName);

      case SubCategoryNames.areaUnit:
        return AreaConversionScreen(itemName: itemName);
case SubCategoryNames.temperature:
        return AreaConversionScreen(itemName: itemName);

      default:
        return Center(
          child: Text(
            'Coming soon: $itemName',
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
    }
  }
}
