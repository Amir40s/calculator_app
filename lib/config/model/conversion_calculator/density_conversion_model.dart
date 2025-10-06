
import '../abstract_conversion_model.dart';

class DensityConversionModel extends BaseConversionModel {
  const DensityConversionModel({
    required super.input,
    required super.conversions,
    required super.availableUnits,
  });

  factory DensityConversionModel.fromJson(Map<String, dynamic> json) {
    return DensityConversionModel(
      input: InputData.fromJson(json['input']),
      conversions: BaseConversionModel.normalizeConversions(json['conversions']),
      availableUnits: List<String>.from(json['availableUnits']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input': input.toJson(),
      'conversions': conversions,
      'availableUnits': availableUnits,
    };
  }
}
