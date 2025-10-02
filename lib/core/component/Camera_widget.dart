import 'package:flutter/material.dart';

class EditableProfilePicture extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final VoidCallback? onEditPressed;

  const EditableProfilePicture({
    super.key,
    this.radius = 70.0,
    required this.imageUrl,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    // The main size (diameter) is twice the radius
    final double diameter = radius * 2;
    const double iconSize = 36.0;

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
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.person, size: 60, color: Colors.white70)),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditPressed,
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
  }
}
