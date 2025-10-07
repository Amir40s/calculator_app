import '../abstract_conversion_model.dart';

class PowerEnergyModel extends BaseConversionModel {
  final PowerEnergyInput powerInput;
  final Map<String, PowerEnergyResult> results;

  PowerEnergyModel({
    required this.powerInput,
    required this.results,
  }) : super(
    input: InputData(
      value: powerInput.value,
      unit: powerInput.unit,
    ),
    conversions: results.map((key, value) => MapEntry(key, value.value)),
    availableUnits: results.keys.toList(),
  );

  factory PowerEnergyModel.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, PowerEnergyResult.fromJson(value)),
    );

    return PowerEnergyModel(
      powerInput: PowerEnergyInput.fromJson(json['input']),
      results: results,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'input': powerInput.toJson(),
    'results': results.map((k, v) => MapEntry(k, v.toJson())),
  };
}

class PowerEnergyInput {
  final double value;
  final String unit;

  PowerEnergyInput({
    required this.value,
    required this.unit,
  });

  factory PowerEnergyInput.fromJson(Map<String, dynamic> json) {
    return PowerEnergyInput(
      value: (json['value'] as num).toDouble(),
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
    'value': value,
    'unit': unit,
  };
}

class PowerEnergyResult {
  final String name;
  final double value;

  PowerEnergyResult({
    required this.name,
    required this.value,
  });

  factory PowerEnergyResult.fromJson(Map<String, dynamic> json) {
    return PowerEnergyResult(
      name: json['name'],
      value: (json['value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
  };
}
