import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatelessWidget {
  final String image;

  const ImageViewerPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PhotoView(
        imageProvider: AssetImage(image, package: 'general'),
        backgroundDecoration: const BoxDecoration(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context);
      }
    );
  }
}
