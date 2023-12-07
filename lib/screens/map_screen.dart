// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; //  package for handling latitude and longitude
import 'package:tinyforests/widgets/builderitems.dart';

// screen for displaying a map with a marker for each forest, right now is hard coded
// but this should get the coordinates from the forest Class tobe implemented
class ForestMaps extends StatefulWidget {
  const ForestMaps({super.key});

  @override
  State<ForestMaps> createState() => _ForestMapsState();
}

class _ForestMapsState extends State<ForestMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FlutterMap widget for displaying the map as in the documentation
          FlutterMap(
            options: const MapOptions(
              initialCenter:
                  LatLng(53.8956, 14.7294), // initial center of the map
              initialZoom: 3.2, // initial zoom of the map
            ),
            children: [
              //  map tiles from OpenStreetMap
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              //  adding a marker to the map
              MarkerLayer(
                markers: [
                  // Marker at a specific point with a custom image Default.png as icon
                  Marker(
                    point: const LatLng(53.8956, 14.7294),
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      './images/trees/Default.png',
                      width: 10,
                      height: 10,
                      color: Color.fromARGB(255, 47, 136, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          bottomNaviBar(context), // the custom bottom navigation bar
    );
  }
}
