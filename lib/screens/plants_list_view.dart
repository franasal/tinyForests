import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/plants_data.dart';
import 'package:tinyforests/widgets/cards.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlantsListView extends StatelessWidget {
  final Map<String, PlantData> allPlants;
  // This is a list of sample plant data. You can replace this with your own data source.

  const PlantsListView({super.key, required this.allPlants});

  @override
  Widget build(BuildContext context) {
    final List<PlantData> plants = allPlants.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.allPlantsTitle,
        ),
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
