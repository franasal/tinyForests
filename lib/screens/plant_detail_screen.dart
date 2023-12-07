import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/plants_data.dart'; //  tree data model
import 'package:tinyforests/widgets/builderitems.dart'; // custom widgets

// This screen is for displaying details of a specific tree, right now is just plain text
class TreeDetailsScreen extends StatelessWidget {
  final String plantName;
  final Map<String, PlantData> allPlants;

  // constructor to receive the plant name and allPlants map
  TreeDetailsScreen({required this.plantName, required this.allPlants});

  @override
  Widget build(BuildContext context) {
    // Find the corresponding plant data based on the plant name
    PlantData plantData = allPlants[plantName]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${plantData.commonName}, Details'), // showing the common name in the app bar as tittle
      ),
      body: ListView(
        children: [
          //  title section defined in the bottom displaying common name, scientific name, and an image
          buildCustomTitleSection(
            plantData.commonName,
            plantData.scientificName,
            plantData.pathPicture,
          ), // the following text fields are placeholders to show an example of what information this screen shows, TODO make it a nicer visualization
          ListTile(
            title: Text('Conservation Status: ${plantData.conservationStatus}'),
          ),
          ListTile(
            title: Text('Interesting Fact: ${plantData.interestingFact}'),
          ),
          ListTile(
            title: Text(
                'Distribution: ${plantData.distribution}'), // distribution information will have a map or a picture of their distribution
          ),
          // more details from the Plant class will be shown here.
        ],
      ),
      bottomNavigationBar: bottomNaviBar(
          context), // custom bottom navigation bar from builderitems.dart
    );
  }
}

// Custom function to build a title section with a title, subtitle, and image using a container
Widget buildCustomTitleSection(
    String title, String subtitle, String pathPicture) {
  return Container(
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color.fromARGB(255, 148, 148, 148),
                ),
              ),
            ],
          ),
        ),
        Image.asset(pathPicture), // displays the thumbnail of the given tree
      ],
    ),
  );
}
