import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_construction_calculator/config/model/user_model.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/config/repository/user_repository.dart';

class UserController extends GetxController {
  final _userRepository = UserRepository.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxInt unreadNotifications = 0.obs;
  final _currentUser = Rxn<UserModel?>(null);
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);

  UserModel? get currentUser => _currentUser.value;
  set currentUser(UserModel? user) => _currentUser.value = user;

  Future<void> loadCurrentUser() async {
    try {
      print('Loading current user...');
      User? firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        print('Firebase user found: ${firebaseUser.uid}');

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          currentUser = UserModel.fromFirestore(userDoc);
          print('User loaded: ${currentUser?.email}');
          print(
              'Password exists: ${currentUser?.password?.isNotEmpty ?? false}');

          initializeControllers();
        } else {
          print('User document not found in Firestore');
          currentUser = null;
        }
      } else {
        print('No Firebase user found');
        currentUser = null;
      }
    } catch (e) {
      print('Error loading current user: $e');
      currentUser = null;
    }
  }

  void listenToUnreadNotifications() {
    if (currentUser == null) return;
    UserRepository.instance
        .getUnreadNotificationCount(currentUser!.id!)
        .listen((count) {
      unreadNotifications.value = count;
    });
  }

  Future<void> logout() async {
    try {
      final result = await _userRepository.logout();

      result.fold(
        (l) => AppUtils.showToast(
          text: l.message,
          bgColor: Colors.red,
        ),
        (r) {
          Get.offAllNamed(RoutesName.login);
          currentUser = null;
          AppUtils.showToast(
            text: 'Logged out successfully',
            bgColor: Colors.green,
          );
        },
      );
    } catch (e) {
      log('Error logging out $e');
    }
  }

  Future<void> updateUserProfile(UserModel updatedUser) async {
    // 🔹 Firestore update
    final result = await _userRepository.updateUserProfile(updatedUser);

    result.fold(
      (l) => AppUtils.showToast(
        text: l.message,
        bgColor: Colors.red,
      ),
      (r) async {
        // update controllers & local user
        currentUser = updatedUser;
        initializeControllers();

        // 🔹 If password is updated, update Firebase Auth too
        if (updatedUser.password != null &&
            updatedUser.password!.isNotEmpty &&
            updatedUser.password != currentUser?.password) {
          try {
            final user = _auth.currentUser;
            if (user != null) {
              await user.updatePassword(updatedUser.password!);
            }
          } catch (e) {
            AppUtils.showToast(
              text: "Password update failed: $e",
              bgColor: Colors.red,
            );
          }
        }

        AppUtils.showToast(
          text: "Profile updated successfully",
          bgColor: Colors.green,
        );
      },
    );
  }

  void initializeControllers() {
    final user = currentUser;
    if (user != null) {
      fullNameController.text = user.firstName ?? '';
      emailController.text = user.email ?? '';
      passwordController.text = user.password ?? '';

      print('Controllers initialized - Password: ${user.password}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser().then((_) => listenToUnreadNotifications());
  }
}
