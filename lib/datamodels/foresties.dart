// class to hold all the forests and their characteristics.
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/utils/utils.dart';

class TinyForest {
  final String forestName;
  final String image;
  final int yearPlanted;
  final int totalTrees;
  final int numberPlantedSpecies;
  final Map<String, PlantData> listPlanted;
  final int forestSize;

  TinyForest(this.forestName, this.image, this.yearPlanted, this.totalTrees,
      this.numberPlantedSpecies, this.listPlanted, this.forestSize);
}

// Lists with the Tiny Forests, with some basic info implements getRandomSubset for adding a subset of the listed trees
List<TinyForest> tForest = [
  TinyForest(
    "Rozwarowo",
    "./images/forests/example1.jpeg",
    2021,
    4526,
    45,
    getRandomSubset(allPlants, 10),
    1500,
  ),
  TinyForest(
    "Darmstadt",
    "./images/forests/example2.jpeg",
    2021,
    4526,
    45,
    getRandomSubset(allPlants, 15),
    1500,
  ),
  TinyForest(
    "Herford",
    "./images/forests/example3.jpeg",
    2022,
    4526,
    45,
    getRandomSubset(allPlants, 6),
    1500,
  ),
];
