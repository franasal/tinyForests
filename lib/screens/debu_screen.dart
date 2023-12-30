import 'package:flutter/material.dart';
import 'package:tinyforests/datamodels/plants_data.dart';

class DebugScreen extends StatelessWidget {
  final Map<String, PlantData> data;

  DebugScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    // Convert the map entries to strings using toString
    List<String> dataAsStringList = data.entries
        .map((entry) => '"${entry.key}": ${entry.value.toString()},')
        .toList();

    // Join the list of strings with line breaks
    String dataAsString = dataAsStringList.join('\n');

    return Scaffold(
      appBar: AppBar(
        title: Text('Debug Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SelectableText(
          dataAsString,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
