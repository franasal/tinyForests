// tree_gird_view.dart
import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/trees_data.dart';
import 'package:tinyforests/screens/tree_detail_screen.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class TreeGridScreen extends StatelessWidget {
  final Map<String, PlantData> allTrees;

  TreeGridScreen({Key? key, required this.allTrees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tree Details'),
      ),
      body: plantsGridView(allTrees),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}

GridView plantsGridView(Map<String, PlantData> allTrees) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 0.80,
    ),
    itemCount: allTrees.length,
    itemBuilder: (BuildContext context, int index) {
      // Convert the map values to a list and get the PlantData instance
      PlantData plantData = allTrees.values.toList()[index];
      return TreeItemCard(plantData: plantData);
    },
  );
}

// TODO add info dialogue for the futurewith total of planted trees and some additional information such as link.

class TreeItemCard extends StatelessWidget {
  final PlantData plantData;

  const TreeItemCard({Key? key, required this.plantData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the tree details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TreeDetailsScreen(
                plantName: plantData.scientificName, allTrees: allTrees),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for image (you can replace this with an actual image widget)
            Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // Use a placeholder image if picturePath is null
                  image: AssetImage(
                      plantData.pathPicture ?? './images/trees/Default.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plantData.commonName,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1, // Adjust the number of lines to show
                  ),
                  Text(
                    plantData.scientificName,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
