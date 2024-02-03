// a placeholder screen for future development,

import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:url_launcher/url_launcher.dart';

class Impressum extends StatefulWidget {
  const Impressum({super.key});

  @override
  State<Impressum> createState() => _ImpressumState();
}

final Uri _url = Uri.parse('https://www.miya-forest.de/impressum');

class _ImpressumState extends State<Impressum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impressum'),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              child: Image.asset(
                'images/iconStart.png',
                width: 58,
                height: 58,
              ),
              onTap: () => _launchUrl(),
            ),
            Text("Hier kommt impressum"),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                showLicensePage(
                    context: context,
                    applicationName: "Tiny Forests",
                    applicationIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'images/iconStart.png',
                        width: 48,
                        height: 48,
                      ),
                    ));
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
//
// ----------------

// import 'dart:ui' as ui;
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
// import 'package:tinyforests/widgets/builderitems.dart';

// //
// void main() {
//   runApp(Impressum());
// }

// //
// class Impressum extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Garden Planner'),
//         ),
//         body: GardenGrid(rows: 3, columns: 5),
//         bottomNavigationBar: bottomNaviBar(context), // cu
//       ),
//     );
//   }
// }

// class GardenGrid extends StatelessWidget {
//   final int rows;
//   final int columns;

//   GardenGrid({required this.rows, required this.columns});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ui.Image>(
//       future: loadImage('images/TFIcon.png'), // Replace with your image path
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Center(
//             child: Stack(
//               children: [
//                 // Background image of the garden
//                 Image.asset(
//                   'images/TFIcon.png', // Replace with your image path
//                   width: double.infinity,
//                   height: double.infinity,
//                   fit: BoxFit.none,
//                 ),
//                 // Fixed size grid with mask
//                 ClipPath(
//                   clipper: GardenClipper(snapshot.data!),
//                   child: Container(
//                     color: Colors.transparent, // Adjust as needed
//                     width: double.infinity,
//                     height: double.infinity,
//                     child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount:
//                             columns, // Specify the number of columns
//                         childAspectRatio: 1.0, // Adjust as needed
//                       ),
//                       itemCount: rows * columns,
//                       itemBuilder: (context, index) {
//                         return GridTile(
//                           child: Container(
//                             color: Colors.blue, // Adjust grid item appearance
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }

// //
// class GardenClipper extends CustomClipper<Path> {
//   final ui.Image alphaImage;
// //
//   GardenClipper(this.alphaImage);
// //
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
// //
//     // Use the await keyword to wait for the ByteData
//     Future<ByteData?> byteDataFuture = alphaImage.toByteData();
//     byteDataFuture.then((byteData) {
//       if (byteData != null) {
//         Uint8List uint8List = byteData.buffer.asUint8List();
// //
//         for (int y = 0; y < alphaImage.height; y++) {
//           for (int x = 0; x < alphaImage.width; x++) {
//             int pixelOffset = (y * alphaImage.width + x) *
//                 4; // Each pixel takes 4 bytes (RGBA)
//             int alpha = uint8List[pixelOffset + 3];
// //
//             if (alpha > 0) {
//               path.addOval(Rect.fromPoints(Offset(x.toDouble(), y.toDouble()),
//                   Offset(x.toDouble() + 1, y.toDouble() + 1)));
//             }
//           }
//         }
//       }
//     });
// //
//     return path;
//   }

// //
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// //
// Future<ui.Image> loadImage(String path) async {
//   ByteData data = await rootBundle.load(path);
//   List<int> bytes = data.buffer.asUint8List();
//   img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
//   return _toUiImage(image);
// }

// //
// Future<ui.Image> _toUiImage(img.Image image) async {
//   Completer<ui.Image> completer = Completer();
//   ui.decodeImageFromPixels(
//     Uint8List.fromList(image.getBytes()),
//     image.width,
//     image.height,
//     ui.PixelFormat.rgba8888,
//     (ui.Image img) {
//       completer.complete(img);
//     },
//   );
//   return completer.future;
// }
// //
