// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/plants_grid_view_screen.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:circular_menu/circular_menu.dart';

class ZoomableGrid extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
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
            const SizedBox(height: 20),
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
                            onTap: () {
                              PlantData? plantData =
                                  getPlantTypeFromIndex(index);
                              if (droppedItem != null &&
                                  droppedItem is! Container) {
                                _showOptions(context, index, plantData);
                              }
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
                                  : SizedBox.shrink(),
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
            child: Text(AppLocalizations.of(context)!
                .explainDragDrop), // Text(AppLocalizations.of(context)!.zoomableGrid),
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

  PlantData? getPlantTypeFromIndex(int index) {
    Widget? widgetAtIndex = gridItems[index];

    if (widgetAtIndex is CustomClickableWidget) {
      return widgetAtIndex.getPlantType();
    }

    // Return a default value or handle the case where the widget is not of type CustomClickableWidget
    return null;
  }

  void _showOptions(BuildContext context, int index, PlantData? plantData) {
    // Get the position of the current widget in the screen coordinates
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);

    final Alignment alignment = Alignment(
      (widgetPosition.dx / MediaQuery.of(context).size.width) * 2 - 1,
      (widgetPosition.dy / MediaQuery.of(context).size.height) * 2 - 1,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CircularMenu(
          alignment: alignment,
          radius: 60,
          startingAngleInRadian: 1,
          endingAngleInRadian: 3.14 * 3,
          toggleButtonColor: Colors.greenAccent,
          items: [
            MyCircularMenuItem(
              tooltip: "compost",
              icon: Icons.compost,
              color: Colors.green,
              onTap: () {
                setState(
                  () {
                    gridItems[index] = Container(); // Reset to an empty space
                  },
                );
                Navigator.of(context).pop();
              },
            ),
            CircularMenuItem(
              icon: Icons.info,
              color: Colors.green,
              onTap: () => _showInfoPopup(context, plantData),
            ),
            CircularMenuItem(
              icon: Icons.settings,
              color: Colors.green,
              onTap: () => _onCustomClicked(context, plantData),
            ),
          ],
        );
      },
    );
  }

  void _showInfoPopup(BuildContext context, PlantData? plantData) {
    // Show a small popup text for onInfoClicked
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(plantData!.commonName),
          content: Text(
              AppLocalizations.of(context)!.infoPopUp(plantData.commonName),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!
                  .close), // Text(AppLocalizations.of(context)!.zoomableGrid),
            ),
          ],
        );
      },
    );
  }

  void _onCustomClicked(BuildContext context, PlantData? plantData) {
    // Show a small popup text for onInfoClicked
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Custom'), // Text(AppLocalizations.of(context)!.zoomableGrid),
          content: Text(AppLocalizations.of(context)!.placeholderText),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!
                  .close), //Text(AppLocalizations.of(context)!.close),
            ),
          ],
        );
      },
    );
  }
}
