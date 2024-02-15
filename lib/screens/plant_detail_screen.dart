import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/plants_data.dart'; //  tree data model
import 'package:tinyforests/screens/plant_full_size_screen.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:tinyforests/widgets/builderitems.dart'; // custom widgets
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tinyforests/widgets/interactive_map.dart';

// This screen is for displaying details of a specific tree, right now is just plain text
class PlantDetailsScreen extends StatelessWidget {
  final String plantName;
  final Map<String, PlantData> allPlants;
  // final Map<String, PlantData> allPlants = await parseJsonFromAssets();

  // constructor to receive the plant name and allPlants map
  const PlantDetailsScreen(
      {super.key, required this.plantName, required this.allPlants});

  @override
  Widget build(BuildContext context) {
    // Find the corresponding plant data based on the plant name
    PlantData plantData = allPlants[plantName]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          plantData.commonName,
          style: TextStyle(
              fontSize: 40,
              color: const Color.fromARGB(255, 31, 71, 32),
              fontWeight: FontWeight.bold),
        ), // showing the common name in the app bar as tittle TODO big language automation
      ),
      body: ListView(
        children: [
          //  title section defined in the bottom displaying common name, scientific name, and an image
          buildCustomTitleSection(
            context,
            plantData,
          ), // the following text fields are placeholders to show an example of what information this screen shows, TODO make it a nicer visualization
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.conservationStatus,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.sp, // Adjust the font size as needed
              ),
            ),
          ),
          ListTile(
            title: Text(plantData.conservationStatus),
          ),
          ListTile(
              title: Text(
            AppLocalizations.of(context)!.interestingFact,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12.sp, // Adjust the font size as needed
            ),
          )),
          ListTile(
            title: Text(plantData.interestingFact),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.distribution,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.sp, // Adjust the font size as needed
              ),
            ), // distribution information will have a map or a picture of their distribution
          ),
          Center(
            child: Container(
                height: 280,
                child: DistributionMap(
                  plantName: plantData.scientificName,
                  natives: AppLocalizations.of(context)!.native,
                  introduced: AppLocalizations.of(context)!.introduced,
                )),
          ),
          SizedBox(
            height: 18.sp,
          ),

          Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: formatCountryList(
                  context,
                  plantData.scientificName,
                  AppLocalizations.of(context)!.introduced,
                  AppLocalizations.of(context)!.native),
            ),
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
Widget buildCustomTitleSection(BuildContext context, PlantData plantData) {
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
                  plantData.scientificName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 148, 148, 148),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FullSizeImageScreen(imagePath: plantData.pathPicture),
              ),
            );
          },
          child: Hero(
            tag: plantData.pathPicture,
            child: Image.asset(
              plantData.pathPicture,
              height: 120,
              width: 120,
            ),
          ),
        ),
      ],
    ),
  );
}
