
import '../abstract_conversion_model.dart';

class TemperatureConversionModel extends BaseConversionModel {
  const TemperatureConversionModel({
    required super.input,
    required super.conversions,
    required super.availableUnits,
  });

  factory TemperatureConversionModel.fromJson(Map<String, dynamic> json) {
    return TemperatureConversionModel(
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
