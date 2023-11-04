import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  String? path;
  final MapController _mapController = MapController();
  LatLng _currentLocation =
      const LatLng(25.781862, -108.990188); // Ubicación inicial en el ecuador

  Future<void> getPath() async {
    final cacheDirectory = await getTemporaryDirectory();
    path = cacheDirectory.path;
  }

  @override
  void initState() {
    super.initState();
    askPermission();
    getPath();
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
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
    }
  }

  Future<void> _getUserLocation() async {
    const settings = LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
    );
    Geolocator.getPositionStream(locationSettings: settings).listen((position) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
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

              return Center(
                child: SizedBox(
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
                          userAgentPackageName: "com.example.app",
                          tileProvider: CachedTileProvider(
                            // maxStale keeps the tile cached for the given Duration and
                            // tries to revalidate the next time it gets requested
                            maxStale: const Duration(days: 30),
                            store: HiveCacheStore(
                              path,
                              hiveBoxName: 'HiveCacheStore',
                            ),
                          ),
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
