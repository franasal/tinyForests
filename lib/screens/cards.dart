import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tinyforests/datamodels/forests_data.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/plant_detail_screen.dart';

class PlantCard extends StatelessWidget {
  // This is a custom widget that displays a card for each plant
  final PlantData plant; // The plant data to display
  const PlantCard(this.plant,
      {super.key}); // The constructor that takes the plant data as a parameter

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // Navigate to PlantView screen when image is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantDetailsScreen(
                      plantName: plant.scientificName, allPlants: allPlants),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                plant.pathPicture,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plant.commonName,
                  // AppLocalizations.of(context)!.commonName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  plant.scientificName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              plant.distribution,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message:
                      AppLocalizations.of(context)!.plantType(plant.plantType),
                  child: Icon(
                    plant.plantType == 'Hauptbaumart'
                        ? Icons.nature
                        : plant.plantType == 'Nebenbaumart'
                            ? Icons.park
                            : plant.plantType == 'Strauch'
                                ? Icons.local_florist
                                : Icons.grass,
                    color: Colors.green,
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context)!
                      .height, // Explanation for the icon
                  child: const Icon(
                    Icons.height,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '${plant.maxSizeMeters} m',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context)!.conservationStatus(
                      plant.conservationStatus), // Explanation for the icon
                  child: Icon(
                    Icons.eco,
                    color: plant.conservationStatus == 'Critically Endangered'
                        ? Colors.red
                        : plant.conservationStatus == 'Near Threatened'
                            ? Colors.orange
                            : plant.conservationStatus == 'Vulnerable'
                                ? Colors.yellow
                                : Colors.green,
                  ),
                ),
                Tooltip(
                  message: AppLocalizations.of(context)!.floweringSeason(
                      plant.floweringSeason), // Explanation for the icon
                  child: Icon(
                    Icons.wb_sunny,
                    color: plant.floweringSeason == 'summer'
                        ? Colors.yellow
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ForestCard extends StatelessWidget {
  const ForestCard({
    super.key,
    required this.forest,
  });

  final TinyForest forest;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          forest.image,
          width: 50,
          height: 50,
        ),
        title: Text(forest.forestName),
        // Add more details as needed
      ),
    );
  }
}

class TinyForestCard extends StatelessWidget {
  final TinyForest forest;
  const TinyForestCard(this.forest, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        height: 180,
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Image.asset(forest.image),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Text(forest.planted
                        ? AppLocalizations.of(context)!
                            .yearPlantedLabel(forest.yearPlanted)
                        : AppLocalizations.of(context)!
                            .yearPlannedLabel(forest.yearPlanted)),
                    Text(AppLocalizations.of(context)!
                        .totalTreesLabel(forest.totalTrees)),
                    Text(AppLocalizations.of(context)!
                        .yearPlantedLabel(forest.yearPlanted)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forest.forestName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Text(
                        "short description of the forest",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: (AppLocalizations.of(context)!.statusLabel),
                  child: Image.asset(
                    forest.planted
                        ? './images/icons/LocGree.png'
                        : './images/icons/LocOrang.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
