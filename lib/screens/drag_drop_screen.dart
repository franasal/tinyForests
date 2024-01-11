import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ZoomableGrid extends StatefulWidget {
  const ZoomableGrid({super.key});

  @override
  ZoomableGridState createState() => ZoomableGridState(allPlants);
}

class ZoomableGridState extends State<ZoomableGrid> {
  double scale = 1.0;
  int numRows = 5; // Initial number of rows in the grid
  int numCols = 5; // Initial number of columns in the grid
  int maxNumber = 100;

  // Define the order of plant types
  final List<String> plantTypeOrder = [
    'Hauptbaumart',
    'Nebenbaumart',
    'Strauch',
    'Bodendecker'
  ];

  ZoomableGridState(this.allPlants);

  final Map<String, PlantData> allPlants;

  @override
  Widget build(BuildContext context) {
    List<Widget?> gridItems = List.filled(numCols * numRows, null);

    bool _isDropped = false;

    Map<String, Map<String, PlantData>> groupedTrees =
        groupTreesByType(allPlants);

    // Sort the keys of groupedTrees based on plantTypeOrder
    List<String> sortedPlantTypes = plantTypeOrder
        .where((plantType) => groupedTrees.containsKey(plantType))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.zoomableGrid),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onScaleUpdate: (ScaleUpdateDetails details) {
                  setState(() {
                    scale = details.scale;
                  });
                },
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 400,
                    color: Colors.lightGreen,
                    child: CustomScrollView(
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: numCols,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 1.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return DragTarget<Widget>(
                                    builder: (BuildContext context,
                                        List<Widget?> candidateData,
                                        rejectedData) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          color: candidateData.isNotEmpty
                                              ? Colors
                                                  .grey // Change color when dragging over
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: _isDropped
                                              ? gridItems[index]
                                              : const Text("."),
                                        ),
                                      );
                                    },
                                    onWillAccept: (data) {
                                      // Return true if the data being dragged can be accepted here
                                      return true;
                                    },
                                    onAccept: (data) {
                                      setState(() {
                                        print(data);
                                        gridItems[index] = data;
                                        _isDropped = true;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            childCount: numRows * numCols,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text("forest design - drag and drop testing "),
          Expanded(
            flex: 1,
            child: ListView(
              children: sortedPlantTypes.expand((plantType) {
                return [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      plantType,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  plantsGridView(groupedTrees[plantType]!),
                ];
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
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
              _buildNumberPicker(AppLocalizations.of(context)!.gridSizeRows,
                  AppLocalizations.of(context)!.gridSizeRows, numRows),
              Text(AppLocalizations.of(context)!.gridSizeColumns),
              _buildNumberPicker(AppLocalizations.of(context)!.gridSizeColumns,
                  AppLocalizations.of(context)!.gridSizeRows, numCols),
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
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNumberPicker(String label, String rowsLab, int value) {
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
                  if (label == rowsLab) {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSizeDialog(context);
    });
  }
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
      return LongPressDraggable<Widget>(
        // Data is the value this Draggable stores.
        feedback: Container(
          color: Colors.deepOrange,
          height: 80,
          width: 80,
          child: Image.asset(plantData.pathPicture),
        ),

        childWhenDragging: Container(),
        data: Container(
          color: Colors.deepOrange,
          height: 80,
          width: 80,
          child: Image.asset(plantData.pathPicture),
        ),

        child: TreeItemCard(plantData: plantData, statusColor: Colors.white),
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
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 22.w,
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
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
