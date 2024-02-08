// a placeholder screen for future development,

import 'package:flutter/material.dart';
import 'package:tinyforests/screens/test_map_screen.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestScreens extends StatefulWidget {
  const TestScreens({super.key});

  @override
  State<TestScreens> createState() => _TestScreensState();
}

class _TestScreensState extends State<TestScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.testingTitle,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.testingSubTitle,
            ),
          ),
          InkWell(
            onTap: () {
              // Navigate to PlantView screen when image is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TestMapScreen(plantName: "Acer platanoides"),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                "images/plants/Default.png",
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
