class DoorBoqModel {
  final List<List<HardwareItem>> solid;
  final List<List<HardwareItem>> net;

  DoorBoqModel({
    required this.solid,
    required this.net,
  });

  factory DoorBoqModel.fromJson(Map<String, dynamic> json) {
    return DoorBoqModel(
      solid: (json['solid'] as List)
          .map((list) => (list as List)
          .map((item) => HardwareItem.fromList(item as List))
          .toList())
          .toList(),
      net: (json['net'] as List)
          .map((list) => (list as List)
          .map((item) => HardwareItem.fromList(item as List))
          .toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'solid': solid.map((list) => list.map((item) => item.toList()).toList()).toList(),
      'net': net.map((list) => list.map((item) => item.toList()).toList()).toList(),
    };
  }
}

class HardwareItem {
  final String name;
  final String unit;
  final String quantity;

  HardwareItem({
    required this.name,
    required this.unit,
    required this.quantity,
  });

  factory HardwareItem.fromList(List<dynamic> list) {
    return HardwareItem(
      name: list[0] as String,
      unit: list[1] as String,
      quantity: list[2].toString(),
    );
  }

  List<String> toList() => [name, unit, quantity];
}
