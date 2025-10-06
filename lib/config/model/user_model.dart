import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? createdAt;
  final String? firstName;
  final String? lastName;
  final String? image;
  final String password;
  final UserType? userType;

  UserModel({
    this.id = '',
    this.email = 'guest@example.com',
    this.createdAt = '',
    this.firstName = '',
    this.lastName = '',
    this.image,
    this.password = '',
    this.userType = UserType.email,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'userType': userType?.name,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'userType': userType?.name,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? 'guest@example.com',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      image: data['image'],
      password: data['password'] ?? 'defaultPassword123',
      userType: UserType.values.firstWhere(
        (e) => e.name == data['userType'],
        orElse: () => UserType.email,
      ),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate().toIso8601String() ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? createdAt,
    String? firstName,
    String? lastName,
    String? image,
    String? password,
    UserType? userType,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      password: password ?? this.password,
      userType: userType ?? this.userType,
    );
  }
}
