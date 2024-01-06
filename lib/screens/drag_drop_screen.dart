import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/utils/utils.dart';

/// Flutter code sample for [Draggable].

// void main() => runApp(const DraggableExampleApp());

// class DraggableExampleApp extends StatelessWidget {
//   const DraggableExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: const DraggableExample(),
//         bottomNavigationBar: bottomNaviBar(context),
//       ),
//     );
//   }
// }

// class DraggableExample extends StatefulWidget {
//   const DraggableExample({super.key});

//   @override
//   State<DraggableExample> createState() => _DraggableExampleState();
// }

// class _DraggableExampleState extends State<DraggableExample> {
//   int acceptedData = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Draggable<int>(
//           // Data is the value this Draggable stores.
//           data: 10,
//           feedback: Container(
//             color: Colors.deepOrange,
//             height: 100,
//             width: 100,
//             child: const Icon(Icons.directions_run),
//           ),
//           childWhenDragging: Container(
//             height: 100.0,
//             width: 100.0,
//             color: Colors.pinkAccent,
//             child: const Center(
//               child: Text('Child When Dragging'),
//             ),
//           ),
//           child: TreeItemCard(plantData: plantData),
//         ),
//         DragTarget<int>(
//           builder: (
//             BuildContext context,
//             List<dynamic> accepted,
//             List<dynamic> rejected,
//           ) {
//             return Container(
//               height: 100.0,
//               width: 100.0,
//               color: Colors.cyan,
//               child: Center(
//                 child: Text('Value is updated to: $acceptedData'),
//               ),
//             );
//           },
//           onAccept: (int data) {
//             setState(() {
//               acceptedData += data;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

//   void _showForestDetails(TinyForest forest) {
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
//           MediaQuery.of(context).size.height * 0.65)),
//       isScrollControlled: true,
//       // constraints: BoxConstraints.expand(),
//       showDragHandle: true,
//       context: context,
//       builder: (BuildContext context) {
//         // Schedule the map movement after the build phase is completed
//         Future.delayed(Duration.zero, () {
//           _mapController.move(
//             LatLng(
//               forest.coordinates['lat'] ?? 0.0,
//               forest.coordinates['lon'] ?? 0.0,
//             ),
//             15.0, // You can adjust the zoom level as needed
//           );
//         });

//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 forest.forestName,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Text('Year Planted: ${forest.yearPlanted}'),
//               // Text('Total Trees: ${forest.totalTrees}'),
//               Expanded(
//                 ListView(
//         children: sortedPlantTypes.expand((plantType) {
//           return [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 plantType,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             plantsGridView(groupedTrees[plantType]!),
//           ];
//         }).toList(),
//       ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class PlantsGridScreenDraggable extends StatelessWidget {
  final Map<String, PlantData> allPlants;
  final String pageTittle;

  // Define the order of plant types
  final List<String> plantTypeOrder = [
    'Hauptbaumart',
    'Nebenbaumart',
    'Strauch',
    'Bodendecker'
  ];

  PlantsGridScreenDraggable(
      {super.key, required this.allPlants, required this.pageTittle});

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
      appBar: AppBar(
        title: Text(pageTittle),
      ),
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
      bottomNavigationBar: bottomNaviBar(context),
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
      return Draggable<int>(
        // Data is the value this Draggable stores.
        data: 10,
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
