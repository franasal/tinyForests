// AnimalDetailsScreen.dart

import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/trees_data.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class TreeDetailsScreen extends StatelessWidget {
  final String plantName;
  final Map<String, PlantData> allTrees;

  TreeDetailsScreen({required this.plantName, required this.allTrees});

  @override
  Widget build(BuildContext context) {
    // Find the corresponding plant data
    PlantData plantData = allTrees[plantName]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('$plantName Details'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Scientific Name: ${plantData.scientificName}'),
          ),
          ListTile(
            title: Text('Conservation Status: ${plantData.conservationStatus}'),
          ),
          ListTile(
            title: Text('Interesting Fact: ${plantData.interestingFact}'),
          ),
          ListTile(
            title: Text('Distribution: ${plantData.distribution}'),
          ),
          // Add more details as needed
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
