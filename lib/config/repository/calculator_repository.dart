import '../base/base_url.dart';
import '../network/api_services.dart';

class CalculatorRepository {
  final ApiService _apiService = ApiService();

  //get all calculators
  Future<dynamic> getAllCalculators() async {
    final url = BaseUrl.allCalculators;
    return await _apiService.getApi(url: url);
  }
  Future<dynamic> getCompany() async {
    final url = BaseUrl.companyData;
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

    return await _apiService.postApi(url: url, data: body);
  }

  Future<dynamic> calculateWallBlock({
    required Map<String, dynamic> body,

  }) async {
    final url = Endpoint.blockMasonry;

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
    final url = Endpoint.excavation;

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
  Future<dynamic> calculateStoneSoiling({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.stoneSoiling;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> convertRebar({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.rebarConverter;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateLiftPump({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.liftPump;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateBoosterPump({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.boosterPump;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateWoodDoor({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.woodVolume;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  } Future<dynamic> calculateDoorShutterWood({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.doorVolume;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  } Future<dynamic> calculateDoorBeadingWood({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.doorBeading;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  } Future<dynamic> calculateDoorBoq({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.doorBoq;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateWoodMoisture({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.woodMoisture;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculatePaintQuantity({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.paintQuantity;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  } Future<dynamic> calculatePlotConcrete({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.plotLeanConcrete;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }Future<dynamic> calculateConcreteCostEstimatorQuantity({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.concreteCostEstimatorQuantity;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateSlabCostEstimatorQuantity({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.slabCostEstimatorQuantity;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateLShapedStair({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.lShapedStair;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateUShapedStair({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.uShapedStair;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  } Future<dynamic> calculatePlinthBeamLean({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.plinthBeamLean;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  } Future<dynamic> calculatePlinthBeam({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.plinthBeam;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }Future<dynamic> calculateUndergroundWaterTank({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.rccWaterTank;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateRingwallFormworkConcrete({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.ringWallFormwork;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }

  Future<dynamic> calculateOverheadWaterTankFormwork({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.overheadWaterTank;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }

  Future<dynamic> calculateSubstructureColumnFormwork({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.substructureColumnFormwork;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }Future<dynamic> calculateCuringWaterFormwork({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.curingWater;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }
  Future<dynamic> calculateWallPlaster({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.wallRoof;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }

 Future<dynamic> calculateStairConcrete({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.stairConcrete;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }

  Future<dynamic> calculateSpiralStair({
    required Map<String, dynamic> body,
  }) async {
    final url = Endpoint.spiralStair;

    return await _apiService.postApi(
      url: url,
      data: body,
    );
  }


}
