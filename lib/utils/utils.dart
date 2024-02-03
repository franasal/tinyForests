// a funciton to select randomly some plants from the full allPlants Map for testing in each forest view
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plant_distribution.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:flutter/material.dart';

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

RichText formatCountryList(
    BuildContext context, String plantName, String introduced, String natives) {
  List<String> nativeCountries = [];
  List<String> introducedCountries = [];

  List<Map<String, int>>? countries = allPlantsDistribution[plantName];

  for (Map<String, int> entry in countries!) {
    String country = entry.keys.first;
    int status = entry.values.first;

    if (status == 0) {
      nativeCountries.add(country);
    } else if (status == 1) {
      introducedCountries.add(country);
    }
  }
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: <TextSpan>[
        TextSpan(
          text: '$natives:\n\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
        TextSpan(
          text: '${nativeCountries.join(', ')}\n',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
        TextSpan(
          text: '\n\n$introduced:\n\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,

            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
        TextSpan(
          text: '${introducedCountries.join(',')}\n',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
      ],
    ),
  );
}
