class CuringWaterModel {
  final double dailyliters;
  final double dailyGallons;
  final double totalliters;
  final double totalGallons;

  CuringWaterModel({
    required this.dailyliters,
    required this.dailyGallons,
    required this.totalliters,
    required this.totalGallons,
  });

  factory CuringWaterModel.fromJson(Map<String, dynamic> json) {
    final data = json['results'] ?? json;

    return CuringWaterModel(
      dailyliters: (data['dailyLiters'] ?? 0).toDouble(),
      dailyGallons: (data['dailyGallons'] ?? 0).toDouble(),
      totalliters: (data['totalLiters'] ?? 0).toDouble(),
      totalGallons: (data['totalGallons'] ?? 0).toDouble(),
    );
  }
}

