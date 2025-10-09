import 'package:cloud_firestore/cloud_firestore.dart';

class AppPolicyModel {
  final String? title;
  final String? description;
  final String? createdAt;

  AppPolicyModel({
    this.title,
    this.description,
    this.createdAt,
  });

  factory AppPolicyModel.fromMap(Map<String, dynamic> map) {
  String? createdAtStr;
  if (map['creadet_at'] != null && map['creadet_at'] is Timestamp) {
    createdAtStr = (map['creadet_at'] as Timestamp).toDate().toString();
  } else if (map['created_at'] != null && map['created_at'] is Timestamp) {
    createdAtStr = (map['created_at'] as Timestamp).toDate().toString();
  }

  return AppPolicyModel(
    title: map['title'] as String?,
    description: map['description'] as String?,
    createdAt: createdAtStr,
  );
}

}
