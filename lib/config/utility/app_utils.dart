
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/services/pref_services.dart';
import '../base/base_url.dart';
import '../res/app_color.dart';
import '../res/pref_keys.dart';


class AppUtils{
  static const int sessionThreshold = 6;
  static const int adsSession = 7;


  static double bytesToMB(int bytes) {
    return bytes / (1024 * 1024);
  }

  static String getCurrencySymbol(String text){
    return text.replaceAll(RegExp(r'[0-9.,\s]'), '');
  }

  static String getCountryFromLocale() {
    final locale = PlatformDispatcher.instance.locale;
    return locale.countryCode ?? 'Unknown';
  }


  static void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static Future<Uint8List?> loadLogoBytes(String path) async {
    try {
      final data = await rootBundle.load(path);
      return data.buffer.asUint8List();
    } catch (e) {
      debugPrint("Error loading logo: $e");
      return null;
    }
  }



  static String obfuscateEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email; // Invalid email, return as-is

    final local = parts[0];
    final domain = parts[1];

    if (local.length <= 6) {
      // For short local parts, show first and last only
      final start = local.substring(0, 1);
      final end = local.substring(local.length - 1);
      return '$start****$end@$domain';
    }

    final start = local.substring(0, 3);
    final end = local.substring(local.length - 3);
    final stars = '*' * (local.length - 6);
    return '$start$stars$end@$domain';
  }



  static void showToast({
    required String text,
    Color? bgColor,
    Color? txtClr,
    Toast? toastLength,
    ToastGravity? gravity,
    double? fontSize,
    int? timeInSecForIosWeb,
    bool? webShowClose,
  }) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: timeInSecForIosWeb ?? 2,
      backgroundColor: bgColor ?? AppColors.themeColor,
      textColor: txtClr ?? Colors.white,
      fontSize: fontSize ?? 16.0,
      webShowClose: webShowClose ?? false,
    );
  }


 static String cleanInput(String input) {
    return input
        .replaceAll(RegExp(r'\s+'), ' ') // replace multiple spaces/tabs/newlines with single space
        .trim();                         // remove leading/trailing spaces
  }

}