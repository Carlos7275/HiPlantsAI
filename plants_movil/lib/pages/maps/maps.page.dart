import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/models/Mapa.model.dart';
import 'package:plants_movil/services/mapa.service.dart';
import 'package:plants_movil/customicons/leaf_icon_icons.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final MapController _mapController = MapController();
  List<Mapa> puntos = List.empty();
  LatLng _currentLocation = const LatLng(25.781862, -108.990188);

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await _obtenerPlantasActivas();
    await _preguntarPermisos();
    await _obtenerUbicacionUsuario();
  }

  Future<void> _preguntarPermisos() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await _preguntarPermisos();
    } else if (status == PermissionStatus.granted) {
      await _obtenerUbicacionUsuario();
    }
  }

  Future<void> _obtenerPlantasActivas() async {
    puntos = await MapaService().obtenerPlantasActivas();
  }

  Future<void> _obtenerUbicacionUsuario() async {
    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const settings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      Geolocator.getPositionStream(locationSettings: settings)
          .listen((position) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
      });
    } else {
      await _preguntarPermisos();
    }
  }

  Widget _buildMarkers() {
    return MarkerLayer(
      markers: [
        Marker(
          point: _currentLocation,
          width: 60,
          height: 60,
          child: const Icon(Icons.account_circle,
              color: Enviroment.secondaryColor),
        ),
        for (var markerData in puntos)
          Marker(
            point: LatLng(markerData.latitud!, markerData.longitud!),
            width: 100,
            height: 100,
            child:
                const Icon(LeafIcon.tree_2, color: Enviroment.secondaryColor),
          ),
      ],
    );
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
                mapHeight = constraints.maxHeight * 0.75;
              } else {
                mapWidth = constraints.maxWidth * 0.85;
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
                        initialCenter: _currentLocation,
                        initialZoom: 10,
                      ),
                      children: [
                        TileLayer(
                          userAgentPackageName: "com.example.app",
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                          tileProvider:
                              FMTC.instance('mapStore').getTileProvider(),
                        ),
                        _buildMarkers(),
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
