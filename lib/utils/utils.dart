// a funciton to select randomly some plants from the full allPlants Map for testing in each forest view
import 'dart:convert';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:flutter/services.dart';

Map<String, PlantData> getPlantsSubset(Map<String, int> plantQuantities) {
  Map<String, PlantData> subset = {};

  for (String plantName in plantQuantities.keys) {
    if (allPlants.containsKey(plantName)) {
      PlantData plantData = allPlants[plantName]!;
      plantData.localPlanted = plantQuantities[plantName]!;
      subset[plantName] = plantData;
      print(plantData);
    }
  }
  return subset;
}

Map<String, Map<String, PlantData>> groupTreesByType<T>(
    Map<String, T> plantsMap) {
  Map<String, Map<String, PlantData>> groupedTrees = {};

  plantsMap.forEach((key, plantData) {
    String plantType = allPlants[key]!.plantType;

    if (plantData is PlantData) {
      if (!groupedTrees.containsKey(plantType)) {
        groupedTrees[plantType] = {};
      }
      groupedTrees[plantType]![key] = plantData;
    } else if (plantData is int) {
      PlantData? existingPlant = allPlants[key];

      existingPlant?.localPlanted = plantsMap[key] as int;
      if (!groupedTrees.containsKey(plantType)) {
        groupedTrees[plantType] = {};
      }
      groupedTrees[plantType]![key] = existingPlant!;
    }
  });

  print(groupedTrees);

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
    if (assetNames.contains(imagePath) &&
        !plant.pathPicture.contains(plant.scientificName)) {
      plant.pathPicture = imagePath;
    } else if (!plant.pathPicture.contains(plant.scientificName)) {
      print('$key$plant');
    }
  });
}
