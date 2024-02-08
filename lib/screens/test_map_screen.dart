import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:tinyforests/datamodels/plant_distribution.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class TestMapScreen extends StatefulWidget {
  final String plantName;

  TestMapScreen({required this.plantName});

  @override
  _TestMapScreenState createState() => _TestMapScreenState();
}

class _TestMapScreenState extends State<TestMapScreen> {
  late MapShapeSource dataSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  late List<Model> data;

  @override
  void initState() {
    List<Model> data = createModel(widget.plantName);

    print(data);
    dataSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'name',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].country,
      shapeColorValueMapper: (int index) {
        return data[index].color;
      },
      shapeColorMappers: [
        MapColorMapper(value: "Introduced", color: Colors.red),
        MapColorMapper(value: "Native", color: Colors.green)
      ],
    );
    _zoomPanBehavior = MapZoomPanBehavior(
      enableDoubleTapZooming: true,
      focalLatLng: MapLatLng(0, 0),
      zoomLevel: 1.5,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SfMaps(
          layers: <MapLayer>[
            MapShapeLayer(
              source: dataSource,
              legend: MapLegend(MapElement.shape),
              zoomPanBehavior: _zoomPanBehavior,
              loadingBuilder: (BuildContext context) {
                return Container(
                  height: 25,
                  width: 25,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}

class Model {
  const Model(this.country, this.color);

  final String country;
  final String color;
}

List<Model> createModel(String plantName) {
  List<Model> result = [];

  for (Map<String, int> entry in allPlantsDistribution[plantName]!) {
    String country = entry.keys.first;
    bool isGreen = entry.values.first == 1;

    result.add(Model(country, isGreen ? "Introduced" : "Native"));
  }

  print(result);

  return result;
}
