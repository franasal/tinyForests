// a funciton to select randomly some plants from the full allPlants Map for testing in each forest view
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plant_distribution.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:flutter/material.dart';

// filter forests by year
List<Map<String, dynamic>> filterForestsByYear(
    Map<String, Map<String, dynamic>> forestsDB, int thresholdYear) {
  return forestsDB.values
      .where((forest) =>
          forest['Pflanzjahr'] != null && forest['Pflanzjahr'] > thresholdYear)
      .toList();
}

List<String> getPlantTypeOrder(lang) {
  if (lang == 'es') {
    return [
      'Arbole Principal',
      'Árbol secundario',
      'Arbusto',
      'Cobertura del suelo'
    ];
  } else if (lang == 'de') {
    return ['Hauptbaumart', 'Nebenbaumart', 'Strauch', 'Bodendecker'];
  } else {
    return ['Main tree', 'Secondary tree', 'Shrub', 'Ground cover'];
  }
}

Map<String, PlantData> getPlantsSubset(
    Map<String, int> plantQuantities, allPlants) {
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

Map<String, PlantData> getAllPlantsByLanguage(String language) {
  switch (language) {
    case 'es':
      return allPlantsEs;
    case 'de':
      return allPlantsDe;
    default:
      return allPlantsEn;
  }
}

Map<String, Map<String, PlantData>> groupTreesByType<T>(
    Map<String, T> plantsMap, allPlants) {
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

Container formatCountryList(
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
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // style: DefaultTextStyle.of(context).style,
      children: [
        Text(
          '$natives:\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
        Text(
          '${nativeCountries.join(', ')}\n',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
        Text(
          '$introduced:\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,

            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
        Text(
          '${introducedCountries.join(', ')}\n',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp, // Adjust the font size as needed
          ),
        ),
      ],
    ),
  );
}
