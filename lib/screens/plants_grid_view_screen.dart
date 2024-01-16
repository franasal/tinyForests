import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as bds;
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/plant_detail_screen.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class PlantsGridScreen extends StatelessWidget {
  final Map<String, PlantData> allPlants;
  final String pageTitle;

  // Define the order of plant types
  final List<String> plantTypeOrder = [
    'Hauptbaumart',
    'Nebenbaumart',
    'Strauch',
    'Bodendecker'
  ];

  PlantsGridScreen(
      {super.key, required this.allPlants, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    // groups the allPlants by plant type with the function defined at the bottom of this file
    Map<String, Map<String, PlantData>> groupedTrees =
        groupTreesByType(allPlants);

    // Sort the keys of groupedTrees based on plantTypeOrder
    List<String> sortedPlantTypes = plantTypeOrder
        .where((plantType) => groupedTrees.containsKey(plantType))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: ListView(
        children: sortedPlantTypes.expand((plantType) {
          return [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                plantType,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            plantsGridView(groupedTrees[plantType]!),
          ];
        }).toList(),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }

  // this function does the grouping of allPlants by plant type
  // before it was just a single grid with all plants but wanted to add some subsections.
}

// function to create a GridView of tree items in each row
GridView plantsGridView(Map<String, PlantData> someTrees,
    {bool local = false}) {
  Map<String, PlantData> orderedPlants = {};

  // Sort the subset Map by the chosen field in descending order
  orderedPlants = Map.fromEntries(someTrees.entries.toList()
    ..sort((a, b) => b.value.totalPlanted.compareTo(a.value.totalPlanted)));

  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 0.80,
    ),
    itemCount: orderedPlants.length,
    itemBuilder: (BuildContext context, int index) {
      PlantData plantData = orderedPlants.values.toList()[index];
      return TreeItemCard(
        plantData: plantData,
        useLocalPlanted: local,
      );
    },
  );
}

// custom widget for displaying a thumbnail, the common and scientific name of a plant
class TreeItemCard extends StatelessWidget {
  final PlantData plantData;
  final bool useLocalPlanted; // New parameter

  const TreeItemCard({
    Key? key,
    required this.plantData,
    this.useLocalPlanted = false, // Default to false if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bds.Badge(
      position: bds.BadgePosition.custom(top: 10, end: 12),
      badgeContent: Text(
        style: TextStyle(color: Colors.white),
        useLocalPlanted
            ? plantData.localPlanted.toString()
            : plantData.totalPlanted.toString(), // Use localPlanted if true
        selectionColor: Colors.white,
      ),
      badgeStyle: bds.BadgeStyle(
        shape: bds.BadgeShape.square,
        badgeColor: Colors.green,
        padding: EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {
          // nvigate to the tree details screen when the card is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlantDetailsScreen(
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
                height: 90.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, //  the number of lines to show
                    ),
                    Text(
                      plantData.scientificName,
                      style: const TextStyle(
                        fontSize: 9.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// function to create a GridView of tree items in each row
GridView plantsGridViewDraggable(Map<String, PlantData> someTrees) {
  Map<String, PlantData> orderedPlants = {};

  // Sort the subset Map by totalPlanted in descending order
  orderedPlants = Map.fromEntries(someTrees.entries.toList()
    ..sort((a, b) => b.value.totalPlanted.compareTo(a.value.totalPlanted)));

  return GridView.builder(
    physics:
        const NeverScrollableScrollPhysics(), // Disable GridView scrolling to fix stuck behaviour
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 0.80,
    ),
    itemCount: orderedPlants.length,
    itemBuilder: (BuildContext context, int index) {
      // Convert the map values to a list and get the PlantData instance
      PlantData plantData = orderedPlants.values.toList()[index];
      return LongPressDraggable<Widget>(
        // Data is the value this Draggable stores.
        feedback: Container(
          color: Colors.deepOrange,
          height: 80,
          width: 80,
          child: Image.asset(plantData.pathPicture),
        ),

        childWhenDragging: Container(),
        data: CustomClickableWidget(plantData: plantData),

        child: TreeItemCard(
          plantData: plantData,
        ),
      );
    },
  );
}
