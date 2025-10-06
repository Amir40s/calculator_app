import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class CalculatorModel {
  final String id;
  final String title;
  final String routeKey;
  final String? banner;
  final String? icon;

  CalculatorModel({
    required this.id,
    required this.title,
    required this.routeKey,
    this.banner,
    this.icon,
  });

  // Factory to create from Map
  factory CalculatorModel.fromMap(Map<String, dynamic> map) {
    return CalculatorModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      routeKey: map['routeKey'] ?? '',
      banner: map['banner'],
      icon: map['icon'],
    );
  }

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'routeKey': routeKey,
      'banner': banner,
      'icon': icon,
    };
  }

  // Decode base64 icon to bytes
  Uint8List? get iconBytes {
    if (icon == null || icon!.isEmpty) return null;

    try {
      // Remove "data:image/png;base64," prefix if present
      final base64Str = icon!.contains(',')
          ? icon!.split(',').last
          : icon!;
      return base64Decode(base64Str);
    } catch (e) {
      debugPrint('Error decoding base64 icon: $e');
      return null;
    }
  }

  // Return as Image widget directly
  Widget get iconWidget {
    if (iconBytes == null) {
      return const Icon(Icons.image_not_supported, size: 40);
    }
    return Image.memory(
      iconBytes!,
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    );
  }

  @override
  String toString() {
    return 'CalculatorModel(id: $id, title: $title, routeKey: $routeKey)';
  }
}
