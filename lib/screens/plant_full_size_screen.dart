import 'package:flutter/material.dart';

class FullSizeImageScreen extends StatelessWidget {
  final String imagePath;

  const FullSizeImageScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(imagePath),
        ),
      ),
      // body: PhotoViewGallery.builder(
      //   itemCount: 1,
      //   builder: (context, index) {
      //     return PhotoViewGalleryPageOptions(
      //       imageProvider: AssetImage(imagePath),
      //       minScale: PhotoViewComputedScale.contained * 0.8,
      //       maxScale: PhotoViewComputedScale.covered * 2,
      //     );
      //   },
      //   scrollPhysics: BouncingScrollPhysics(),
      //   backgroundDecoration: BoxDecoration(
      //     color: Colors.black,
      //   ),
      //   pageController: PageController(),
      // ),
    );
  }
}
