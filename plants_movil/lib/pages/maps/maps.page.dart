import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final MapController _mapController = MapController();
  LatLng _currentLocation =
      const LatLng(25.781862, -108.990188); // Ubicación inicial en el ecuador

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> askPermission() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.denied:
        askPermission();
        break;
      case PermissionStatus.granted:
        _getUserLocation();
        break;
      case PermissionStatus.restricted:
      // TODO: Handle this case.
      case PermissionStatus.limited:
      // TODO: Handle this case.
      case PermissionStatus.permanentlyDenied:
      // TODO: Handle this case.
      case PermissionStatus.provisional:
      // TODO: Handle this case.
    }
    ;
  }

  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double mapWidth, mapHeight;
              if (orientation == Orientation.portrait) {
                mapWidth = constraints.maxWidth;
                mapHeight = constraints.maxHeight * 0.7;
              } else {
                mapWidth = constraints.maxWidth * 0.7;
                mapHeight = constraints.maxHeight;
              }

              return SizedBox(
                width: mapWidth,
                height: mapHeight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                        initialCenter: _currentLocation, initialZoom: 10),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentLocation,
                            width: 90,
                            height: 90,
                            child: const Icon(Icons.account_circle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
