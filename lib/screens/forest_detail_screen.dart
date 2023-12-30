// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/plants_grid_view_screen.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:tinyforests/widgets/builderitems.dart';

// screen for displaying details of a forest
//TODO replace the text widget with nicer visualizations and add more infomration to each forest

class DetailScreen extends StatelessWidget {
  final String image;
  final String forestName;
  final int yearPlanted;
  final Map<String, PlantData> listPlanted;
  final int totalTrees;

  // constructor to receive details of the forest
  const DetailScreen(
      {super.key,
      required this.image,
      required this.yearPlanted,
      required this.totalTrees,
      required this.listPlanted,
      required this.forestName});

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, PlantData>> groupedTrees =
        groupTreesByType(listPlanted);

    // Define the order of plant types
    List<String> plantTypeOrder = [
      'Hauptbaumart',
      'Nebenbaumart',
      'Strauch',
      'Bodendecker'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(forestName), // showing the forest name in the app bar
      ),

      body: Column(
        children: [
          Image.asset(
            image,
            width: 300,
            height: 300,
          ), //  the forest image
          const SizedBox(height: 16),
          Text(
            'Year Planted: $yearPlanted', // Displaying the year the forest was planted
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Number of Trees Planted: $totalTrees', // Displaying the total number of trees planted
            style: const TextStyle(fontSize: 18),
          ),

          Expanded(
            child: ListView(
              children: plantTypeOrder.expand((plantType) {
                return [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      plantType,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (groupedTrees[plantType] != null)
                    plantsGridView(groupedTrees[plantType]!),
                ];
              }).toList(),
            ),
          ),
        ],
      ),
      //  grid of trees using a custom widget.
      bottomNavigationBar:
          bottomNaviBar(context), // custom bottom navigation bar
    );
  }
}
