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
      Directory? targetDir;

      if (Platform.isAndroid) {
        if (await Permission.manageExternalStorage.isDenied) {
          await Permission.manageExternalStorage.request();
        }

        if (await Permission.manageExternalStorage.isGranted) {
          final downloadsPath =
              await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOAD,
          );
          targetDir = Directory(downloadsPath);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('⚠️ Permission denied to access storage.')),
          );
          return;
        }
      } else if (Platform.isIOS) {
        targetDir = await getApplicationDocumentsDirectory();
      }

      if (targetDir == null) throw Exception('Storage directory not found.');
      if (!await targetDir.exists()) await targetDir.create(recursive: true);

      final filePath = '${targetDir.path}/$fileName';
      final file = File(filePath);

      await file.writeAsBytes(pdfBytes, flush: true);

      if (context.mounted) {
        Get.snackbar(
          "PDF Saved",
          "PDF saved in Downloads folder",
          onTap: (snack) {
            OpenFilex.open(filePath);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        Get.snackbar('❌ Failed to save file:', e.toString());
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
