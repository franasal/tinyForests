// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Import the Geolocator package
import 'package:tinyforests/datamodels/forests_data.dart';
import 'package:tinyforests/screens/forest_detail_widget.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class ForestMaps extends StatefulWidget {
  const ForestMaps({super.key});

  @override
  State<ForestMaps> createState() => _ForestMapsState();
}

class _ForestMapsState extends State<ForestMaps> {
  late MapController _mapController;

  final LatLng _startLocation = const LatLng(53.8956, 14.7294);
  Position? _userLocation;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  Future<void> _goUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      // accessing the position and request users of the
      // app to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle appropriately.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted, and we can
    // continue accessing the position of the device.
    try {
      Position locationData = await Geolocator.getCurrentPosition();
      setState(() {
        _userLocation = locationData;
      });

      // Use null-aware operator to handle nullable values
      _mapController.move(
        LatLng(
          locationData.latitude,
          locationData.longitude,
        ),
        5,
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // CurrentLocationLayer(),
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _startLocation,
              initialZoom: 5.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: _buildMarkers(),
              ),
            ],
          ),
          // CurrentLocationLayer(), TODO this not working
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: _goUserLocation,
              tooltip: 'Go to Current Location',
              child: const Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    for (TinyForest forest in tForest) {
      markers.add(
        Marker(
          point: LatLng(
            forest.coordinates['lat'] ?? 0.0,
            forest.coordinates['lon'] ?? 0.0,
          ),
          width: 80,
          height: 80,
          child: GestureDetector(
            onTap: () => _showForestDetails(forest),
            child: Image.asset(
              './images/icons/LocGree.png',
              width: 10,
              height: 10,
            ),
          ),
        ),
      );
    }

    for (TinyForest forest in plannedForest) {
      markers.add(
        Marker(
          point: LatLng(
            forest.coordinates['lat'] ?? 0.0,
            forest.coordinates['lon'] ?? 0.0,
          ),
          width: 80,
          height: 80,
          child: GestureDetector(
            onTap: () => _showForestDetails(forest),
            child: Image.asset(
              './images/icons/LocOrang.png',
              width: 10,
              height: 10,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  void _showForestDetails(TinyForest forest) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.65)),
      isScrollControlled: true,
      // constraints: BoxConstraints.expand(),
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        // Schedule the map movement after the build phase is completed
        Future.delayed(Duration.zero, () {
          _mapController.move(
            LatLng(
              forest.coordinates['lat'] ?? 0.0,
              forest.coordinates['lon'] ?? 0.0,
            ),
            15.0, // You can adjust the zoom level as needed
          );
        });

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                forest.forestName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Text('Year Planted: ${forest.yearPlanted}'),
              // Text('Total Trees: ${forest.totalTrees}'),
              Expanded(
                child: ForestDetailWidget(
                  forestName: forest.forestName,
                  image: forest.image,
                  yearPlanted: forest.yearPlanted,
                  totalTrees: forest.totalTrees,
                  listPlanted: forest.listPlanted,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
