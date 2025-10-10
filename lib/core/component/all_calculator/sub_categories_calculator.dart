import '../../../config/model/calculator_category_model.dart';
import '../../../config/routes/routes_name.dart';

class SubCategoryData {
  static final Map<String, List<CategoryItemModel>> subCategories = {
    'conversion-calculator': [
      CategoryItemModel(name: SubCategoryNames.lengthDistance),
      CategoryItemModel(name: SubCategoryNames.volumeUnit),
      CategoryItemModel(name: SubCategoryNames.areaUnit),
      CategoryItemModel(name: SubCategoryNames.temperature),
      CategoryItemModel(name: SubCategoryNames.force),
      CategoryItemModel(name: SubCategoryNames.angle),
      CategoryItemModel(name: SubCategoryNames.density),
      CategoryItemModel(name: SubCategoryNames.rebarSteel),
      CategoryItemModel(name: SubCategoryNames.concreteMixVolume),
      CategoryItemModel(name: SubCategoryNames.powerEnergy),
    ],
    'construction-cost-estimation-and-budgetings': [
      CategoryItemModel(name: SubCategoryNames.greyStructure),
      CategoryItemModel(name: SubCategoryNames.finishingCost),
      CategoryItemModel(name: SubCategoryNames.projectCost),
    ],
    'block-masonry-plaster': [
      CategoryItemModel(name: SubCategoryNames.blockMasonry),
      CategoryItemModel(name: SubCategoryNames.wallPlaster),
    ],
    'geo-tech-calculator': [
      CategoryItemModel(name: SubCategoryNames.soilBearing),
      CategoryItemModel(name: SubCategoryNames.slopeStability),
      CategoryItemModel(name: SubCategoryNames.retainingWall),
    ],
    'earth-work-calculator': [
      CategoryItemModel(name: SubCategoryNames.excavationCalculator),
      CategoryItemModel(name: SubCategoryNames.backfillCalculator),
      CategoryItemModel(name: SubCategoryNames.stoneSoilingCalculator),
      CategoryItemModel(name: SubCategoryNames.soilCompactionCalculator),
    ],
    'water-pump-selection-calculator': [
      CategoryItemModel(name: SubCategoryNames.liftPumpCalculator),
      CategoryItemModel(name: SubCategoryNames.boosterPumpCalculator),
    ],

  };
}
