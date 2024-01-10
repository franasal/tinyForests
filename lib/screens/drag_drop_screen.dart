import 'package:flutter/cupertino.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DragGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.zoomableGrid),
        ),
        body: Center(
          child: ZoomableGrid(),
        ),
        bottomNavigationBar: bottomNaviBar(context),
      ),
    );
  }
}

class ZoomableGrid extends StatefulWidget {
  @override
  _ZoomableGridState createState() => _ZoomableGridState();
}

class _ZoomableGridState extends State<ZoomableGrid> {
  double scale = 1.0;
  int numRows = 5; // Initial number of rows in the grid
  int numCols = 5; // Initial number of columns in the grid
  int maxNumber = 100;

  @override
  Widget build(BuildContext context) {
    double rowHeight = MediaQuery.of(context).size.height * 0.8 / numRows;

    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          scale = details.scale;
        });
      },
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: rowHeight * numRows,
          color: Colors.brown,
          child: CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numCols,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                    );
                  },
                  childCount: numRows * numCols,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.gridSizeDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.gridSizeDialogContent),
              _buildNumberPicker(
                  AppLocalizations.of(context)!.gridSizeRows, numRows),
              Text(AppLocalizations.of(context)!.gridSizeColumns),
              _buildNumberPicker(
                  AppLocalizations.of(context)!.gridSizeColumns, numCols),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showForestDetails(context);
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNumberPicker(String label, int value) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100.0,
            child: CupertinoPicker(
              itemExtent: 32.0,
              scrollController:
                  FixedExtentScrollController(initialItem: value - 1),
              onSelectedItemChanged: (int index) {
                setState(() {
                  if (label == AppLocalizations.of(context)!.gridSizeRows) {
                    numRows = index + 1;
                  } else {
                    numCols = index + 1;
                  }
                });
              },
              children: List.generate(
                maxNumber,
                (index) => Center(
                  child: Text((index + 1).toString()),
                ),
              ),
            ),
          ),
        ),
        Text(' $label'),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Placeholder text in the bottom sheet',
            style: TextStyle(fontSize: 18.0),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSizeDialog(context);
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:tinyforests/widgets/builderitems.dart';
// import 'package:tinyforests/datamodels/plants_data.dart';
// import 'package:tinyforests/utils/utils.dart';

// class GridScreen extends StatefulWidget {
//   @override
//   _GridScreenState createState() => _GridScreenState();
// }

// class _GridScreenState extends State<GridScreen> {
//   int rows = 0;
//   int columns = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grid Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _showGridSizeDialog(context);
//           },
//           child: Text('Set Grid Size'),
//         ),
//       ),
//       bottomNavigationBar: bottomNaviBar(context),
//     );
//   }

//   Future<void> _showGridSizeDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Set Grid Size'),
//           content: Column(
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Rows (1-50)'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     rows = int.tryParse(value) ?? 0;
//                   });
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Columns (1-100)'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     columns = int.tryParse(value) ?? 0;
//                   });
//                 },
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (rows > 0 && rows <= 50 && columns > 0 && columns <= 100) {
//                   Navigator.of(context).pop();
//                   _navigateToGrid(rows, columns);
//                 } else {
//                   // Show an error message or handle invalid input
//                 }
//               },
//               child: Text('Set'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _navigateToGrid(int rows, int columns) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GridDisplay(rows: rows, columns: columns),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class GridDisplay extends StatelessWidget {
//   final int rows;
//   final int columns;

//   // Adjust the size of the droppedImages list based on the actual number of slots
//   List<String> droppedImages;

//   GridDisplay({super.key, required this.rows, required this.columns})
//       : droppedImages = List.filled(rows * columns, '');

//   @override
//   Widget build(BuildContext context) {
//     context:
//     context;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grid Display'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: const Color.fromARGB(97, 76, 175, 79),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: columns,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 return DragTarget<Card>(
//                   builder: (
//                     BuildContext context,
//                     List<dynamic> accepted,
//                     List<dynamic> rejected,
//                   ) {
//                     bool isBeingDraggedOver = accepted.isNotEmpty;
//                     String droppedImage = droppedImages[index];
//                     return Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color:
//                               isBeingDraggedOver ? Colors.yellow : Colors.white,
//                         ),
//                       ),
//                       child: droppedImage.isNotEmpty
//                           ? Image.asset(droppedImage)
//                           : null,
//                     );
//                   },
//                   onAccept: (data) {
//                     // Handle the accepted data
//                   },
//                 );
//               },
//               itemCount: rows * columns,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

void _showForestDetails(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.65)),
    isScrollControlled: true,
    // constraints: BoxConstraints.expand(),
    showDragHandle: true,
    // constraints: BoxConstraints.expand(),
    builder: (BuildContext context) {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: PlantsGridScreenDraggable(
                      allPlants: allPlants, pageTitle: "pageTitle"))
            ],
          ));
    },
    context: context,
  );
}

class PlantsGridScreenDraggable extends StatelessWidget {
  final Map<String, PlantData> allPlants;
  final String pageTitle;

  // Define the order of plant types
  final List<String> plantTypeOrder = [
    'Hauptbaumart',
    'Nebenbaumart',
    'Strauch',
    'Bodendecker'
  ];

  PlantsGridScreenDraggable(
      {super.key, required this.allPlants, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    // groups the allPlants by plant type with the function defined at the bottom of this file
    Map<String, Map<String, PlantData>> groupedTrees =
        groupTreesByType(allPlants);

    // Sort the keys of groupedTrees based on plantTypeOrder
    List<String> sortedPlantTypes = plantTypeOrder
        .where((plantType) => groupedTrees.containsKey(plantType))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: sortedPlantTypes.expand((plantType) {
          return [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                plantType,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            plantsGridView(groupedTrees[plantType]!),
          ];
        }).toList(),
      ),
    );
  }

  // this function does the grouping of allPlants by plant type
  // before it was just a single grid with all plants but wanted to add some subsections.
}

// function to create a GridView of tree items in each row
GridView plantsGridView(Map<String, PlantData> someTrees) {
  Map<String, PlantData> orderedPlants = {};

  // Sort the subset Map by totalPlanted in descending order
  orderedPlants = Map.fromEntries(someTrees.entries.toList()
    ..sort((a, b) => b.value.totalPlanted.compareTo(a.value.totalPlanted)));

  return GridView.builder(
    physics:
        const NeverScrollableScrollPhysics(), // Disable GridView scrolling to fix stuck behaviour
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 0.80,
    ),
    itemCount: orderedPlants.length,
    itemBuilder: (BuildContext context, int index) {
      // Convert the map values to a list and get the PlantData instance
      PlantData plantData = orderedPlants.values.toList()[index];
      return LongPressDraggable<String>(
        // Data is the value this Draggable stores.
        data: plantData.pathPicture,
        feedback: Container(
          color: Colors.deepOrange,
          height: 100,
          width: 100,
          child: Image.asset(plantData.pathPicture),
        ),
        childWhenDragging:
            TreeItemCard(plantData: plantData, statusColor: Colors.pinkAccent),

        child:
            TreeItemCard(plantData: plantData, statusColor: Colors.transparent),
      );
    },
  );
}

// custom widget for displaying a thumbnail, the common and scientific name of a plant
class TreeItemCard extends StatelessWidget {
  final PlantData plantData;
  final Color statusColor;

  const TreeItemCard(
      {Key? key, required this.plantData, required this.statusColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: statusColor,
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                // picture from images/trees todo; change folder name to /plants
                image: AssetImage(plantData.pathPicture),

                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plantData.commonName,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, //  the number of lines to show
                ),
                Text(
                  plantData.scientificName,
                  style: const TextStyle(
                    fontSize: 9.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
