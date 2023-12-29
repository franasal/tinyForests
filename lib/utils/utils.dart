// a funciton to select randomly some plants from the full allPlants Map for testing in each forest view
import 'dart:convert';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:flutter/services.dart';

Map<String, PlantData> getPlantsSubset(Map<String, int> plantQuantities) {
  Map<String, PlantData> subset = {};

  for (String plantName in plantQuantities.keys) {
    if (allPlants.containsKey(plantName)) {
      PlantData plantData = allPlants[plantName]!;
      plantData.totalPlanted = plantQuantities[plantName]!;
      subset[plantName] = plantData;
    }
  }
  return subset;
}

Map<String, Map<String, PlantData>> groupTreesByType(
    Map<String, PlantData> plantsMap) {
  Map<String, Map<String, PlantData>> groupedTrees = {};

  plantsMap.forEach((key, plantData) {
    String plantType = plantData.plantType;

    if (!groupedTrees.containsKey(plantType)) {
      groupedTrees[plantType] = {};
    }

    groupedTrees[plantType]![key] = plantData;
  });

  return groupedTrees;
}

Future<void> updateImagePath(Map<String, PlantData> plants) async {
  // Directory path for plant images
  String imagesFolder = 'images/plants/';

  // Load asset manifest to get the list of available assets
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifest = json.decode(manifestContent);

  // Extract asset names from the manifest
  List<String> assetNames = manifest.keys
      .where((String key) => key.startsWith(imagesFolder))
      .toList();

  // Iterate through the plants map and update pathPicture if a matching image is found
  plants.forEach((key, plant) {
    String filename = '$key.jpeg';
    String imagePath = '$imagesFolder$filename';

    // Check if the asset exists
    if (assetNames.contains(imagePath)) {
      plant.pathPicture = imagePath;
    }
  });
}

void updatePlantDistribution(
    Map<String, String> plantDistribution, Map<String, PlantData> allPlants) {
  plantDistribution.forEach((plantName, distribution) {
    if (allPlants.containsKey(plantName)) {
      allPlants[plantName]?.distribution = distribution;
    }
  });
  print(allPlants);
}
