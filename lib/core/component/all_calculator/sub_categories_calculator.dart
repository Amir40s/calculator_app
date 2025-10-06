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
    'geo-tech-calculator': [
      CategoryItemModel(name: SubCategoryNames.soilBearing),
      CategoryItemModel(name: SubCategoryNames.slopeStability),
      CategoryItemModel(name: SubCategoryNames.retainingWall),
    ],
    'earth-work-calculator': [
      CategoryItemModel(name: SubCategoryNames.cutFill),
      CategoryItemModel(name: SubCategoryNames.excavationVolume),
    ],
  };
}
