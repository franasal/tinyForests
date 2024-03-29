import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tinyforests/datamodels/forests_Treesdata.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/event_detail_screen.dart';
import 'package:tinyforests/screens/plant_detail_screen.dart';
import 'package:tinyforests/utils/utils.dart';

class PlantCard extends StatelessWidget {
  // This is a custom widget that displays a card for each plant
  final PlantData plant; // The plant data to display
  const PlantCard(this.plant,
      {super.key}); // The constructor that takes the plant data as a parameter

  @override
  Widget build(BuildContext context) {
    Map<String, PlantData> allPlants =
        getAllPlantsByLanguage(AppLocalizations.of(context)!.localeName);
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
                  triggerMode: TooltipTriggerMode.tap,
                  message: plant.plantType,
                  child: Icon(
                    plant.plantType == 'Hauptbaumart'
                        ? Icons.park
                        : plant.plantType == 'Nebenbaumart'
                            ? Icons.forest
                            : plant.plantType == 'Strauch'
                                ? Icons.local_florist
                                : Icons.grass,
                    color: Colors.green,
                  ),
                ),
                Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
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
                  triggerMode: TooltipTriggerMode.tap,
                  message: plant.conservationStatus, // Explanation for the icon
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
                  triggerMode: TooltipTriggerMode.tap,
                  message: plant.floweringSeason, // Explanation for the icon
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

class TinyForestCard extends StatelessWidget {
  final TinyForest forest;
  // ignore: use_key_in_widget_constructors
  const TinyForestCard(this.forest,
      {Key? key, required this.onPlantedIconClick});

  final VoidCallback onPlantedIconClick;

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
                GestureDetector(
                  onTap: () {
                    onPlantedIconClick();
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(forest.image,
                          height: 100, width: 100, fit: BoxFit.cover)),
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
                        .forestSizeLabel(forest.forestSize)),
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
                  triggerMode: TooltipTriggerMode.tap,
                  message: (forest.planted
                      ? AppLocalizations.of(context)!.plantedLabel
                      : AppLocalizations.of(context)!.plannedLabel),
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

class Announcements extends StatelessWidget {
  final Map<String, dynamic> forestData;

  Announcements(this.forestData);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Add navigation or any other action on card tap
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                forestData['Projektname'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text('Standort: ${forestData['Standort'] ?? 'Unknown'}'),
              SizedBox(height: 5),
              Text('Bundesland: ${forestData['Bundesland'] ?? 'Unknown'}'),
              SizedBox(height: 5),
              Text(AppLocalizations.of(context)!
                  .yearPlannedLabel(forestData['Pflanzjahr'] ?? 'Unknown')),
              SizedBox(height: 5),
              Text('Fläche in qm: ${forestData['Fläche in qm'] ?? 'Unknown'}'),
              SizedBox(height: 5),
              if (forestData['Koordinaten'] != null)
                TextButton.icon(
                  onPressed: () {
                    Uri.parse(forestData['MapsURL']);
                    // Add action to open map with coordinates
                  },
                  icon: Icon(Icons.location_on),
                  label: Text('View on Map'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
