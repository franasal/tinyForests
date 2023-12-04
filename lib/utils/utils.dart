// a funciton to select randomly some plants for testing
import 'dart:math';
import 'package:tinyforests/datamodels/trees_data.dart';

Map<String, PlantData> getRandomSubset(
    Map<String, PlantData> allPlants, int numberOfItems) {
  if (numberOfItems <= 0 || numberOfItems > allPlants.length) {
    throw ArgumentError("Invalid number of items to select");
  }

  Map<String, PlantData> selectedSpecies = {};
  List<String> allScientificNames = allPlants.keys.toList();
  List<String> copyOfScientificNames = List.from(allScientificNames);

  Map<String, PlantData> selectedSubset = {};

  for (int i = 0; i < numberOfItems; i++) {
    int randomIndex = Random().nextInt(copyOfScientificNames.length);
    String selectedScientificName = copyOfScientificNames[randomIndex];
    selectedSubset[selectedScientificName] = allPlants[selectedScientificName]!;
    copyOfScientificNames.removeAt(randomIndex);
  }
  return selectedSpecies;
}
