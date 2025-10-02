// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
// import 'package:flutter/material.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// class AppAnalyticsService {
//   static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//
//   static FirebaseAnalyticsObserver get observer =>
//       FirebaseAnalyticsObserver(analytics: _analytics);
//
//   /// Initialize once in `main.dart`
//   static Future<void> init({required String appName}) async {
//     final PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     final String platform = Platform.isIOS ? "iOS" : "Android";
//     final String version = packageInfo.version;
//     final String build = packageInfo.buildNumber;
//
//     // Set global properties
//     await _analytics.setUserProperty(name: "app_name", value: appName);
//     await _analytics.setUserProperty(name: "app_version", value: version);
//     await _analytics.setUserProperty(name: "build_number", value: build);
//     await _analytics.setUserProperty(name: "platform", value: platform);
//     await _analytics.setUserProperty(name: "language", value: Platform.localeName);
//
//     await logAppOpened();
//
//     debugPrint("✅ Firebase Analytics initialized for $appName");
//   }
//
//   static Future<void> setUserId(String userId) async {
//     await _analytics.setUserId(id: userId);
//   }
//
//   static Future<void> setUserProperty(String name, String value) async {
//     await _analytics.setUserProperty(name: name, value: value);
//   }
//
//   static Future<void> logScreenView({
//     required String screenName,
//     String? screenClass,
//   }) async {
//     await _analytics.logScreenView(
//       screenName: screenName,
//       screenClass: screenClass ?? screenName,
//     );
//   }
//
//   static Future<void> logCustomEvent({
//     required String name,
//     Map<String, dynamic>? parameters,
//   }) async {
//     await _analytics.logEvent(
//       name: name,
//       parameters: parameters?.cast<String, Object>(),
//     );
//   }
//
//   //////////////////////////////////////////////////////////////////////////////
//   // 🔥 Universal Events
//   //////////////////////////////////////////////////////////////////////////////
//
//   static Future<void> logAppOpened() async {
//     await logCustomEvent(name: 'app_opened');
//   }
//
//   static Future<void> logLogin({required String method}) async {
//     await logCustomEvent(name: 'login', parameters: {'method': method});
//   }
//
//   static Future<void> logSignUp({required String method}) async {
//     await logCustomEvent(name: 'sign_up', parameters: {'method': method});
//   }
//
//   static Future<void> logPurchase({
//     required String itemId,
//     required String itemName,
//     required double price,
//     String currency = "USD",
//   }) async {
//     await logCustomEvent(
//       name: 'purchase',
//       parameters: {
//         'item_id': itemId,
//         'item_name': itemName,
//         'price': price,
//         'currency': currency,
//       },
//     );
//   }
//
//   //////////////////////////////////////////////////////////////////////////////
//   // 📝 Poem Generator Events
//   //////////////////////////////////////////////////////////////////////////////
//
//   static Future<void> logPoemGenerated({
//     required String type,
//     required String mood,
//     required bool isPremium,
//   }) async {
//     await logCustomEvent(
//       name: 'poem_generated',
//       parameters: {
//         'type': type,
//         'mood': mood,
//         'is_premium': isPremium,
//       },
//     );
//   }
//
//   static Future<void> logPoemShared({
//     required String type,
//     required String platform,
//   }) async {
//     await logCustomEvent(
//       name: 'poem_shared',
//       parameters: {
//         'type': type,
//         'platform': platform,
//       },
//     );
//   }
//
//   static Future<void> logSubscriptionClick() async {
//     await logCustomEvent(name: 'subscription_clicked');
//   }
//
//   //////////////////////////////////////////////////////////////////////////////
//   // 🧘 Fitness / Wellness Events
//   //////////////////////////////////////////////////////////////////////////////
//
//   static Future<void> logWorkoutStarted({
//     required String workoutType,
//     required int durationMinutes,
//   }) async {
//     await logCustomEvent(
//       name: 'workout_started',
//       parameters: {
//         'type': workoutType,
//         'duration': durationMinutes,
//       },
//     );
//   }
//
//
//
//   //////////////////////////////////////////////////////////////////////////////
//   // 📓 Notes / Task Manager Events
//   //////////////////////////////////////////////////////////////////////////////
//
//   static Future<void> logNoteCreated({required String category}) async {
//     await logCustomEvent(
//       name: 'note_created',
//       parameters: {'category': category},
//     );
//   }
//
//   static Future<void> logTaskCompleted({required String taskId}) async {
//     await logCustomEvent(
//       name: 'task_completed',
//       parameters: {'task_id': taskId},
//     );
//   }
// }
