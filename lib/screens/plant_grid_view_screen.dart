import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/plant_detail_screen.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:tinyforests/widgets/builderitems.dart';

// screen displaying a grid of plants grouped by plant type  after eachother

// each subgrid is displayed with the function plantsGridView
class TreeGridScreen extends StatelessWidget {
  final Map<String, PlantData> allPlants;

  TreeGridScreen({Key? key, required this.allPlants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // groups the allPlants by plant type with the function defined at the botton of this file
    Map<String, Map<String, PlantData>> groupedTrees =
        groupTreesByType(allPlants);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Plants List'),
      ),
      body: ListView(
        children: groupedTrees.keys.expand((plantType) {
          return [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                plantType,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            plantsGridView(groupedTrees[plantType]!),
          ];
        }).toList(),
      ),
      bottomNavigationBar:
          bottomNaviBar(context), // custom bottom navigation bar
    );
  }

  // this function does the grouping of allPlants by plant type
  // before it was just a single grid with all plants but wanted to add some subsections.
}

// function to create a GridView of tree items in each row
GridView plantsGridView(Map<String, PlantData> allTrees) {
  return GridView.builder(
    physics:
        NeverScrollableScrollPhysics(), // Disable GridView scrolling to fix stuck behaviour
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

// custom widget for displaying a thumbnail, the common and scientific name of a plant
class TreeItemCard extends StatelessWidget {
  final PlantData plantData;

  const TreeItemCard({Key? key, required this.plantData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // nvigate to the tree details screen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TreeDetailsScreen(
                plantName: plantData.scientificName, allPlants: allPlants),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // picture from images/trees todo; change folder name to /plants
                  image: AssetImage(plantData.pathPicture),
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
                    maxLines: 1, //  the number of lines to show
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
