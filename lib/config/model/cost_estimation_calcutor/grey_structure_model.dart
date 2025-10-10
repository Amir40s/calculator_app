import 'package:smart_construction_calculator/config/utility/app_utils.dart';


class GreyStructureModel {
  final double builtupArea;
  final double excavationCost;
  final double cementCost;
  final double sandCost;
  final double aggregateCost;
  final double waterCost;
  final double steelCost;
  final double blockCost;
  final double backFillMaterialCost;
  final double doorFrameCost;
  final double electricalConduitingCost;
  final double sewageCost;
  final double miscellaneousCost;
  final double laborCost;
  final double projectManagementCost;
  final double totalCost;
  final List<MonthlyDistribution> monthlyDistribution;

  GreyStructureModel({
    required this.builtupArea,
    required this.excavationCost,
    required this.cementCost,
    required this.sandCost,
    required this.aggregateCost,
    required this.waterCost,
    required this.steelCost,
    required this.blockCost,
    required this.backFillMaterialCost,
    required this.doorFrameCost,
    required this.electricalConduitingCost,
    required this.sewageCost,
    required this.miscellaneousCost,
    required this.laborCost,
    required this.projectManagementCost,
    required this.totalCost,
    required this.monthlyDistribution,
  });

  factory GreyStructureModel.fromJson(Map<String, dynamic> json) {
    final data = json['results'] ?? json;

    return GreyStructureModel(
      builtupArea: AppUtils().toRoundedDouble(data['builtup_area']),
      excavationCost: AppUtils().toRoundedDouble(data['excavationCost']),
      cementCost: AppUtils().toRoundedDouble(data['cementCost']),
      sandCost: AppUtils().toRoundedDouble(data['sandCost']),
      aggregateCost: AppUtils().toRoundedDouble(data['aggregateCost']),
      waterCost: AppUtils().toRoundedDouble(data['waterCost']),
      steelCost: AppUtils().toRoundedDouble(data['steelCost']),
      blockCost: AppUtils().toRoundedDouble(data['blockCost']),
      backFillMaterialCost: AppUtils().toRoundedDouble(data['backFillMaterialCost']),
      doorFrameCost: AppUtils().toRoundedDouble(data['doorFrameCost']),
      electricalConduitingCost: AppUtils().toRoundedDouble(data['electricalConduitingCost']),
      sewageCost: AppUtils().toRoundedDouble(data['sewageCost']),
      miscellaneousCost: AppUtils().toRoundedDouble(data['miscellaneousCost']),
      laborCost: AppUtils().toRoundedDouble(data['laborCost']),
      projectManagementCost: AppUtils().toRoundedDouble(data['projectManagementCost']),
      totalCost: AppUtils().toRoundedDouble(data['total_cost']),
      monthlyDistribution: (data['monthlyDistribution'] as List<dynamic>?)
          ?.map((e) => MonthlyDistribution.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class MonthlyDistribution {
  final String period;
  final double percentage;
  final double amount;

  MonthlyDistribution({
    required this.period,
    required this.percentage,
    required this.amount,
  });

  factory MonthlyDistribution.fromJson(Map<String, dynamic> json) {
    return MonthlyDistribution(
      period: json['period'] ?? '',
      percentage: (json['percentage'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }
}
