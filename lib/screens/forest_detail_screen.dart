// New screen for image detail
import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/trees_data.dart';
import 'package:tinyforests/screens/tree_grid_view_screen.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class DetailScreen extends StatelessWidget {
  final String image;
  final String forestName;
  final int yearPlanted;
  final Map<String, PlantData> listPlanted;
  final int totalTrees;

  const DetailScreen(
      {super.key,
      required this.image,
      required this.yearPlanted,
      required this.totalTrees,
      required this.listPlanted,
      required this.forestName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(forestName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            const SizedBox(height: 16),
            Text(
              'Year Planted: $yearPlanted',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Number of Trees Planted: $totalTrees',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(child: plantsGridView(allTrees))
          ],
        ),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
