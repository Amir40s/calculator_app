import '../base/base_url.dart';
import '../network/api_services.dart';

class CalculatorRepository {
  final ApiService _apiService = ApiService();

  //get all calculators
  Future<dynamic> getAllCalculators() async {
    final url = BaseUrl.allCalculators;
    return await _apiService.getApi(url: url);
  }

  // 🔹 Length & Distance Converter
  Future<dynamic> convert({
    required String endpoint,
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.lengthDistanceConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  } // 🔹Area Converter

  Future<dynamic> convertLength({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.lengthDistanceConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  } // 🔹Area Converter

  Future<dynamic> convertArea({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.areaConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  // 🔹 Volume Converter
  Future<dynamic> convertVolume({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.volumeConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  } // 🔹 Temperature Converter

  Future<dynamic> convertTemperature({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.temperatureConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> convertForce({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.forceConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> convertAngle({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.angleConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> convertDensity({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.densityConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> convertRebar({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.rebarConverter;
    final body = {"value": value, "fromUnit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> convertConcreteMix({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.concreteMixConverter;
    final body = {"volume": value, "mixRatio": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> convertPowerEnergy({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.powerEnergy;
    final body = {"value": value, "unit": fromUnit};
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> calculateGreyStructure({
    required double builtupArea,
    Map<String, double>? rates,
  }) async {
    final url = Endpoint.greyStructure;

    final body = {
      "builtup_area": builtupArea,
      if (rates != null && rates.isNotEmpty) "rates": rates,
    };

    return await _apiService.postApi(url: url, data: body);
  }
}
