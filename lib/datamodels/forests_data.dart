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
  final Map<String, double> coordinates;

  TinyForest(
    this.forestName,
    this.image,
    this.yearPlanted,
    this.totalTrees,
    this.numberPlantedSpecies,
    this.listPlanted,
    this.forestSize,
    this.coordinates,
  );
}

class PlannedTinyForest {
  final String forestName;
  final String image;
  final int yearPlanned;
  final int estimatedTotalTrees;
  final int numberPlantedSpecies;
  final Map<String, PlantData> listPlanted;
  final int forestSize;
  final Map<String, double> coordinates;

  PlannedTinyForest(
    this.forestName,
    this.image,
    this.yearPlanned,
    this.estimatedTotalTrees,
    this.numberPlantedSpecies,
    this.listPlanted,
    this.forestSize,
    this.coordinates,
  );
}

// Lists with the Tiny Forests, with some basic info implements getRandomSubset for adding a subset of the listed trees
List<TinyForest> tForest = [
  TinyForest(
    "Darmstadt",
    "./images/forests/default.jpeg",
    2021,
    630,
    31,
    getPlantsSubset([
      'Acer monspessulanum',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Carpinus betulus',
      'Cornus sanguinea',
      'Corylus avellana',
      'Crataegus monogyna',
      'Cytisus scoparius',
      'Fagus sylvatica',
      'Frangula alnus',
      'Fraxinus excelsior',
      'Ilex aquifolium',
      'Malus sylvestris',
      'Prunus avium',
      'Prunus padus',
      'Prunus spinosa',
      'Pyrus pyraster agg.',
      'Quercus patrea',
      'Quercus robur',
      'Rhammus cathartica',
      'Ribes rubrum s. str.',
      'Rosa canina agg.',
      'Rubus idaeus',
      'Salix purpurea',
      'Sambucus nigra',
      'Sorbus aucuparia',
      'Sorbus torminalis',
      'Taxus baccata',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Ulmus laevis'
    ]),
    250,
    {'lat': 51.1197008, 'lon': 8.3955619},
  ),
  TinyForest(
    "Kinderhort Oderpiraten",
    "./images/forests/default.jpeg",
    2021,
    360,
    24,
    getPlantsSubset([
      'Acer campestre',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Alnus glutinosa',
      'Betula pubescens',
      'Carpinus betulus',
      'Corylus avellana',
      'Fagus sylvatica',
      'Fraxinus excelsior',
      'Pinus sylvestris',
      'Populus tremula',
      'Prunus cerasifera',
      'Pyrus pyraster',
      'Ribes rubrum',
      'Rubus idaeus',
      'Salix alba',
      'Salix aurita',
      'Salix purpurea',
      'Sorbus torminalis',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Tilia tomentosa',
      'Ulmus laevis',
      'Ulmus minor'
    ]),
    150,
    {'lat': 52.3251111, 'lon': 14.5436667},
  ),
  TinyForest(
    "Kindergarten am Wurzelberg + Kita Kinderland (auf dem selben Gelände)",
    "./images/forests/default.jpeg",
    2021,
    600,
    24,
    getPlantsSubset([
      'Acer campestre',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Alnus glutinosa',
      'Betula pubescens',
      'Carpinus betulus',
      'Corylus avellana',
      'Fagus sylvatica',
      'Fraxinus excelsior',
      'Pinus sylvestris',
      'Populus tremula',
      'Prunus cerasifera',
      'Pyrus pyraster',
      'Ribes rubrum',
      'Rubus idaeus',
      'Salix alba',
      'Salix aurita',
      'Salix purpurea',
      'Sorbus torminalis',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Tilia tomentosa',
      'Ulmus laevis',
      'Ulmus minor'
    ]),
    150,
    {'lat': 52.3049722, 'lon': 13.2405556},
  ),
  TinyForest(
    "Rozwarowo",
    "./images/forests/default.jpeg",
    2021,
    4500,
    37,
    getPlantsSubset([
      'Acer campestre',
      'Acer pseudoplatanus',
      'Amelanchier ovalis',
      'Berberis vulgaris',
      'Betula pendula',
      'Carpinus betulus',
      'Cornus sanguinea',
      'Corylus avellana',
      'Crataegus monogyna',
      'Cytisus scoparius',
      'Euonymus europaeus',
      'Fagus sylvatica',
      'Frangula alnus',
      'Fraxinus excelsior',
      'Larix decidua var. polonica',
      'Malus sylvestris',
      'Pinus sylvestris',
      'Prunus avium',
      'Prunus padus',
      'Prunus spinosa',
      'Pyrus pyraster agg.',
      'Quercus petraea',
      'Quercus robur',
      'Rhammus cathartica',
      'Rhamnus frangula',
      'Ribes rubrum s. str.',
      'Rosa canina agg.',
      'Rubus idaeus',
      'Salix purpurea',
      'Sambucus nigra',
      'Sorbus aucuparia',
      'Sorbus torminalis',
      'Tilia cordata',
      'Ulmus glabra',
      'Ulmus laevis',
      'Ulmus minor',
      'Viburnum opulus'
    ]),
    1500,
    {'lat': 53.8951667, 'lon': 14.7248611},
  ),
  TinyForest(
    "Klinikum Herford",
    "./images/forests/default.jpeg",
    2022,
    750,
    25,
    getPlantsSubset([
      'Acer campestre',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Berberis vulgaris',
      'Carpinus betulus',
      'Cornus sanguinea',
      'Corylus avellana',
      'Crataegus monogyna',
      'Cytisus scoparius',
      'Fagus sylvatica',
      'Frangula alnus',
      'Fraxinus excelsior',
      'Ilex aquifolium',
      'Prunus padus',
      'Prunus spinosa',
      'Rhammus cathartica',
      'Ribes rubrum s. str.',
      'Rosa arvensis',
      'Rubus idaeus',
      'Sambucus nigra',
      'Sorbus torminalis',
      'Taxus baccata',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Ulmus laevis'
    ]),
    250,
    {'lat': 52.1278877, 'lon': 8.7015054},
  ),
  TinyForest(
    "Hanau",
    "./images/forests/default.jpeg",
    2023,
    450,
    25,
    getPlantsSubset([
      'Anemone nemorosa',
      'Athyrium filix-femina',
      'Carpinus betulus',
      'Cornus sanguinea',
      'Crataegus monogyna',
      'Euonymus europaeus',
      'Fagus sylvatica',
      'Frangula alnus',
      'Fraxinus excelsior',
      'Ilex aquifolium',
      'Lamium galeobdolon',
      'Potentilla sterilis',
      'Quercus petraea',
      'Quercus robur',
      'Ribes rubrum',
      'Rubus caesius',
      'Rubus idaeus',
      'Sambucus nigra',
      'Sorbus aucuparia',
      'Stellaria holostea',
      'Tilia cordata',
      'Ulmus laevis',
      'Vaccinium corymbosum',
      'Viburnum opulus',
      'Viola reichenbachiana'
    ]),
    150,
    {'lat': 50.1263611, 'lon': 8.9208333},
  ),
  TinyForest(
    "Rüsselsheim",
    "./images/forests/default.jpeg",
    2023,
    700,
    31,
    getPlantsSubset([
      'Acer monspessulanum',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Carpinus betulus',
      'Cornus sanguinea',
      'Corylus avellana',
      'Crataegus monogyna',
      'Cytisus scoparius',
      'Fagus sylvatica',
      'Frangula alnus',
      'Fraxinus excelsior',
      'Ilex aquifolium',
      'Malus sylvestris',
      'Prunus avium',
      'Prunus padus',
      'Prunus spinosa',
      'Pyrus pyraster agg.',
      'Quercus patrea',
      'Quercus robur',
      'Rhammus cathartica',
      'Ribes rubrum s. str.',
      'Rosa canina agg.',
      'Rubus idaeus',
      'Salix purpurea',
      'Sambucus nigra',
      'Sorbus aucuparia',
      'Sorbus torminalis',
      'Taxus baccata',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Ulmus laevis'
    ]),
    250,
    {'lat': 49.9806389, 'lon': 8.4376111},
  ),
  TinyForest(
    "HSBI-Bielefeld",
    "./images/forests/default.jpeg",
    2024,
    600,
    16,
    getPlantsSubset([
      'Carpinus betulus',
      'Corylus avellana',
      'Crataegus laevigata agg.',
      'Fagus sylvatica',
      'Ilex aquifolium',
      'Lonicera periclymenum',
      'Populus tremula',
      'Prunus avium',
      'Prunus spinosa',
      'Quercus petraea',
      'Quercus robur',
      'Rubus idaeus',
      'Rubus sect. Rubus',
      'Salix caprea',
      'Sambucus nigra',
      'Sorbus aucuparia'
    ]),
    200,
    {'lat': 52.0436944, 'lon': 8.49275},
  ),
];

// Lists with the Tiny Forests, with some basic info implements getRandomSubset for adding a subset of the listed trees
List<TinyForest> plannedForest = [
  TinyForest(
    "Grießheim 3.0",
    "./images/forests/default.jpeg",
    2024,
    630,
    31,
    getPlantsSubset([
      'Acer monspessulanum',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Carpinus betulus',
      'Cornus sanguinea',
      'Corylus avellana',
      'Crataegus monogyna',
      'Cytisus scoparius',
      'Fagus sylvatica',
      'Frangula alnus',
      'Fraxinus excelsior',
      'Ilex aquifolium',
      'Malus sylvestris',
      'Prunus avium',
      'Prunus padus',
      'Prunus spinosa',
      'Pyrus pyraster agg.',
      'Quercus patrea',
      'Quercus robur',
      'Rhammus cathartica',
      'Ribes rubrum s. str.',
      'Rosa canina agg.',
      'Rubus idaeus',
      'Salix purpurea',
      'Sambucus nigra',
      'Sorbus aucuparia',
      'Sorbus torminalis',
      'Taxus baccata',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Ulmus laevis'
    ]),
    250,
    {'lat': 49.8513056, 'lon': 8.5536667},
  ),
  TinyForest(
    "Mühlheim",
    "./images/forests/default.jpeg",
    2024,
    360,
    24,
    getPlantsSubset([
      'Acer campestre',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Alnus glutinosa',
      'Betula pubescens',
      'Carpinus betulus',
      'Corylus avellana',
      'Fagus sylvatica',
      'Fraxinus excelsior',
      'Pinus sylvestris',
      'Populus tremula',
      'Prunus cerasifera',
      'Pyrus pyraster',
      'Ribes rubrum',
      'Rubus idaeus',
      'Salix alba',
      'Salix aurita',
      'Salix purpurea',
      'Sorbus torminalis',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Tilia tomentosa',
      'Ulmus laevis',
      'Ulmus minor'
    ]),
    150,
    {'lat': 50.1243056, 'lon': 8.8404167},
  ),
  TinyForest(
    "HSBI (Bielefeld)",
    "./images/forests/default.jpeg",
    2024,
    600,
    24,
    getPlantsSubset([
      'Acer campestre',
      'Acer platanoides',
      'Acer pseudoplatanus',
      'Alnus glutinosa',
      'Betula pubescens',
      'Carpinus betulus',
      'Corylus avellana',
      'Fagus sylvatica',
      'Fraxinus excelsior',
      'Pinus sylvestris',
      'Populus tremula',
      'Prunus cerasifera',
      'Pyrus pyraster',
      'Ribes rubrum',
      'Rubus idaeus',
      'Salix alba',
      'Salix aurita',
      'Salix purpurea',
      'Sorbus torminalis',
      'Tilia cordata',
      'Tilia platyphyllos',
      'Tilia tomentosa',
      'Ulmus laevis',
      'Ulmus minor'
    ]),
    150,
    {'lat': 52.0436944, 'lon': 8.49275},
  ),
];
