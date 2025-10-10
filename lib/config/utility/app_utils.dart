
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  
    static Future<String?> uploadImageToFirebase(File file, String path) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      showToast(text: 'Image upload failed: $e');
      return null;
    }
  }
  
static Future<void> uploadNotificationToFirebase({
  required String title,
  required String body,
  required String uid,
}) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection('notifications').add({
    'title': title,
    'body': body,
    'uid': uid,
    'createdAt': DateTime.now().toIso8601String(),
  });
}


 static String cleanInput(String input) {
    return input
        .replaceAll(RegExp(r'\s+'), ' ') // replace multiple spaces/tabs/newlines with single space
        .trim();                         // remove leading/trailing spaces
  }

static Color withOpacity({required Color color, required double opacity}) {
  return color.withOpacity(opacity);
}
  final random = Random();
  Color randomColor() =>
      Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.4);

  String formatUnit(String unit) {
    // Replace digits with superscript versions
    return unit
        .replaceAll('2', '²')
        .replaceAll('3', '³')
        .replaceAll('1', '¹');
  }
  double toRoundedDouble(dynamic value) {
    if (value == null) return 0;
    return (value is num) ? value.roundToDouble() : double.tryParse(value.toString())?.roundToDouble() ?? 0;
  }


  final String wallBlock = "Overview: A project-level Wall Block & Mortar Estimator that lets you model many walls (not just one), deduct windows/doors per wall, and instantly roll everything up into project totals. It works with custom block dimensions, joint thickness, and even a custom mortar mix and water–cement ratio—so you get quantities of blocks, wet mortar, dry mortar split into cement & sand, and water (liters) for the whole job. A SMART Block Massonary Calculator: This calculator makes project-level estimating faster and more defensible than typical single-wall widgets, because; Specific: Targets block masonry with openings, joints, and mix design—per wall and whole-project. Measurable: Outputs concrete quantities (blocks, ft³ mortar, split cement/sand, liters of water). Achievable: Uses transparent, industry-standard assumptions (e.g., dry-to-wet 1.54). Relevant: Aligns with how estimators actually package takeoffs (by tag/grid, then sum). Time-bound: Speeds estimating by letting you add and adjust many walls in minutes and see live totals Why it’s different (vs. typical online calculators) Most online “block wall” calculators are single-wall tools that mainly output block counts and sometimes bags of mortar (or a simple cost). Examples: Inch Calculator: single-wall block & mortar estimate; cost optional. Inch Calculator Calculator-Online: single-wall block, area, and “standard bags of mortar.” calculator-online.net Omni’s concrete block/brick calculators: single wall, with “3 bags per 100 blocks” type rules-of-thumb for mortar. Omni Calculator+1 Some advanced calculators do support openings or specialized cases, but are still centered on a single wall or product type (e.g., openings on kalk.pro; specialized retaining-wall/ICF estimators). kalk.pro+2allanblock.com+2 This SMART calculator: Handles multiple walls in one go with project-level totals—a real estimator workflow. Block with Mortar_Deduction_and… Accepts custom block dimensions (L/H/W) and custom joint thickness (not restricted to a few presets). Block with Mortar_Deduction_and… Lets users set a mix ratio and w/c, producing cement ft³, sand ft³, and water liters—not just “bags.” Block with Mortar_Deduction_and… Provides structured wall IDs (Tag, Grid) to match drawings/BOQ line items. How to use it (step-by-step) 1.Enter wall metadata: Level/Tag and Grid (handy for drawings/schedules). 2.Set wall size: Wall Height (ft) and Wall Length (ft). 3.Openings: Type the number of windows and doors; fields appear to enter width & height for each. 4.Block & joint: Provide Block Length, Height, Width (inches) and Mortar Joint Thickness (inches). 5.Mix design: Enter Mortar Mix Ratio (e.g., 1:4) and Water–Cement Ratio (e.g., 0.5). 6.Hit Add Wall. Repeat for all walls in the project. 7.Review the table: per-wall outputs with a TOTAL row that aggregates the entire project. You can Delete any wall to adjust. What it produces (per wall and totals) Deductions: window area, door area, and Net Wall Area in ft². Blocks Needed (rounded up). Mortar (ft³) as wet volume. Cement (ft³) and Sand (ft³)—calculated from your mix ratio with a dry-volume conversion. Water (L) using your w/c ratio and a standard cement bulk density (≈1440 kg/m³). How the calculations work (plain English) Openings: The tool subtracts the sum of window and door areas from each wall’s gross area to get Net Wall Area. Block with Mortar_Deduction_and… Block count: Uses the face area of a block including joints block area=(Hblock+tjoint)×(Lblock+tjoint)144\text{block area} = \frac{(H_\text{block}+t_\text{joint})\times(L_\text{block}+t_\text{joint})}{144}block area=144(Hblock​+tjoint​)×(Lblock​+tjoint​)​and computes ⌈Net Wall Area/block area⌉\lceil \text{Net Wall Area} / \text{block area} \rceil⌈Net Wall Area/block area⌉. Block with Mortar_Deduction_and… Mortar volume (wet): Approximates mortar per block as the difference between the “envelope” (block+joint in all directions) and the solid block, converts in³→ft³, then multiplies by block count. Block with Mortar_Deduction_and… Dry-volume split (cement & sand): Converts wet mortar to dry using × 1.33, then splits by your cement:sand parts. The 1.33 factor (≈33% allowance) is standard practice for mortar’s dry→wet volume change. Ian Constructions+2Param Visions+2 Water (liters): Converts cement volume to mass using ≈1440 kg/m³ bulk density and multiplies by your w/c.";
}