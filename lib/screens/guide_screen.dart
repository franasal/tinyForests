// a placeholder screen for future development,

import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class ForestGuide extends StatefulWidget {
  const ForestGuide({super.key});

  @override
  State<ForestGuide> createState() => _ForestGuideState();
}

class _ForestGuideState extends State<ForestGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide'),
      ),
      body: const Center(
        child: Text("here comes a guide"),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
