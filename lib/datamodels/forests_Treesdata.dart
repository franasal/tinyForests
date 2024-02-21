// class to hold all the forests and their characteristics.

class TinyForest {
  final String forestName;
  final String image;
  final bool planted;
  final int yearPlanted;
  final int totalTrees;
  final int numberPlantedSpecies;
  final Map<String, int> listPlanted;
  final int forestSize;
  final Map<String, double> coordinates;

  TinyForest(
    this.forestName,
    this.image,
    this.planted,
    this.yearPlanted,
    this.totalTrees,
    this.numberPlantedSpecies,
    this.listPlanted,
    this.forestSize,
    this.coordinates,
  );
}

// Lists with the Tiny Forests, with some basic info implements getRandomSubset for adding a subset of the listed trees

// Lists with the Tiny Forests, with some basic info implements getRandomSubset for adding a subset of the listed trees
List<TinyForest> tForest = [
  TinyForest(
    "Darmstadt",
    "./images/forests/Darmstadt.jpg",
    true,
    2021,
    630,
    31,
    {
      'Acer monspessulanum': 20,
      'Acer platanoides': 20,
      'Acer pseudoplatanus': 42,
      'Carpinus betulus': 42,
      'Cornus sanguinea': 20,
      'Corylus avellana': 20,
      'Crataegus monogyna': 20,
      'Cytisus scoparius': 20,
      'Fagus sylvatica': 42,
      'Frangula alnus': 20,
      'Fraxinus excelsior': 42,
      'Ilex aquifolium': 20,
      'Malus sylvestris': 20,
      'Prunus avium': 20,
      'Prunus padus': 20,
      'Prunus spinosa': 20,
      'Pyrus communis': 20,
      'Quercus petraea': 42,
      'Quercus robur': 42,
      'Rhamnus cathartica': 20,
      'Ribes rubrum': 20,
      'Rosa canina agg': 20,
      'Rubus idaeus': 20,
      'Salix purpurea': 20,
      'Sambucus nigra': 20,
      'Sorbus aucuparia': 20,
      'Sorbus torminalis': 20,
      'Taxus baccata': 20,
      'Tilia cordata': 20,
      'Tilia platyphyllos': 20,
      'Ulmus laevis': 20
    },
    250,
    {'lat': 51.1197008, 'lon': 8.3955619},
  ),
  TinyForest(
    "Kinderhort Oderpiraten",
    "./images/forests/default.jpeg",
    true,
    2021,
    360,
    24,
    {
      'Acer campestre': 15,
      'Acer platanoides': 15,
      'Acer pseudoplatanus': 15,
      'Alnus glutinosa': 20,
      'Betula pubescens': 15,
      'Carpinus betulus': 15,
      'Corylus avellana': 15,
      'Fagus sylvatica': 20,
      'Fraxinus excelsior': 15,
      'Pinus sylvestris': 15,
      'Populus tremula': 20,
      'Prunus cerasifera': 15,
      'Pyrus communis': 15,
      'Ribes rubrum': 20,
      'Rubus idaeus': 20,
      'Salix alba': 5,
      'Salix aurita': 5,
      'Salix purpurea': 5,
      'Sorbus torminalis': 20,
      'Tilia cordata': 15,
      'Tilia platyphyllos': 15,
      'Tilia tomentosa': 15,
      'Ulmus laevis': 15,
      'Ulmus minor': 15
    },
    150,
    {'lat': 52.3251111, 'lon': 14.5436667},
  ),
  TinyForest(
    "Kindergarten am Wurzelberg + Kita Kinderland (auf dem selben Gelände)",
    "./images/forests/default.jpeg",
    true,
    2021,
    600,
    24,
    {
      'Acer campestre': 25,
      'Acer platanoides': 25,
      'Acer pseudoplatanus': 25,
      'Alnus glutinosa': 30,
      'Betula pubescens': 25,
      'Carpinus betulus': 25,
      'Corylus avellana': 25,
      'Fagus sylvatica': 30,
      'Fraxinus excelsior': 25,
      'Pinus sylvestris': 25,
      'Populus tremula': 30,
      'Prunus cerasifera': 25,
      'Pyrus communis': 25,
      'Ribes rubrum': 30,
      'Rubus idaeus': 30,
      'Salix alba': 15,
      'Salix aurita': 15,
      'Salix purpurea': 15,
      'Sorbus torminalis': 30,
      'Tilia cordata': 25,
      'Tilia platyphyllos': 25,
      'Tilia tomentosa': 25,
      'Ulmus laevis': 25,
      'Ulmus minor': 25
    },
    150,
    {'lat': 52.3049722, 'lon': 13.2405556},
  ),
  TinyForest(
    "Rozwarowo",
    "./images/forests/rozwarowo.png",
    true,
    2021,
    4500,
    37,
    {
      'Acer campestre': 71,
      'Acer pseudoplatanus': 143,
      'Amelanchier ovalis': 63,
      'Berberis vulgaris': 63,
      'Betula pendula': 71,
      'Carpinus betulus': 143,
      'Cornus sanguinea': 63,
      'Corylus avellana': 63,
      'Crataegus monogyna': 63,
      'Cytisus scoparius': 63,
      'Euonymus europaeus': 63,
      'Fagus sylvatica': 143,
      'Frangula alnus': 63,
      'Fraxinus excelsior': 143,
      'Larix decidua': 71,
      'Malus sylvestris': 71,
      'Pinus sylvestris': 71,
      'Prunus avium': 71,
      'Prunus padus': 71,
      'Prunus spinosa': 63,
      'Pyrus communis': 71,
      'Quercus petraea': 143,
      'Quercus robur': 143,
      'Rhamnus cathartica': 63,
      'Rhamnus frangula': 63,
      'Ribes rubrum': 63,
      'Rosa canina agg': 63,
      'Rubus idaeus': 63,
      'Salix purpurea': 63,
      'Sambucus nigra': 71,
      'Sorbus aucuparia': 71,
      'Sorbus torminalis': 71,
      'Tilia cordata': 143,
      'Ulmus glabra': 71,
      'Ulmus laevis': 71,
      'Ulmus minor': 71,
      'Viburnum opulus': 63
    },
    1500,
    {'lat': 53.8951667, 'lon': 14.7248611},
  ),
  TinyForest(
    "Klinikum Herford",
    "./images/forests/default.jpeg",
    true,
    2022,
    750,
    25,
    {
      'Acer campestre': 30,
      'Acer platanoides': 30,
      'Acer pseudoplatanus': 50,
      'Berberis vulgaris': 20,
      'Carpinus betulus': 50,
      'Cornus sanguinea': 20,
      'Corylus avellana': 30,
      'Crataegus monogyna': 20,
      'Cytisus scoparius': 20,
      'Fagus sylvatica': 50,
      'Frangula alnus': 20,
      'Fraxinus excelsior': 50,
      'Ilex aquifolium': 20,
      'Prunus padus': 30,
      'Prunus spinosa': 20,
      'Rhamnus cathartica': 20,
      'Ribes rubrum': 20,
      'Rosa arvensis': 20,
      'Rubus idaeus': 20,
      'Sambucus nigra': 20,
      'Sorbus torminalis': 35,
      'Taxus baccata': 50,
      'Tilia cordata': 35,
      'Tilia platyphyllos': 35,
      'Ulmus laevis': 35
    },
    250,
    {'lat': 52.1278877, 'lon': 8.7015054},
  ),
  TinyForest(
    "Hanau",
    "./images/forests/default.jpeg",
    true,
    2023,
    450,
    25,
    {
      'Anemone nemorosa': 25,
      'Athyrium filix-femina': 25,
      'Carpinus betulus': 20,
      'Cornus sanguinea': 30,
      'Crataegus monogyna': 30,
      'Euonymus europaeus': 30,
      'Fagus sylvatica': 10,
      'Frangula alnus': 30,
      'Fraxinus excelsior': 20,
      'Ilex aquifolium': 30,
      'Lamium galeobdolon': 25,
      'Potentilla sterilis': 25,
      'Quercus petraea': 10,
      'Quercus robur': 20,
      'Ribes rubrum': 25,
      'Rubus caesius': 30,
      'Rubus idaeus': 25,
      'Sambucus nigra': 25,
      'Sorbus aucuparia': 10,
      'Stellaria holostea': 25,
      'Tilia cordata': 10,
      'Ulmus laevis': 20,
      'Vaccinium corymbosum': 25,
      'Viburnum opulus': 30,
      'Viola reichenbachiana': 25
    },
    150,
    {'lat': 50.1263611, 'lon': 8.9208333},
  ),
  TinyForest(
    "Rüsselsheim",
    "./images/forests/default.jpeg",
    true,
    2023,
    700,
    31,
    {
      'Acer monspessulanum': 20,
      'Acer platanoides': 20,
      'Acer pseudoplatanus': 50,
      'Carpinus betulus': 50,
      'Cornus sanguinea': 20,
      'Corylus avellana': 20,
      'Crataegus monogyna': 20,
      'Cytisus scoparius': 20,
      'Fagus sylvatica': 50,
      'Frangula alnus': 20,
      'Fraxinus excelsior': 50,
      'Ilex aquifolium': 20,
      'Malus sylvestris': 20,
      'Prunus avium': 20,
      'Prunus padus': 20,
      'Prunus spinosa': 20,
      'Pyrus communis': 20,
      'Quercus petraea': 50,
      'Quercus robur': 50,
      'Rhamnus cathartica': 20,
      'Ribes rubrum': 20,
      'Rosa canina agg': 20,
      'Rubus idaeus': 20,
      'Salix purpurea': 20,
      'Sambucus nigra': 20,
      'Sorbus aucuparia': 20,
      'Sorbus torminalis': 20,
      'Taxus baccata': 20,
      'Tilia cordata': 20,
      'Tilia platyphyllos': 20,
      'Ulmus laevis': 20
    },
    250,
    {'lat': 49.9806389, 'lon': 8.4376111},
  ),
  TinyForest(
    "HSBI-Bielefeld",
    "./images/forests/default.jpeg",
    true,
    2024,
    600,
    16,
    {
      'Carpinus betulus': 31,
      'Corylus avellana': 35,
      'Crataegus laevigata': 35,
      'Fagus sylvatica': 31,
      'Ilex aquifolium': 35,
      'Lonicera periclymenum': 35,
      'Populus tremula': 55,
      'Prunus avium': 31,
      'Prunus spinosa': 35,
      'Quercus petraea': 31,
      'Quercus robur': 31,
      'Rubus idaeus': 35,
      'Rubus sect. Rubus': 35,
      'Salix caprea': 55,
      'Sambucus nigra': 35,
      'Sorbus aucuparia': 55
    },
    200,
    {'lat': 52.0436944, 'lon': 8.49275},
  ),
  TinyForest(
    "Grießheim 3.0",
    "./images/forests/default.jpeg",
    false,
    2024,
    0,
    31,
    {},
    250,
    {'lat': 49.8513056, 'lon': 8.5536667},
  ),
  TinyForest(
    "Mühlheim",
    "./images/forests/default.jpeg",
    false,
    2024,
    0,
    24,
    {},
    150,
    {'lat': 50.1243056, 'lon': 8.8404167},
  ),
  TinyForest(
    "HSBI (Bielefeld)",
    "./images/forests/default.jpeg",
    false,
    2024,
    0,
    24,
    {},
    150,
    {'lat': 52.0436944, 'lon': 8.49275},
  ),
];
