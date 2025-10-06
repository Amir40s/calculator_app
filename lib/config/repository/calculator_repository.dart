import '../base/base_url.dart';
import '../network/api_services.dart';

class CalculatorRepository {
  final ApiService _apiService = ApiService();

  //get all calculators
  Future<dynamic> getAllCalculators() async {
    final url = BaseUrl.allCalculators;
    return await _apiService.getApi( url: url);
  }



  // 🔹 Length & Distance Converter
  Future<dynamic> convertLength({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.lengthDistanceConverter;
    final body = {
      "value": value,
      "fromUnit": fromUnit,
    };
    return await _apiService.postApi(url: url, data: body);
  }  // 🔹Area Converter
  Future<dynamic> convertArea({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.areaConverter;
    final body = {
      "value": value,
      "fromUnit": fromUnit,
    };
    return await _apiService.postApi(url: url, data: body);
  }

  // 🔹 Volume Converter
  Future<dynamic> convertVolume({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.volumeConverter;
    final body = {
      "value": value,
      "fromUnit": fromUnit,
    };
    return await _apiService.postApi(url: url, data: body);
  }  // 🔹 Temperature Converter
  Future<dynamic> convertTemperature({
    required double value,
    required String fromUnit,
  }) async {
    final url = Endpoint.volumeConverter;
    final body = {
      "value": value,
      "fromUnit": fromUnit,
    };
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> calculateConcrete({
    required double volume,
    required String mixRatio,
    required String unit,
  }) async {
    return await _apiService.postApi(
      url: '${BaseUrl.baseUrl}concrete-mix/calculate',
      data: {
        "volume": volume,
        "mixRatio": mixRatio,
        "unit": unit,
      },
    );
  }

  Future<dynamic> calculateGreyStructure({
    required double area,
    required int floors,
    required String materialType,
    required String location,
  }) async {
    return await _apiService.postApi(
      url: '${BaseUrl.baseUrl}grey-structure/calculate',
      data: {
        "area": area,
        "floors": floors,
        "materialType": materialType,
        "location": location,
      },
    );
  }
}
