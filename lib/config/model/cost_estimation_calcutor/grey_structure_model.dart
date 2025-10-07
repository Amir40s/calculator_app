class GreyStructureModel {
  final GreyInput input;
  final GreyResults results;

  GreyStructureModel({
    required this.input,
    required this.results,
  });

  factory GreyStructureModel.fromJson(Map<String, dynamic> json) {
    return GreyStructureModel(
      input: GreyInput.fromJson(json['input']),
      results: GreyResults.fromJson(json['results']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input': input.toJson(),
      'results': results.toJson(),
    };
  }
}

class GreyInput {
  final double builtupArea;
  final Map<String, double> rates;

  GreyInput({
    required this.builtupArea,
    required this.rates,
  });

  factory GreyInput.fromJson(Map<String, dynamic> json) {
    return GreyInput(
      builtupArea: (json['builtup_area'] ?? 0).toDouble(),
      rates: (json['rates'] as Map<String, dynamic>?)
          ?.map((k, v) => MapEntry(k, (v as num).toDouble())) ??
          {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'builtup_area': builtupArea,
      'rates': rates,
    };
  }
}

class GreyResults {
  final double builtupArea;
  final double totalCost;
  final Map<String, double> costDetails;
  final List<MonthlyDistribution> monthlyDistribution;

  GreyResults({
    required this.builtupArea,
    required this.totalCost,
    required this.costDetails,
    required this.monthlyDistribution,
  });

  factory GreyResults.fromJson(Map<String, dynamic> json) {
    // Extract all cost-related keys dynamically except monthlyDistribution
    final filteredMap = Map<String, dynamic>.from(json)
      ..remove('monthlyDistribution')
      ..remove('builtup_area')
      ..remove('total_cost');

    final costMap = filteredMap.map((k, v) => MapEntry(k, (v as num).toDouble()));

    return GreyResults(
      builtupArea: (json['builtup_area'] ?? 0).toDouble(),
      totalCost: (json['total_cost'] ?? 0).toDouble(),
      costDetails: costMap,
      monthlyDistribution: (json['monthlyDistribution'] as List<dynamic>? ?? [])
          .map((e) => MonthlyDistribution.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'builtup_area': builtupArea,
      'total_cost': totalCost,
      'monthlyDistribution': monthlyDistribution.map((e) => e.toJson()).toList(),
      ...costDetails,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'percentage': percentage,
      'amount': amount,
    };
  }
}
