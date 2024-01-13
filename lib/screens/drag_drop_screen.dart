import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
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
        title: Text('Select Grid Size'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              color: candidateData.isNotEmpty
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                            child: droppedItem != null
                                ? gridItems[index]
                                : const Text("."),
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
                        plantsGridView(groupedTrees[plantType]!),
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
