
import '../abstract_conversion_model.dart';

class VolumeConversionModel extends BaseConversionModel {
  const VolumeConversionModel({
    required super.input,
    required super.conversions,
    required super.availableUnits,
  });

  factory VolumeConversionModel.fromJson(Map<String, dynamic> json) {
    //change all conversion values to double

    return VolumeConversionModel(
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
