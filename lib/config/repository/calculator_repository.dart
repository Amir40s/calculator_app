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

  Future<dynamic> calculateFinishingCost({
    required double coveredArea,
    required String quality,
  }) async {
    final url = Endpoint.finishingCostPredictiveCalculator;

    // Constructing the request body
    final body = {
      "coveredArea": coveredArea,
      "quality": quality,
    };

    // Make the POST request and return the response
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> calculateWallBlock({
    required String wallHeight,
    required String wallLength,
    required String blockLength,
    required String blockHeight,
    required String blockWidth,
    required String joint,
    required String mortarRatio,
    required String waterCementRatio,
  }) async {
    final url = Endpoint.blockMasonry;

    final body = {
      "wallHeight": wallHeight,
      "wallLength": wallLength,
      "blockLength": blockLength,
      "blockHeight": blockHeight,
      "blockWidth": blockWidth,
      "joint": blockWidth,
      "mortarRatio": mortarRatio,
      "waterCementRatio": waterCementRatio
    };

    // Make the POST request and return the response
    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> calculateExcavation({
    required String height,
    required String length,
    required String depth,
    required String lengthExtension,
    required String widthExtension,
    required String width,
    required bool showCubicYards,
    required bool useExtensions,
  }) async {
    final url = Endpoint.backfill;

    final body = {
      "depth": depth,
      "length": length,
      "lengthExtension": lengthExtension,
      "showCubicYards": showCubicYards,
      "useExtensions": useExtensions,
      "width": width,
      "widthExtension": widthExtension
    };

    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> calculateBackfill({
    required String compactionFactor,
    required String concreteVolume,
    required String depth,
    required String length,
    required String truckCapacity,
    required String width,
  }) async {
    final url = Endpoint.backfill;

    final body = {
      "depth": depth,
      "length": length,
      "width": width,
      "truckCapacity": truckCapacity,
      "concreteVolume": concreteVolume,
      "compactionFactor": compactionFactor,
    };

    return await _apiService.postApi(url: url, data: body);
  }
  Future<dynamic> calculateSoilCompaction({
    required String compactionFactor,
    required String material,
    required String depth,
    required String length,
    required String unit,
    required String width,
  }) async {
    final url = Endpoint.compaction;

    final body = {
      "depth": depth,
      "length": length,
      "width": width,
      "unit": unit,
      "material": material,
      "compactionFactor": compactionFactor,
    };

    return await _apiService.postApi(url: url, data: body);
  }
  Future<dynamic> calculateLiftPump({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.liftPump;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  } Future<dynamic> calculateBoosterPump({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.boosterPump;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }


}
