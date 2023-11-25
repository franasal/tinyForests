// Klasse für Filme, damit wir neben dem Pfad das Erscheinungsjahr angeben / abrufen können
class TinyForest {
  final String forestName;
  final String image;
  final int yearPlanted;
  final int totalTrees;
  final int numberPlantedSpecies;
  final int forestSize;

  TinyForest(this.forestName, this.image, this.yearPlanted, this.totalTrees,
      this.numberPlantedSpecies, this.forestSize);
}

// Liste mit Tiny Forests, damit wir neben dem Pfad
// auch das Jahr angeben und abrufen können
List<TinyForest> tForest = [
  TinyForest(
    "Rozwarowo",
    "./images/forests/example1.jpeg",
    2021,
    4526,
    45,
    1500,
  ),
  TinyForest(
    "Darmstadt",
    "./images/forests/example2.jpeg",
    2021,
    4526,
    45,
    1500,
  ),
  TinyForest(
    "Herford",
    "./images/forests/example3.jpeg",
    2022,
    4526,
    45,
    1500,
  ),
];
