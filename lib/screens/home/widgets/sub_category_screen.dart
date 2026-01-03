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
import 'package:smart_construction_calculator/screens/home/widgets/pump_selection_calculator/booster_pump_calculator.dart';
import 'package:smart_construction_calculator/screens/home/widgets/pump_selection_calculator/lift_pump_calculator.dart';
import 'package:smart_construction_calculator/screens/home/widgets/reber_conversion_screen.dart';
import 'package:smart_construction_calculator/screens/home/widgets/temperature_conversion.dart';
import 'package:smart_construction_calculator/screens/home/widgets/volume_conversion_screen.dart';
import '../../../config/routes/routes_name.dart';
import 'concrete_formwork_quality/curing_water_estimator_calculator.dart';
import 'concrete_formwork_quality/foundation_formwork_concrete.dart';
import 'concrete_formwork_quality/over_head_watertank_formwork.dart';
import 'concrete_formwork_quality/ringwall_formwork_concrete.dart';
import 'concrete_formwork_quality/stair_concrete_calculator.dart';
import 'concrete_formwork_quality/substructure_column_formwork.dart';
import 'concrete_formwork_quality/superStructure_beam_formwork_concrete_calculator.dart';
import 'concrete_formwork_quality/superstructure_column_formwork.dart';
import 'concrete_formwork_quality/underground_water_tank.dart';
import 'concrete_formwork_quality/concrete_cost_estimator.dart';
import 'concrete_formwork_quality/l_shaped_stair.dart';
import 'concrete_formwork_quality/plinth_beam_concrete.dart';
import 'concrete_formwork_quality/plinth_beam_lean.dart';
import 'concrete_formwork_quality/plot_clean_screen.dart';
import 'concrete_formwork_quality/slab_concrete.dart';
import 'concrete_formwork_quality/u_shaped_stair.dart';
import 'block_masonry_plaster/wall_roof_plaster.dart';
import 'door_n_windows_calculator/door_beeding.dart';
import 'door_n_windows_calculator/door_boq_screen.dart';
import 'door_n_windows_calculator/door_shutter_wood_screen.dart';
import 'door_n_windows_calculator/wood_door_estimate_screen.dart';
import 'door_n_windows_calculator/wood_moisture_content.dart';
import 'earth_work_calculator/soil_compaction_screen.dart';
import 'angle_conversion_screen.dart';
import 'area_conversion.dart';
import 'block_masonry_plaster/wall_block_masonry_plaster_screen.dart';
import 'cost_estimation/finishing_cost_screen.dart';
import 'cost_estimation/grey_structure_screen.dart';
import 'earth_work_calculator/back_fill_calculator.dart';
import 'earth_work_calculator/stone_soiling_calculation.dart';
import 'finshing_interior_estimator/paint_quantity_calculator.dart';
import 'finshing_interior_estimator/spiral_ms_stair_material_calculator.dart';

class SubCategoryScreen extends StatelessWidget {
  final String itemName;

  const SubCategoryScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    print("Category Passed: $itemName");

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
        return StoneSoilingCalculatorScreen(itemName: itemName);
      case SubCategoryNames.soilCompactionCalculator:
        return SoilCompactionScreen(itemName: itemName);
      case SubCategoryNames.liftPumpCalculator:
        return LiftPumpCalculatorScreen(itemName: itemName);
      case SubCategoryNames.boosterPumpCalculator:
        return BoosterPumpCalculatorScreen(itemName: itemName);
      case SubCategoryNames.woodDoorEstimate:
        return WoodDoorEstimateScreen(itemName: itemName);
      case SubCategoryNames.doorShutterEstimate:
        return DoorShutterWoodScreen(itemName: itemName);
      case SubCategoryNames.doorBeadingEstimate:
        return DoorBeadingScreen(itemName: itemName);
      case SubCategoryNames.doorBOQEstimate:
        return DoorBoqScreen(itemName: itemName);
      case SubCategoryNames.woodMoistureEstimate:
        return WoodMoistureContentScreen(itemName: itemName);

      case SubCategoryNames.plotClean:
        return PlotCleanScreen(itemName: itemName);
      case SubCategoryNames.concreteCost:
        return ConcreteCostEstimatorScreen(itemName: itemName);
      case SubCategoryNames.slabConcrete:
        return SlabConcreteScreen(itemName: itemName);
      case SubCategoryNames.lShapedStairConcreteVolume:
        return LShapedStairScreen(itemName: itemName);
      case SubCategoryNames.uShapedStairConcreteVolume:
        return UShapedStairScreen(itemName: itemName);
      case SubCategoryNames.plinthBeamLeanConcrete:
        return PlinthBeamLeanScreen(itemName: itemName);
      case SubCategoryNames.plinthBeamConcrete:
        return PlinthBeamConcreteScreen(itemName: itemName);
      case SubCategoryNames.undergroundWaterTankConcrete:
        return UndergroundWaterTankScreen(itemName: itemName);
      case SubCategoryNames.ringwallFormworkConcrete:
        return RingwallFormworkConcreteScreen(itemName: itemName);
      case SubCategoryNames.overheadWaterTankFormworkConcrete:
        return OverheadWaterTankFormworkScreen(itemName: itemName);
      case SubCategoryNames.substructureColumnFormworkConcrete:
        return SubstructureColumnFormwork(itemName: itemName);
      case SubCategoryNames.superStructureColumnFormworkConcrete:
        return SuperstructureColumnFormworkScreen(itemName: itemName);
      case SubCategoryNames.foundationFormworkConcrete:
        return FoundationFormworkConcreteScreen(itemName: itemName);
      case SubCategoryNames.superstructureBeamFormworkConcrete:
        return SuperstructureBeamFormworkConcreteCalculator(itemName: itemName);
      case SubCategoryNames.concreteCuringWater:
        return CuringWaterEstimatorCalculatorScreen(itemName: itemName);
      case SubCategoryNames.stairConcreteEstimator:
        return StairConcreteCalculator(itemName: itemName);
        //finishing and interior estimating
      case SubCategoryNames.paintQuantity:
        return PaintQuantityCalculatorScreen(itemName: itemName);
      case SubCategoryNames.modularKitchen:
        return PaintQuantityCalculatorScreen(itemName: itemName);
      case SubCategoryNames.wardrobeMaterialCostEstimator:
        return PaintQuantityCalculatorScreen(itemName: itemName);
       case SubCategoryNames.woodenSolidDoorPolishMaterial:
        return PaintQuantityCalculatorScreen(itemName: itemName);
      case SubCategoryNames.spiralMsStairMaterial:
        return SpiralMsStairMaterialCalculator(itemName: itemName);
      case SubCategoryNames.multiBathVanityEstimator:
        return PaintQuantityCalculatorScreen(itemName: itemName);

      case SubCategoryNames.wallPlaster:
        return WallRoofPlasterScreen(itemName: itemName);
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
