// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Import the Geolocator package
import 'package:tinyforests/datamodels/forests_data.dart';
import 'package:tinyforests/screens/cards.dart';
import 'package:tinyforests/screens/forest_detail_widget.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForestMaps extends StatefulWidget {
  const ForestMaps({Key? key}) : super(key: key);

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

    // Fetch user location and show nearby forests on screen creation
    _initializeLocationAndShowNearbyForests();
  }

  Future<void> _initializeLocationAndShowNearbyForests() async {
    await _goUserLocation();
    _showNearbyForests();
  }

  void _showLocationServiceDisabledDialog() {
    // Implement a dialog or snackbar to inform the user
    // that location services are disabled and encourage
    // them to enable it in device settings.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Services Disabled'),
          content:
              Text('Please enable location services in your device settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showLocationPermissionDeniedDialog() {
    // Implement a dialog or snackbar to inform the user
    // that location permissions are denied and provide
    // guidance on how to enable them.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permissions Denied'),
          content: Text(
              'Please grant location permissions in app settings to use this feature.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
      _showLocationServiceDisabledDialog();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, handle appropriately.
      // You can show a dialog or a snackbar to inform the user.
      _showLocationPermissionDeniedDialog();
      return;
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

    // Center the map on the user's current location
    if (_userLocation != null) {
      _mapController.move(
        LatLng(_userLocation!.latitude, _userLocation!.longitude),
        15.0, // You can adjust the zoom level as needed
      );
      _isDrawerOpen = false;
    }

    // Show nearby forests after centering the map
    _showNearbyForests();
  }

  bool showPlanted = false;
  bool showPlanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _userLocation != null
                  ? LatLng(_userLocation!.latitude, _userLocation!.longitude)
                  : _startLocation,
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
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: _goUserLocation,
              tooltip: AppLocalizations.of(context)!.myLocation,
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
              forest.planted
                  ? './images/icons/LocGree.png' // Use green icon for planted forests
                  : './images/icons/LocOrang.png', // Use orange icon for planned forests
              width: 10,
              height: 10,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  bool _isDrawerOpen =
      false; // added to prevent multiple drawers open simultaneously
  void _showNearbyForests() {
    if (_userLocation == null || _isDrawerOpen) {
      // Handle the case where user location is not available
      return;
    }

    _isDrawerOpen = true;

    List<TinyForest> sortedForests = List.from(tForest);

    // Sort the list based on the distance to the user's location
    sortedForests.sort((forest1, forest2) {
      double distanceToUser1 = Geolocator.distanceBetween(
        _userLocation!.latitude,
        _userLocation!.longitude,
        forest1.coordinates['lat'] ?? 0.0,
        forest1.coordinates['lon'] ?? 0.0,
      );

      double distanceToUser2 = Geolocator.distanceBetween(
        _userLocation!.latitude,
        _userLocation!.longitude,
        forest2.coordinates['lat'] ?? 0.0,
        forest2.coordinates['lon'] ?? 0.0,
      );

      return distanceToUser1.compareTo(distanceToUser2);
    });

    showModalBottomSheet(
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showPlanted = true;
                            showPlanned = false;
                          });
                        },
                        child: Text(AppLocalizations.of(context)!.plantedLabel),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showPlanted = false;
                            showPlanned = true;
                          });
                        },
                        child: Text(AppLocalizations.of(context)!.plannedLabel),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showPlanted = false;
                            showPlanned = false;
                          });
                        },
                        child: Text(AppLocalizations.of(context)!.allLabel),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sortedForests.length,
                      itemBuilder: (BuildContext context, int index) {
                        TinyForest forest = sortedForests[index];

                        // Check the filter conditions
                        if ((showPlanted && forest.planted) ||
                            (showPlanned && !forest.planted) ||
                            (!showPlanted && !showPlanned)) {
                          return TinyForestCard(
                            forest,
                            onPlantedIconClick: () {
                              _showForestDetails(forest);
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      context: context,
    );
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
