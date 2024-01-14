import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/plants_grid_view_screen.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gridSize),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.gridSizeDialogContent),
            SizedBox(
              width: 25.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildNumberPicker(
                      AppLocalizations.of(context)!.gridSizeRows,
                      AppLocalizations.of(context)!.gridSizeRows,
                      numRows),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: _buildNumberPicker(
                      AppLocalizations.of(context)!.gridSizeColumns,
                      AppLocalizations.of(context)!.gridSizeRows,
                      numCols),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GridScreen(
                      numRows: numRows,
                      numCols: numCols,
                    ),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.createGrid),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }

  Widget _buildNumberPicker(String label, String rowsLab, int value) {
    return Column(
      children: [
        SizedBox(
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
        Text(' $label'),
      ],
    );
  }
}

class GridScreen extends StatefulWidget {
  final int numRows;
  final int numCols;

  const GridScreen({super.key, required this.numRows, required this.numCols});

  @override
  // ignore: library_private_types_in_public_api
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  double scale = 1.0;
  Offset offset = Offset.zero;
  Offset initialFocalPoint = Offset.zero;
  Offset sessionOffset = Offset.zero;
  double initialScale = 1.0;

  int maxNumber = 100;

  // Define the order of plant types
  final List<String> plantTypeOrder = [
    'Hauptbaumart',
    'Nebenbaumart',
    'Strauch',
    'Bodendecker'
  ];

  late List<Widget?> gridItems;

  @override
  void initState() {
    super.initState();
    gridItems = List.filled(
      widget.numCols * widget.numRows,
      Container(), // Initialize with an empty Container()
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, PlantData>> groupedTrees =
        groupTreesByType(allPlants);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.zoomableGrid),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onScaleStart: (details) {
                initialFocalPoint = details.focalPoint;
                sessionOffset = offset;
                initialScale = scale;
              },
              onScaleUpdate: (details) {
                setState(() {
                  scale = initialScale * details.scale;
                  offset =
                      sessionOffset + (details.focalPoint - initialFocalPoint);
                });
              },
              child: Transform.scale(
                scale: scale,
                child: Transform.translate(
                  offset: offset,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.numCols,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: 1,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return DragTarget<Widget>(
                        builder: (BuildContext context,
                            List<Widget?> candidateData, rejectedData) {
                          Widget? droppedItem = gridItems[index];

                          return GestureDetector(
                            onLongPress: () {
                              _removeItemClicked(context, index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                color: candidateData.isNotEmpty
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                              child: droppedItem != null
                                  ? gridItems[index]
                                  : const Text("."),
                            ),
                          );
                        },
                        onWillAccept: (data) {
                          return true;
                        },
                        onAccept: (data) {
                          setState(() {
                            gridItems[index] = data;
                          });
                        },
                      );
                    },
                    itemCount: widget.numRows * widget.numCols,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white60,
            height: 10.w,
            child: Text("forest design - drag and drop testing "),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                for (String plantType in plantTypeOrder)
                  if (groupedTrees.containsKey(plantType))
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            plantType,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        plantsGridViewDraggable(groupedTrees[plantType]!),
                      ],
                    ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }

  void _removeItemClicked(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text('Are you sure you want to remove this item?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  gridItems[index] = Container(); // Reset to an empty space
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}

// function to create a GridView of tree items in each row
GridView plantsGridViewDraggable(Map<String, PlantData> someTrees) {
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
      return LongPressDraggable<Widget>(
        // Data is the value this Draggable stores.
        feedback: Container(
          color: Colors.deepOrange,
          height: 80,
          width: 80,
          child: Image.asset(plantData.pathPicture),
        ),

        childWhenDragging: Container(),
        data: CustomClickableWidget(plantType: plantData.plantType),

        child: TreeItemCard(
          plantData: plantData,
        ),
      );
    },
  );
}

class CustomClickableWidget extends StatelessWidget {
  final String plantType;

  CustomClickableWidget({
    required this.plantType,
  });

  @override
  Widget build(BuildContext context) {
    // Map plantType to the corresponding image path

    Map<String, String> plantTypeImageMap = {
      'Hauptbaumart': 'images/plantTypes/Hauptbaum.png',
      'Nebenbaumart': 'images/plantTypes/Nebenbaum.png',
      'Strauch': 'images/plantTypes/Strauch.png',
      'Bodendecker': 'images/plantTypes/Bodendecker.png',
    };

    // Check if the plantType is in the plantTypeOrder list
    if (plantTypeImageMap.keys.contains(plantType)) {
      String imagePath =
          plantTypeImageMap[plantType] ?? ''; // Get the image path

      return InkWell(
        onTap: () {
          // Show RenderBox with options when clicked
          _showOptions(context);
        },
        child: Image.asset(imagePath), // Display the clickable picture
      );
    } else {
      return Text('Invalid plant type');
    }
  }

  void _showInfoPopup(BuildContext context) {
    // Show a small popup text for onInfoClicked
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text('This is the info popup for $plantType.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _onCustomClicked(BuildContext context) {
    // Show a small popup text for onInfoClicked
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text('This is the info popup for $plantType.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Options for $plantType'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => _showInfoPopup(context),
                child: Text('Info'),
              ),
              ElevatedButton(
                onPressed: () => _onCustomClicked(context),
                child: Text('Remove Item'),
              ),
              ElevatedButton(
                onPressed: () => _onCustomClicked(context),
                child: Text('Custom'),
              ),
            ],
          ),
        );
      },
    );
  }
}



// class CustomClickablePicture extends StatelessWidget {
//   final String plantType;
//   final Function(String) onInfoClicked;
//   final Function(String) onRemoveClicked;
//   final Function(String) onCustomClicked;

//   // Constructor to initialize the widget with required callbacks
//   CustomClickablePicture({
//     required this.plantType,
//     required this.onInfoClicked,
//     required this.onRemoveClicked,
//     required this.onCustomClicked,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Check if the plantType matches any of the predefined types
//     if (plantTypeOrder.contains(plantType)) {
//       // Return a clickable picture with options
//       return GestureDetector(
//         onTap: () {
//           // Open RenderBox with options when clicked
//           _showOptions(context);
//         },
//         child: Image.asset(
//           _getImagePath(plantType),
//           // Adjust width and height as needed
//           width: 100,
//           height: 100,
//           // Other image properties
//         ),
//       );
//     } else {
//       // Return a default widget if plantType doesn't match
//       return Text('Invalid plant type');
//     }
//   }

//   // Method to show the RenderBox with options
//   void _showOptions(BuildContext context) {
//     // Implement the RenderBox with options (info, remove item, custom)
//     // Use onInfoClicked, onRemoveClicked, onCustomClicked callbacks as needed
//     // You can use showDialog or another widget to display the options
//     // Example:
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Options for $plantType'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () => _showInfoPopup(),
//                 child: Text('Info'),
//               ),
//               ElevatedButton(
//                 onPressed: () => onRemoveClicked(plantType),
//                 child: Text('Remove Item'),
//               ),
//               ElevatedButton(
//                 onPressed: () => onCustomClicked(plantType),
//                 child: Text('Custom'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Method to get the image path based on plantType
//   String _getImagePath(String plantType) {
//     // Add your logic to determine the image path based on plantType
//     // Example: return 'assets/$plantType.png';
//     return '';
//   }

// void _showInfoPopup(BuildContext context, ) {
//     // Show a small popup text for onInfoClicked
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Info'),
//           content: Text('This is the info popup for $plantType.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   // Predefined plant types
//   static const plantTypeOrder = [
//     'Hauptbaumart',
//     'Nebenbaumart',
//     'Strauch',
//     'Bodendecker',
//   ];
// }



