import 'package:flutter/material.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/screens/home/widgets/concrete_mix_screen.dart';
import 'package:smart_construction_calculator/screens/home/widgets/cost_estimation/cost_estimation_screen.dart';
import 'package:smart_construction_calculator/screens/home/widgets/density_conversion_screen.dart';
import 'package:smart_construction_calculator/screens/home/widgets/earth_work_calculator/excavation_calculator.dart';
import 'package:smart_construction_calculator/screens/home/widgets/force_conversion.dart';
import 'package:smart_construction_calculator/screens/home/widgets/length_distance.dart';
import 'package:smart_construction_calculator/screens/home/widgets/powerNEnergy_screen.dart';
import 'package:smart_construction_calculator/screens/home/widgets/pump_selection_calculator/lift_pump_calculator.dart';
import 'package:smart_construction_calculator/screens/home/widgets/reber_conversion_screen.dart';
import 'package:smart_construction_calculator/screens/home/widgets/temperature_conversion.dart';
import 'package:smart_construction_calculator/screens/home/widgets/volume_conversion_screen.dart';
import '../../../config/routes/routes_name.dart';
import 'earth_work_calculator/soil_compaction_screen.dart';
import 'angle_conversion_screen.dart';
import 'area_conversion.dart';
import 'block_masonry_plaster/wall_block_masonry_plaster_screen.dart';
import 'cost_estimation/finishing_cost_screen.dart';
import 'cost_estimation/grey_structure_screen.dart';
import 'earth_work_calculator/back_fill_calculator.dart';

class SubCategoryScreen extends StatelessWidget {
  final String itemName;

  const SubCategoryScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    print("Category Passed: $itemName");
    /// 🔹 Decide which conversion screen to show
    final Widget child = _getScreenForItem(itemName);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          AppBarWidget(text: itemName, showDivider: true),
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
        return TemperatureConversionScreen(itemName: itemName);
case SubCategoryNames.force:
        return ForceConversionScreen(itemName: itemName);
case SubCategoryNames.angle:
        return AngleConversionScreen(itemName: itemName);
case SubCategoryNames.density:
        return DensityConversionScreen(itemName: itemName);
case SubCategoryNames.rebarSteel:
        return RebarConversionScreen(itemName: itemName);
case SubCategoryNames.concreteMixVolume:
        return ConcreteMixConversionScreen(itemName: itemName);
case SubCategoryNames.powerEnergy:
        return PowerEnergyConversionScreen(itemName: itemName);
case SubCategoryNames.greyStructure:
        return GreyStructureConversionScreen(itemName: itemName);
case SubCategoryNames.finishingCost:
        return FinishingCostScreen(itemName: itemName);
case SubCategoryNames.blockMasonry:
        return BlockMasonryPlasterScreen(itemName: itemName);
case SubCategoryNames.projectCost:
        return CostEstimationScreen(itemName: itemName);
case SubCategoryNames.excavationCalculator:
        return ExcavationCalculatorScreen(itemName: itemName);
case SubCategoryNames.backfillCalculator:
        return BackFillCalculatorScreen(itemName: itemName);
case SubCategoryNames.stoneSoilingCalculator:
        // return BackFillCalculatorScreen(itemName: itemName);
case SubCategoryNames.soilCompactionCalculator:
        return SoilCompactionScreen(itemName: itemName);
case SubCategoryNames.liftPumpCalculator:
        return LiftPumpCalculatorScreen(itemName: itemName);

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
