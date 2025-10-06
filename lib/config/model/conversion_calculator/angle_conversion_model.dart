
import '../abstract_conversion_model.dart';

class AngleConversionModel extends BaseConversionModel {
  const AngleConversionModel({
    required super.input,
    required super.conversions,
    required super.availableUnits,
  });

  factory AngleConversionModel.fromJson(Map<String, dynamic> json) {
    return AngleConversionModel(
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
