import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/screens/plant_detail_screen.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class PlantsListView extends StatelessWidget {
  final Map<String, PlantData> allPlants;
  // This is a list of sample plant data. You can replace this with your own data source.

  const PlantsListView({super.key, required this.allPlants});

  @override
  Widget build(BuildContext context) {
    final List<PlantData> plants = allPlants.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plants List'),
      ),
      body: ListView.builder(
        itemCount: plants.length, // The number of items in the list
        itemBuilder: (context, index) {
          // The function that returns a widget for each item
          return PlantCard(plants[
              index]); // This is a custom widget that displays a card for each plant
        },
        scrollDirection: Axis.vertical, // The scroll direction of the list
      ),
      bottomNavigationBar: bottomNaviBar(context), // cus
    );
  }
}

class PlantCard extends StatelessWidget {
  // This is a custom widget that displays a card for each plant
  final PlantData plant; // The plant data to display
  const PlantCard(this.plant,
      {super.key}); // The constructor that takes the plant data as a parameter

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // Navigate to PlantView screen when image is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantDetailsScreen(
                      plantName: plant.scientificName, allPlants: allPlants),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                plant.pathPicture,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plant.commonName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  plant.scientificName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              plant.distribution,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message:
                      'Plant Type: ${plant.plantType}', // Explanation for the icon
                  child: Icon(
                    plant.plantType == 'Hauptbaumart'
                        ? Icons.nature
                        : plant.plantType == 'Nebenbaumart'
                            ? Icons.park
                            : plant.plantType == 'Strauch'
                                ? Icons.local_florist
                                : Icons.grass,
                    color: Colors.green,
                  ),
                ),
                Tooltip(
                  message: 'Height', // Explanation for the icon
                  child: const Icon(
                    Icons.height,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '${plant.maxSizeMeters} m',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                Tooltip(
                  message:
                      'Conservation Status: ${plant.conservationStatus}', // Explanation for the icon
                  child: Icon(
                    Icons.eco,
                    color: plant.conservationStatus == 'Critically Endangered'
                        ? Colors.red
                        : plant.conservationStatus == 'Near Threatened'
                            ? Colors.orange
                            : plant.conservationStatus == 'Vulnerable'
                                ? Colors.yellow
                                : Colors.green,
                  ),
                ),
                Tooltip(
                  message:
                      'Flowering Season: ${plant.floweringSeason}', // Explanation for the icon
                  child: Icon(
                    Icons.wb_sunny,
                    color: plant.floweringSeason == 'summer'
                        ? Colors.yellow
                        : Colors.grey,
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



//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Tooltip(
//                   message: 'Plant Type', // Explanation for the icon
//                   child: Icon(
//                     plant.plantType == 'Hauptbaumart'
//                         ? Icons.nature
//                         : plant.plantType == 'Nebenbaumart'
//                             ? Icons.park
//                             : plant.plantType == 'Strauch'
//                                 ? Icons.local_florist
//                                 : Icons.grass,
//                     color: Colors.green,
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Height', // Explanation for the icon
//                   child: const Icon(
//                     Icons.height,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 Text(
//                   '${plant.maxSizeMeters} m',
//                   style: const TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Conservation Status', // Explanation for the icon
//                   child: Icon(
//                     Icons.eco,
//                     color: plant.conservationStatus == 'endangered'
//                         ? Colors.red
//                         : Colors.green,
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Flowering Season', // Explanation for the icon
//                   child: Icon(
//                     Icons.wb_sunny,
//                     color: plant.floweringSeason == 'summer'
//                         ? Colors.yellow
//                         : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
