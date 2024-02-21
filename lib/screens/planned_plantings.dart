import 'package:flutter/material.dart';
import 'package:tinyforests/utils/utils.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tinyforests/widgets/cards.dart';
import 'package:tinyforests/datamodels/forest_db.dart';

class PlannedPlantings extends StatefulWidget {
  const PlannedPlantings({super.key});

  @override
  State<PlannedPlantings> createState() => _PlannedPlantingsState();
}

class _PlannedPlantingsState extends State<PlannedPlantings> {
  Map<String, Map<String, dynamic>> testEventList = forestsDB;

  List<Map<String, dynamic>> filteredForests =
      filterForestsByYear(forestsDB, 2023);

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, String>> eventsList = testEventList.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.eventsPage,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Text("See the upcoming events and sign up for them")),
          Expanded(
            flex: 3,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: forestsDB.entries
                  .where((entry) =>
                      entry.value['Pflanzjahr'] >=
                      2024) // Filter entries with Pflanzjahr >= 2024
                  .map((entry) => Announcements(entry.value))
                  .toList(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(20),
              child: Text(
                'Here there will be more',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
