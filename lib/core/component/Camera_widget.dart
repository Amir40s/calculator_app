import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/core/controller/user_controller.dart';

class EditableProfilePicture extends StatelessWidget {
  final double radius;

  const EditableProfilePicture({
    super.key,
    this.radius = 70.0,
  });

  @override
  Widget build(BuildContext context) {
    final userC = Get.find<UserController>();
    final ImagePicker picker = ImagePicker();
    final double diameter = radius * 2;
    const double iconSize = 36.0;

    Future<void> pickImage() async {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        userC.selectedImage.value = File(picked.path);
      }
    }

    return Obx(() {
      final user = userC.currentUser;
      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }

      String? imagePath;
      if (userC.selectedImage.value != null) {
        imagePath = userC.selectedImage.value!.path;
      } else if (user.image != null && user.image!.isNotEmpty) {
        imagePath = user.image!;
      } else {
        imagePath = AppAssets.logo;
      }

      final bool isNetworkImage = imagePath.startsWith('http');

      return SizedBox(
        width: diameter,
        height: diameter,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: diameter,
              height: diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey.shade700,
              ),
              child: ClipOval(
                child: isNetworkImage
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(Icons.person,
                              size: 60, color: Colors.white70),
                        ),
                      )
                    : File(imagePath).existsSync()
                        ? Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(Icons.person,
                                  size: 60, color: Colors.white70),
                            ),
                          )
                        : Icon(
                            Icons.person,
                            color: Colors.white,size: 8.h,
                          ),
              ),
            ),

            // Camera Icon
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.photo_camera_outlined,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
