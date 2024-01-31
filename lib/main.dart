// Imports
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/debu_screen.dart';
import 'package:tinyforests/screens/drag_drop_screen.dart';
import 'package:tinyforests/screens/info_app_screen.dart';
import 'package:tinyforests/screens/map_screen.dart';
import 'package:tinyforests/screens/plants_grid_view_screen.dart';
import 'package:tinyforests/screens/plants_list_view.dart';
import 'package:tinyforests/variables.dart';
import 'package:tinyforests/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Tiny Forests App',
          theme: ThemeData(
            // this sets the color scheme for the app
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
            useMaterial3: true,
          ),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home:
              const ForestMaps(), // set the initial screen of the app with the forests overview
          routes: {
            // defining named routes for navigation these are imported from in the variables.dart file
            mapScreen: (context) => const ForestMaps(),
            debugScreen: (context) => DebugScreen(),
            impressumScreen: (context) => Impressum(),
            dragAndDropScreen: (context) => ZoomableGrid(
                // allPlants: allPlants,
                // pageTitle: "Grid Draggagle Pflanzen",
                ),
            guideScreen: (context) => PlantsGridScreen(
                  allPlants: allPlants,
                  pageTitle:
                      AppLocalizations.of(context)!.plantsGridScreenTitle,
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
