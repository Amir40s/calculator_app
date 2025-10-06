class AreaConversionModel {
  final AreaConversionInput input;
  final Map<String, num> conversions;
  final List<String> availableUnits;

  AreaConversionModel({
    required this.input,
    required this.conversions,
    required this.availableUnits,
  });

  /// 🔹 From JSON
  factory AreaConversionModel.fromJson(Map<String, dynamic> json) {
    return AreaConversionModel(
      input: AreaConversionInput.fromJson(json['input']),
      conversions: Map<String, num>.from(json['conversions']),
      availableUnits: List<String>.from(json['availableUnits']),
    );
  }

  /// 🔹 To JSON
  Map<String, dynamic> toJson() {
    return {
      'input': input.toJson(),
      'conversions': conversions,
      'availableUnits': availableUnits,
    };
  }
}

class AreaConversionInput {
  final num value;
  final String unit;

  AreaConversionInput({
    required this.value,
    required this.unit,
  });

  factory AreaConversionInput.fromJson(Map<String, dynamic> json) {
    return AreaConversionInput(
      value: json['value'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'unit': unit,
    };
  }
}
