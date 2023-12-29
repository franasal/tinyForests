// Imports
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
// import 'package:tinyforests/screens/guide_screen.dart';
import 'package:tinyforests/screens/map_screen.dart';
import 'package:tinyforests/screens/plant_grid_view_screen.dart';
import 'package:tinyforests/screens/plants_list_view.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:tinyforests/variables.dart';
import 'package:tinyforests/screens/first_screen.dart';

// entry point of the application, like the main() function at the end of old python programs
void main() {
  runApp(const MyApp());
}

// the main application class
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // build method for creating the app's interface
  @override
  Widget build(BuildContext context) {
    updateImagePath(allPlants);
    updatePlantDistribution(
      distriDict,
      allPlants,
    ); // TODO remove this function and find a permanent storage for the images
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Tiny Forests App',
          theme: ThemeData(
            // this sets the color scheme for the app
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
            useMaterial3: true,
          ),
          home:
              const ForestMaps(), // set the initial screen of the app with the forests overview
          routes: {
            // defining named routes for navigation these are imported from in the variables.dart file
            startScreen: (context) => const Screen1(),
            mapScreen: (context) => const ForestMaps(),
            guideScreen: (context) => PlantsGridScreen(
                  allPlants:
                      allPlants, // Passing plants data from the datamodels/plants_data.dart file to the tree grid screen
                ),
            plantsScreen: (context) => PlantsListView(
                  allPlants:
                      allPlants, // Passing plants data from the datamodels/plants_data.dart file to the tree grid screen
                ),
          },
        );
      },
    );
  }
}
