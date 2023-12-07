// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/foresties.dart';
import 'package:tinyforests/screens/forest_detail_screen.dart';
import 'package:tinyforests/widgets/builderitems.dart';

// This is the first screen of the application holding a gridview that showcases the already existing projects of Tiny forest
// Main screen of the application, StatefulWidget to handle potential state changes
class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

// State class for Screen1
class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    // Scaffold for the basic structure of the screen
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Title of the screen
          Text(
            "Tiny Forests",
            style: TextStyle(fontSize: 20.sp, color: Colors.black),
          ),
          SizedBox(height: 5.h), //  just for spacing
          SizedBox(
            height: 40.h, // sets the height of the GridView
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // one column GridView
                  crossAxisSpacing: 3.h, // spacing between items horizontally
                  mainAxisSpacing: 3.h, // spacing between items vertically
                  childAspectRatio: 1.6, // aspect ratio of each item
                ),
                scrollDirection: Axis
                    .horizontal, // Scroll direction set to horizontal as in the moviies exercise
                itemCount: tForest
                    .length, // Number of items in the GridView obtained by the forests map from the script foresties.dart TODO: rename script
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push to navigate to a new screen with the details of the forest when an image is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            //  details from the selected forest that are rendered in the forest_detail_screen.dart, this is now a place colder TODO: find a nicer visualization
                            forestName: tForest[index].forestName,
                            image: tForest[index].image,
                            yearPlanted: tForest[index].yearPlanted,
                            totalTrees: tForest[index].totalTrees,
                            listPlanted: tForest[index].listPlanted,
                          ),
                        ),
                      );
                    },
                    child: GridViewContainer(
                      // custom widget for the GridView items from materials.dart
                      itemImage: tForest[index].image,
                      itemText: tForest[index].forestName,
                      alignmentOfMain:
                          MainAxisAlignment.start, // alings items to the start
                    ),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar:
          bottomNaviBar(context), //  bottom navigation bar  from materials.dart
    );
  }
}
