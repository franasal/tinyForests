import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:tinyforests/datamodels/plant_distribution.dart';

class DistributionMap extends StatefulWidget {
  final String plantName;
  final String natives;

  final String introduced;

  DistributionMap(
      {required this.plantName,
      required this.natives,
      required this.introduced});

  @override
  _DistributionMapState createState() => _DistributionMapState();
}

class _DistributionMapState extends State<DistributionMap> {
  late MapShapeSource dataSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  late List<Model> data;

  @override
  void initState() {
    List<Model> data =
        createModel(widget.plantName, widget.introduced, widget.natives);

    dataSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'name',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].country,
      shapeColorValueMapper: (int index) {
        return data[index].color;
      },
      shapeColorMappers: [
        MapColorMapper(value: widget.introduced, color: Colors.purple),
        MapColorMapper(value: widget.natives, color: Colors.green)
      ],
    );
    _zoomPanBehavior = MapZoomPanBehavior(
      enableDoubleTapZooming: true,
      focalLatLng: MapLatLng(53.551086, 9.993682),
      zoomLevel: 1.5,
      toolbarSettings: MapToolbarSettings(
        position: MapToolbarPosition.bottomRight,
        iconColor: Colors.red,
        itemBackgroundColor: Colors.green,
        itemHoverColor: Colors.blue,
      ),
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
    );
  }
}

class Model {
  const Model(this.country, this.color);

  final String country;
  final String color;
}

List<Model> createModel(String plantName, String introduced, String natives) {
  List<Model> result = [];

  for (Map<String, int> entry in allPlantsDistribution[plantName]!) {
    String country = entry.keys.first;
    bool isGreen = entry.values.first == 1;

    result.add(Model(country, isGreen ? introduced : natives));
  }

  return result;
}
