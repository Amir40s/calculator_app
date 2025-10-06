
import '../abstract_conversion_model.dart';

class LengthConversionModel extends BaseConversionModel {
  const LengthConversionModel({
    required super.input,
    required super.conversions,
    required super.availableUnits,
  });

  factory LengthConversionModel.fromJson(Map<String, dynamic> json) {
    return LengthConversionModel(
      input: InputData.fromJson(json['input']),
      conversions: BaseConversionModel.normalizeConversions(json['conversions']),
      availableUnits: List<String>.from(json['availableUnits']),
    );
  }
}
