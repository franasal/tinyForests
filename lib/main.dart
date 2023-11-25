import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/datamodels/trees_data.dart';
import 'package:tinyforests/screens/guide_screen.dart';
import 'package:tinyforests/screens/map_screen.dart';
import 'package:tinyforests/screens/tree_grid_view_screen.dart';
import 'package:tinyforests/variables.dart';

import 'screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Um das Sizer-Package zu initialisieren
    // -> MaterialApp als return des builder-paramaters von Sizer
    // kann nun überall in der App via import genutzt werden
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Tini Forests App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Screen1(),
          routes: {
            startScreen: (context) => const Screen1(),
            mapScreen: (context) => const ForestMaps(),
            guideScreen: (context) => const ForestGuide(),
            treesScreen: (context) => TreeGridScreen(
                  allTrees: allTrees,
                ),
            //  TreeDetailsScreen (context) => TreeDetailsScreen(),
          },
        );
      },
    );
  }
}

/*
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Screen1(),
    );
*/