import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../../config/res/app_color.dart';
import '../../controller/company_controller.dart';

class PdfGenerator {
  static Future<Uint8List> generateReport({
    required String title,
    required Map<String, String> inputData,
    List<String>? headers,
    List<List<String>>? rows,
    List<Map<String, dynamic>>? tables,

  }) async {
    final companyController = Get.put(CompanyController());

    // 🔄 Fetch or refresh data
    await companyController.checkForChanges();
    final companyData = companyController.companyData.value;

    final pdf = pw.Document();

    Uint8List? logoBytes;
    if (companyData?['logo'] != null) {
      final base64Str = companyData!['logo'].split(',').last;
      logoBytes = base64Decode(base64Str);
    }

    final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(24),
          theme: pw.ThemeData.withFont(
            base: await PdfGoogleFonts.openSansRegular(),
            bold: await PdfGoogleFonts.openSansBold(),
          ),
        ),
        build: (context) => [
          pw.Container(
            color: PdfColor.fromInt(AppColors.blueColor.value),
            padding: const pw.EdgeInsets.all(16),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(10),
                    color: PdfColors.white,
                  ),
                  child: pw.Center(
                    child: logoBytes != null
                        ? pw.Image(
                      pw.MemoryImage(logoBytes),
                      height: 50,
                      width: 50,
                    )
                        : pw.Text('No Logo',
                        style: pw.TextStyle(
                            fontSize: 10, color: PdfColors.grey)),
                  ),
                ),
                pw.SizedBox(width: 20),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      companyData?['name'] ?? 'Smart Construction',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Email: ${companyData?['email'] ?? 'info@smartcon.com'} | '
                          'Phone: ${companyData?['phone1'] ?? '+92 300 1234567'}',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // ✅ Title
          pw.Center(
            child: pw.Column(
              children: [
                pw.Text(title.toUpperCase(),
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text("RESULTS REPORT",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text("Date: $currentDate",
                    style:
                    pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
              ],
            ),
          ),

          pw.SizedBox(height: 16),

          // ✅ Input data
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: inputData.entries
                .map((e) => pw.Text("${e.key}: ${e.value}",
                style: const pw.TextStyle(fontSize: 11)))
                .toList(),
          ),

          pw.SizedBox(height: 20),

          // ✅ Handle both single and multiple tables
          if (tables != null && tables.isNotEmpty)
            ...tables.map((table) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (table['title'] != null)
                  pw.Text(
                    table['title'],
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold),
                  ),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(
                  headers: List<String>.from(table['headers']),
                  data: List<List<String>>.from(table['rows']),
                  border: pw.TableBorder.all(
                      width: 0.5, color: PdfColors.grey600),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColor.fromInt(AppColors.blueColor.value),
                  ),
                  headerStyle: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold),
                  cellHeight: 24,
                  cellStyle: const pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(height: 20),
              ],
            )),
          if ((tables == null || tables.isEmpty) &&
              headers != null &&
              rows != null)
            pw.Table.fromTextArray(
              headers: headers,
              data: rows,
              border:
              pw.TableBorder.all(width: 0.5, color: PdfColors.grey600),
              headerDecoration: pw.BoxDecoration(
                color: PdfColor.fromInt(AppColors.blueColor.value),
              ),
              headerStyle: pw.TextStyle(
                  color: PdfColors.white, fontWeight: pw.FontWeight.bold),
              cellHeight: 24,
              columnWidths: {
                for (int i = 0; i < headers.length; i++)
                  i: const pw.FlexColumnWidth(1),
              },
              cellStyle: const pw.TextStyle(fontSize: 10),
            ),

          pw.Spacer(),

          pw.Divider(),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("${companyData?['disclaimer'] ?? ''}",
                  style:
                  const pw.TextStyle(fontSize: 9, color: PdfColors.grey)),
              pw.Text('Page 1 of 1',
                  style:
                  const pw.TextStyle(fontSize: 9, color: PdfColors.grey)),
            ],
          ),
        ],
      ),
    );

    return pdf.save();
  }


  /// Helper to print or preview the generated PDF
  static Future<void> previewPdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(onLayout: (format) async => pdfBytes);
  }
}
