import 'dart:io';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:file_saver/file_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/custom_backButton.dart';

class PdfViewScreen extends StatefulWidget {
  final Uint8List pdfBytes;
  final String fileName;

  const PdfViewScreen({
    Key? key,
    required this.pdfBytes,
    required this.fileName,
  }) : super(key: key);

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  late PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openData(widget.pdfBytes),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }
  Future<void> _downloadFile(
      BuildContext context, String fileName, Uint8List pdfBytes) async {
    try {
      // 1️⃣ Get a safe, valid app directory
      final dir = await getExternalStorageDirectory();
      if (dir == null) throw Exception("No storage directory found");

      // 2️⃣ Create a subfolder if you like (e.g., “PDFs”)
      final saveDir = Directory("${dir.path}/PDFs");
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      // 3️⃣ Define the complete file path
      final filePath = "${saveDir.path}/$fileName";
      final file = File(filePath);

      // 4️⃣ Write the bytes to file
      await file.writeAsBytes(pdfBytes, flush: true);

      // 5️⃣ Show snackbar with OPEN button
      if (context.mounted) {
        Get.snackbar(
          "✅ PDF Saved",
          "File saved to: ${saveDir.path}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          duration: const Duration(seconds: 6),
          mainButton: TextButton(
            onPressed: () async {
              Get.closeAllSnackbars();
              await OpenFilex.open(file.path);
            },
            child: const Text(
              "OPEN",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Get.snackbar(
          "❌ Failed to save file",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTextWidget(
          text: widget.fileName,
          color: AppColors.whiteColor,
          styleType: StyleType.subHeading,
        ),
        leading: BackButton(color: AppColors.whiteColor,),
        backgroundColor: AppColors.blueColor,
        actions: [
          GestureDetector(
              onTap: () {
                _downloadFile(context, widget.fileName, widget.pdfBytes);

              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: SvgPicture.asset(AppIcons.download),
              )),
        ],
      ),
      body: PdfViewPinch(
        controller: _pdfController,
      ),
    );
  }
}
