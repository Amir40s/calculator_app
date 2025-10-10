class FinalCostModel {
  final double total;
  final double perSqFt;
  final List<Group> groups;
  final List<double> monthly;

  FinalCostModel({
    required this.total,
    required this.perSqFt,
    required this.groups,
    required this.monthly,
  });

  factory FinalCostModel.fromJson(Map<String, dynamic> json) {
    return FinalCostModel(
      total: (json['total'] is int) ? (json['total'] as int).toDouble() : json['total'].toDouble(),
      perSqFt: (json['perSqFt'] is int) ? (json['perSqFt'] as int).toDouble() : json['perSqFt'].toDouble(),
      groups: (json['groups'] as List)
          .map((group) => Group.fromJson(group))
          .toList(),
      monthly: List<double>.from(json['monthly'].map((x) => x is int ? (x as int).toDouble() : x.toDouble())),
    );
  }
}

class Group {
  final String name;
  final double subtotal;
  final List<RowModel> rows;

  Group({
    required this.name,
    required this.subtotal,
    required this.rows,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['name'],
      subtotal: (json['subtotal'] is int) ? (json['subtotal'] as int).toDouble() : json['subtotal'].toDouble(),
      rows: (json['rows'] as List)
          .map((row) => RowModel.fromJson(row))
          .toList(),
    );
  }
}

class RowModel {
  final String name;
  final double amount;
  final String note;

  RowModel({
    required this.name,
    required this.amount,
    required this.note,
  });

  factory RowModel.fromJson(Map<String, dynamic> json) {
    return RowModel(
      name: json['name'],
      amount: (json['amount'] is int) ? (json['amount'] as int).toDouble() : json['amount'].toDouble(),
      note: json['note'] ?? '',
    );
  }
}
