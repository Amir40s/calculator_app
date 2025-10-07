// 📁 concrete_mix_model.dart
import '../abstract_conversion_model.dart';

class ConcreteInput extends InputData {
  final String mixRatio;
  final double volume;

  ConcreteInput({
    required this.mixRatio,
    required this.volume,
    required super.value, required super.unit,
  });

  factory ConcreteInput.fromJson(Map<String, dynamic> json) {
    return ConcreteInput(
      mixRatio: json['mixRatio'] ?? '',
      volume: (json['volume'] as num).toDouble(),
      unit: '',
      value: 0.0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'mixRatio': mixRatio,
      'volume': volume,
    };
  }
}

class ConcreteMixModel extends BaseConversionModel {
  const ConcreteMixModel({
    required ConcreteInput input,
    required Map<String, double> conversions,
  }) : super(
    input: input,
    conversions: conversions,
    availableUnits: const [], // Not needed here, but required by base
  );

  factory ConcreteMixModel.fromJson(Map<String, dynamic> json) {
    final inputJson = json['input'] as Map<String, dynamic>;
    final resultsJson = json['results'] as Map<String, dynamic>;

    return ConcreteMixModel(
      input: ConcreteInput.fromJson(inputJson),
      conversions: BaseConversionModel.normalizeConversions(resultsJson),
    );
  }
}
