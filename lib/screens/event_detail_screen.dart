import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/widgets/builderitems.dart'; // custom widgets
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// This screen is for displaying details of a specific tree, right now is just plain text
class EventDetailsScreen extends StatelessWidget {
  final Map event;
  // final Map<String, PlantData> allPlants = await parseJsonFromAssets();

  // constructor to receive the plant name and allPlants map
  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Find the corresponding plant data based on the plant name

    return Scaffold(
      appBar: AppBar(
        title: Text(
          event["Event name"],
          style: TextStyle(
              fontSize: 40, color: Colors.green, fontWeight: FontWeight.bold),
        ), // showing the common name in the app bar as tittle TODO big language automation
      ),
      body: Text("placeholder"),
      bottomNavigationBar: bottomNaviBar(
          context), // custom bottom navigation bar from builderitems.dart
    );
  }
}
