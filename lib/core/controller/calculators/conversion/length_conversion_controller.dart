import 'package:get/get.dart';

class LengthConversionController extends GetxController {
  final RxDouble inputValue = 0.0.obs;
  final RxString fromUnit = 'Meter'.obs;
  final RxString toUnit = 'Kilometer'.obs;
  final RxDouble result = 0.0.obs;

  final List<String> units = [
    'Meter',
    'Kilometer',
    'Centimeter',
    'Millimeter',
    'Inch',
    'Foot',
    'Yard',
    'Mile',
  ];

  void convert() {
    double value = inputValue.value;
    double convertedValue = _convertLength(value, fromUnit.value, toUnit.value);
    result.value = convertedValue;
  }

  double _convertLength(double value, String from, String to) {
    // Base: Meter
    final Map<String, double> unitFactors = {
      'Meter': 1.0,
      'Kilometer': 1000.0,
      'Centimeter': 0.01,
      'Millimeter': 0.001,
      'Inch': 0.0254,
      'Foot': 0.3048,
      'Yard': 0.9144,
      'Mile': 1609.34,
    };

    double valueInMeters = value * unitFactors[from]!;
    return valueInMeters / unitFactors[to]!;
  }

  void setInputValue(String text) {
    inputValue.value = double.tryParse(text) ?? 0.0;
  }

  void setFromUnit(String value) {
    fromUnit.value = value;
  }

  void setToUnit(String value) {
    toUnit.value = value;
  }
}
