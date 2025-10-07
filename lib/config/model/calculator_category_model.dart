import 'dart:ui';

class CalculatorCategory {
  final String title;
  final String icon;
  final Color color;
  final List<CalculatorItem> items;

  CalculatorCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class CalculatorItem {
  final String name;
  final String icon;

  CalculatorItem({required this.name, required this.icon});
}

class CategoryItemModel {
  final String name;
  final String? routeKey;

  CategoryItemModel({
    required this.name,
    this.routeKey,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
      name: json['name'] ?? '',
      routeKey: json['routeKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'routeKey': routeKey,
    };
  }
}

