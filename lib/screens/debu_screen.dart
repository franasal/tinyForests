import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  runApp(DebugScreen());
}

class DebugScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: SfMaps(
            layers: [
              MapTileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                initialFocalLatLng: MapLatLng(-20, 147),
                initialZoomLevel: 3,
              )
            ],
          )),
    );
    // return Scaffold(
    //   body: Padding(
    //     padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
    //     child: SfMaps(
    //       title: const MapTitle('Austraila Map'),
    //       layers: <MapShapeLayer>[
    //         MapShapeLayer(
    //           source: _shapeSource,
    //           showDataLabels: true,
    //           legend: MapLegend(MapElement.shape),
    //           shapeTooltipBuilder: (BuildContext context, int index) {
    //             return Padding(
    //                 padding: EdgeInsets.all(7),
    //                 child: Text(_mapData[index].stateCode,
    //                     style: TextStyle(color: Colors.white)));
    //           },
    //           tooltipSettings: MapTooltipSettings(color: Colors.blue[900]),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  // static List<MapModel> _getMapData() {
  //   return <MapModel>[
  //     MapModel('Australian Capital Territory', 'ACT', Colors.amber),
  //     MapModel('New South Wales', '       New\nSouth Wales', Colors.cyan),
  //     MapModel('Queensland', 'Queensland', Colors.amber[400]),
  //     MapModel('Northern Territory', 'Northern\nTerritory', Colors.red[400]),
  //     MapModel('Victoria', 'Victoria', Colors.purple[400]),
  //     MapModel(
  //         'South Australia', 'South Australia', Colors.lightGreenAccent[200]),
  //     MapModel('Western Australia', 'Western Australia', Colors.indigo[400]),
  //     MapModel('Tasmania', 'Tasmania', Colors.lightBlue[100])
  //   ];
  // }
}

// class MapModel {
//   MapModel(this.state, this.stateCode, this.color);

//   String state;
//   String stateCode;
//   Color color;
// }

// class DebugScreen extends StatefulWidget {
//   late MapShapeSource _mapSource;

//   @override
//   void initState() {
//     _mapSource = MapShapeSource.asset(
//       'assets/australia.json',
//       shapeDataField: 'STATE_NAME',
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
//         child: SfMaps(
//           layers: [
//             MapShapeLayer(
//               source: _mapSource,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:tinyforests/datamodels/plants_data.dart';
// import 'package:tinyforests/widgets/builderitems.dart';

// class DebugScreen extends StatelessWidget {
//   final Map<String, PlantData> data;

//   DebugScreen({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     // Convert the map entries to strings using toString
//     List<String> dataAsStringList = data.entries
//         .map((entry) => '"${entry.key}": ${entry.value.toString()},')
//         .toList();

//     // Join the list of strings with line breaks
//     String dataAsString = dataAsStringList.join('\n');

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Debug Screen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SelectableText(
//           dataAsString,
//           style: TextStyle(fontSize: 16.0),
//         ),
//       ),
//       bottomNavigationBar: bottomNaviBar(context),
//     );
//   }
// }
