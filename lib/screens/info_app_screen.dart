// a placeholder screen for future development,

import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class Impressum extends StatefulWidget {
  const Impressum({super.key});

  @override
  State<Impressum> createState() => _ImpressumState();
}

class _ImpressumState extends State<Impressum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impressum'),
      ),
      body: const Center(
        child: Text("Hier kommt impressum"),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
