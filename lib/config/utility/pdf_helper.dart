import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/component/pdf/pdf_generator.dart';
import 'package:smart_construction_calculator/core/component/pdf/pdf_screen.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';


class PdfHelper {
  static Future<void> generateAndOpenPdf({
    required BuildContext context,
    required String title,
    required Map<String, String> inputData,
    List<String>? headers,
    List<List<String>>? rows,
    List<Map<String, dynamic>>? tables,
    String fileName = 'calculation_results.pdf',
  }) async {
    final loader = Get.put(LoaderController());


    try {
      loader.showLoader();

      final pdfBytes = await PdfGenerator.generateReport(
        title: title,
        inputData: inputData,
        headers: headers,
        rows: rows,
        tables: tables
      );

      loader.hideLoader();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PdfViewScreen(
            pdfBytes: pdfBytes,
            fileName: fileName,
          ),
        ),
      );
    } catch (e) {
      loader.hideLoader();
      Get.snackbar("Error", "Failed to generate PDF: $e");
      log( "Failed to generate PDF: $e");
    }
  }
}
