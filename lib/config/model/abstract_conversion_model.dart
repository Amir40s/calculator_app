abstract class BaseConversionModel {
  final InputData input;
  final Map<String, double> conversions;
  final List<String> availableUnits;

  const BaseConversionModel({
    required this.input,
    required this.conversions,
    required this.availableUnits,
  });

  /// 🔹 Shared helper to safely convert all numeric values to double
  static Map<String, double> normalizeConversions(Map<String, dynamic> jsonMap) {
    return Map<String, double>.fromEntries(
      jsonMap.entries.map(
            (e) => MapEntry(
          e.key,
          (e.value is int)
              ? (e.value as int).toDouble()
              : (e.value as num).toDouble(),
        ),
      ),
    );
  }
}

class InputData {
  final double value;
  final String unit;

  const InputData({
    required this.value,
    required this.unit,
  });

  factory InputData.fromJson(Map<String, dynamic> json) {
    return InputData(
      value: (json['value'] is int)
          ? (json['value'] as int).toDouble()
          : (json['value'] as num).toDouble(),
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'value': value,
    'unit': unit,
  };
}
