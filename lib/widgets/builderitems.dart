import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/variables.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

// container for displaying the plants in a GridView that are shown in the screen1()
class GridViewContainer extends StatelessWidget {
  // variables for item image, item text, and alignment of the main axis
  final String itemImage;
  final String itemText;
  final MainAxisAlignment alignmentOfMain;

  const GridViewContainer(
      {super.key,
      required this.itemImage,
      required this.itemText,
      required this.alignmentOfMain});

  @override
  Widget build(BuildContext context) {
    // container with a decoration for the forest image
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                itemImage), // forest picture from the provided path on the forests object
            fit: BoxFit.cover),
      ),
      //  column for vertical positioning of elements with customizable alignment
      child: Column(
        mainAxisAlignment: alignmentOfMain,
        children: [
          //  displaying the item text with a black background
          Container(
            width: double.infinity,
            color: Colors.black,
            child: Text(
              itemText,
              textAlign: TextAlign.center, // centers the text horizontally
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final screen_list = [
  startScreen,
];

// Function to create a bottom navigation bar
ConvexAppBar bottomNaviBar(BuildContext context) {
  return ConvexAppBar(
    // showSelectedLabels: false,
    initialActiveIndex: 2,
    height: 50,
    top: -30,
    curveSize: 100,
    backgroundColor: Colors.white,
    style: TabStyle.fixedCircle,
    items: [
      // Bottom navigation bar items with icons and labels
      const TabItem(
        icon: Icon(
          Icons.grid_on_outlined,
          color: Color.fromARGB(200, 44, 148, 49),
        ),
        title: 'Home',
      ),
      const TabItem(
        icon: Icon(
          Icons.newspaper,
          color: Color.fromARGB(200, 44, 148, 49),
        ),
        title: 'List',
      ),
      TabItem(
        icon: Image.asset(
          'images/TFIcon.png', //images/iconStart.png
          width: 25,
          height: 25,
          // color: Colors.black,
        ),
        title: 'Trees',
      ),
      const TabItem(
        icon: Icon(
          Icons.forest,
          color: Color.fromARGB(200, 44, 148, 49),
        ),
        title: 'Guide',
      ),
      const TabItem(
        icon: Icon(
          Icons.more_horiz,
          color: Color.fromARGB(200, 44, 148, 49),
        ),
        title: 'More',
      ),
    ],
    // onTap handles the navigation to different screens based on the selected item and the routes devined in the variables.dart file
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushNamedAndRemoveUntil(
            context,
            dragAndDropScreen,
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushNamedAndRemoveUntil(
            context,
            plantsScreen,
            (route) => false,
          );
          break;
        case 2:
          Navigator.pushNamedAndRemoveUntil(
            context,
            mapScreen,
            (route) => false,
          );
          break;
        case 3:
          Navigator.pushNamedAndRemoveUntil(
            context,
            guideScreen,
            (route) => false,
          );
          break;
        case 4:
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          Offset position = renderBox.localToGlobal(Offset.zero);

          double itemWidth = renderBox.size.width;
          double itemHeight = renderBox.size.height;

          double centerX = position.dx + itemWidth / 2;
          double centerY = (position.dy + itemHeight) - 50;

          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(centerX, centerY - 100, 0, 0),
            items: [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the menu
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      impressumScreen,
                      (route) => false,
                    );
                  },
                  child: const Text("Impressum Page"),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the menu
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      debugScreen,
                      (route) => false,
                    );
                  },
                  child: const Text("Debug Page"),
                ),
              ),
            ],
          );
          break;
      }
    },
  );
}

class CustomClickableWidget extends StatelessWidget {
  final PlantData plantData;

  CustomClickableWidget({
    required this.plantData,
  });

  PlantData getPlantType() {
    return plantData;
  }

  @override
  Widget build(BuildContext context) {
    // Map plantType to the corresponding image path

    Map<String, String> plantTypeImageMap = {
      'Hauptbaumart': 'images/plantTypes/Hauptbaum.png',
      'Nebenbaumart': 'images/plantTypes/Nebenbaum.png',
      'Strauch': 'images/plantTypes/Strauch.png',
      'Bodendecker': 'images/plantTypes/Bodendecker.png',
    };

    // Check if the plantType is in the plantTypeOrder list
    if (plantTypeImageMap.keys.contains(plantData.plantType)) {
      String imagePath =
          plantTypeImageMap[plantData.plantType] ?? ''; // Get the image path

      return Image.asset(imagePath); // Display the clickable picture
    } else {
      return const Text('Invalid plant type');
    }
  }
}

class MyCircularMenuItem extends CircularMenuItem {
  final String tooltip;

  MyCircularMenuItem({
    required VoidCallback onTap,
    required IconData icon,
    Color? color,
    required this.tooltip,
  }) : super(
          onTap: onTap,
          icon: icon,
          color: color,
        );

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);
    if (tooltip.isNotEmpty) {
      result = Tooltip(
        message: tooltip,
        child: result,
      );
    }
    return result;
  }
}
