import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tinyforests/widgets/builderitems.dart';

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
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(53.8956, 14.7294),
              initialZoom: 3.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              //// TODO how to change stupid logo https://docs.fleaflet.dev/layers/marker-layer
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(53.8956, 14.7294),
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'images/trees/Default.png',
                      width: 15,
                      height: 15,
                      color: Color.fromARGB(255, 47, 136, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
