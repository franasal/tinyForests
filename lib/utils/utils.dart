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

  return groupedTrees;
}
