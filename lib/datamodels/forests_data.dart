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
    "Darmstadt",
    "./images/forests/Default.jpeg",
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
  ),
  TinyForest(
    "Kinderhort Oderpiraten",
    "./images/forests/Default.jpeg",
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
  ),
  TinyForest(
    "Kindergarten am Wurzelberg + Kita Kinderland (auf dem selben Gelände)",
    "./images/forests/Default.jpeg",
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
  ),
  TinyForest(
    "Rozwarowo",
    "./images/forests/Default.jpeg",
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
  ),
  TinyForest(
    "Klinikum Herford",
    "./images/forests/Default.jpeg",
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
  ),
  TinyForest(
    "Hanau",
    "./images/forests/Default.jpeg",
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
  ),
  TinyForest(
    "Rüsselsheim",
    "./images/forests/Default.jpeg",
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
  ),
  TinyForest(
    "HSBI-Bielefeld",
    "./images/forests/Default.jpeg",
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
  ),
];
