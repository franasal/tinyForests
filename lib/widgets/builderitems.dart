import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/first_screen.dart';
import 'package:tinyforests/screens/guide_screen.dart';
import 'package:tinyforests/screens/map_screen.dart';
import 'package:tinyforests/screens/plant_grid_view_screen.dart';
import 'package:tinyforests/variables.dart';

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

// Function to create a bottom navigation bar
BottomNavigationBar bottomNaviBar(BuildContext context) {
  return BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    fixedColor: Colors.black,
    backgroundColor: Colors.white,
    items: [
      // Bottom navigation bar items with icons and labels
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.location_pin,
          color: Colors.black,
        ),
        label: 'Map',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'images/trees/Default.png',
          width: 28,
          height: 28,
          color: Colors.black,
        ),
        label: 'Trees',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.menu_book,
          color: Colors.black,
        ),
        label: 'Guide',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.more_horiz,
          color: Colors.black,
        ),
        label: 'More',
      ),
    ],
    // onTap handles the navigation to different screens based on the selected item and the routes devined in the variables.dart file
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Screen1()),
            ModalRoute.withName(startScreen),
          );
          break;
        case 1:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ForestMaps()),
            ModalRoute.withName(startScreen),
          );
          break;
        case 2:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => TreeGridScreen(
                      allPlants: allPlants,
                    )),
            ModalRoute.withName(startScreen),
          );
          break;
        case 3:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ForestGuide()),
            ModalRoute.withName(startScreen),
          );
          break;
        case 4:
          // wanted to display an AlertDialog for additional features but, TODO this is not working rightnow
          AlertDialog(
            title: const Text("More Features"),
            content: const Text("coming soon..."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    startScreen,
                    (route) => false,
                  );
                },
                child: const Text("some page"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    startScreen,
                    (route) => false,
                  );
                },
                child: const Text("other page"),
              ),
            ],
          );
          break;
      }
    },
  );
}
