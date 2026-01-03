
import 'dart:developer';

import 'package:get/get.dart';
import 'package:smart_construction_calculator/screens/home/widgets/length_distance.dart';

import '../../screens/home/widgets/sub_category_screen.dart';
import '../routes/routes_name.dart';

class BaseUrl{

  static const baseUrl = "https://construction-api-nine.vercel.app/api/calculators";
  static const allCalculators = "https://construction-api-nine.vercel.app/calculators";
  static const companyData = "https://construction-api-nine.vercel.app/company";



}


class Endpoint{
//conversion calculator

  static const   lengthDistanceConverter = "${BaseUrl.baseUrl}/length-distance/convert/";
  static const finishingCostPredictiveCalculator = "${BaseUrl.baseUrl}/finishing-cost-predictive/calculate";
  static const  volumeConverter = "${BaseUrl.baseUrl}/volume/convert";
  static const  areaConverter = "${BaseUrl.baseUrl}/area/convert";
  static const  temperatureConverter = "${BaseUrl.baseUrl}/temperature/convert";
  static const  forceConverter = "${BaseUrl.baseUrl}/force/convert";
  static const  angleConverter = "${BaseUrl.baseUrl}/angle/convert";
  static const  densityConverter = "${BaseUrl.baseUrl}/density/convert";
  static const  rebarConverter = "${BaseUrl.baseUrl}/rebar/calculate";
  static const  concreteMixConverter = "${BaseUrl.baseUrl}/concrete-mix/calculate";
  static const  powerEnergy = "${BaseUrl.baseUrl}/power-energy/convert";
  static const  greyStructure = "${BaseUrl.baseUrl}/grey-structure/calculate";
  static const  woodVolume = "${BaseUrl.baseUrl}/wood-volume/calculate";
  static const  doorVolume = "${BaseUrl.baseUrl}/door-volume/calculate";
  static const  doorBeading = "${BaseUrl.baseUrl}/door-beading/calculate";
  static const  doorBoq = "${BaseUrl.baseUrl}/door-boq/calculate";
  static const  woodMoisture = "${BaseUrl.baseUrl}/moisture-content/calculate";
  static const  paintQuantity = "${BaseUrl.baseUrl}/paint/calculate";
  static const  blockMasonry = "${BaseUrl.baseUrl}/wall-block-mortar/calculate";
  static const  wallRoof = "${BaseUrl.baseUrl}/plaster/calculate";
  static const  excavation = "${BaseUrl.baseUrl}/excavation/calculate";
  static const  backfill = "${BaseUrl.baseUrl}/backfill/calculate";
  static const  compaction = "${BaseUrl.baseUrl}/compaction/calculate";
  static const  liftPump = "${BaseUrl.baseUrl}/liftpumpv2/calculate";
  static const  stoneSoiling = "${BaseUrl.baseUrl}/stone-soiling/calculate";
  static const  boosterPump = "${BaseUrl.baseUrl}/pumpv2/calculate";
  static const  plotLeanConcrete = "${BaseUrl.baseUrl}/lean-concrete/calculate";
  static const  concreteCostEstimatorQuantity = "${BaseUrl.baseUrl}/concrete/calculate";
  static const  slabCostEstimatorQuantity = "${BaseUrl.baseUrl}/slab-concrete/calculate";
  static const  lShapedStair = "${BaseUrl.baseUrl}/l-shaped-stair/calculate";
  static const  uShapedStair = "${BaseUrl.baseUrl}/u-shaped-stair/calculate";
  static const  plinthBeamLean = "${BaseUrl.baseUrl}/plinth-lean-beam/calculate";
  static const  plinthBeam = "${BaseUrl.baseUrl}/plinth-beam/calculate";
  static const  rccWaterTank = "${BaseUrl.baseUrl}/rcc-water-tank/calculate";
  static const  ringWallFormwork = "${BaseUrl.baseUrl}/retaining-wall/calculate";
  static const  overheadWaterTank = "${BaseUrl.baseUrl}/Underground-tank/calculate";
  static const  substructureColumnFormwork = "${BaseUrl.baseUrl}/rcc-column/calculate";
  static const  curingWater = "${BaseUrl.baseUrl}/curing-water/calculate";
  static const  stairConcrete = "${BaseUrl.baseUrl}/stair-concrete/calculate";
  static const  spiralStair = "${BaseUrl.baseUrl}/ms-spiral-stair/calculate";
}


class ScreenMapper {
  static void navigateToScreen(String itemName) {
    log("item name is ${itemName}");
    Get.to(() => SubCategoryScreen(itemName: itemName));
  }
}
