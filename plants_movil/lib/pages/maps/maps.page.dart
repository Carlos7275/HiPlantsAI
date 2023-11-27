import 'dart:async';
import 'package:app_settings/app_settings.dart';
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
import 'package:plants_movil/widgets/voz/voz.widget.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final MapController _mapController = MapController();
  List<Mapa> puntos = List.empty();
  LatLng currentLocation = const LatLng(25.781862, -108.990188);

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await obtenerPlantasActivas();
    await preguntarPermisos();
    await obtenerUbicacionUsuario();
  }

  Future<void> preguntarPermisos() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await preguntarPermisos();
    } else if (status == PermissionStatus.granted) {
      await obtenerUbicacionUsuario();
    }
  }

  Future<void> obtenerPlantasActivas() async {
    puntos = await MapaService().obtenerPlantasActivas();
  }

  Future<void> obtenerUbicacionUsuario() async {
    StreamSubscription<Position>? locationSubscription;

    void handleLocationChanged(Position position) {
      print("Location changed: $position");
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
    }

    void handleLocationError(dynamic error) {
      print("Error obtaining location: $error");
      mostrarAlertaActivarGPS();
    }

    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const settings =
          LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

      locationSubscription = Geolocator.getPositionStream(
        locationSettings: settings,
      ).listen(
        handleLocationChanged,
        onError: handleLocationError,
      );
    } else {
      // If location service is not enabled, prompt the user to enable it.
      print("Location service is not enabled. Showing alert.");
      mostrarAlertaActivarGPS();
    }

    // Cancel the location subscription when the widget is disposed.
    locationSubscription?.onDone(() {
      print("Location subscription canceled.");
      locationSubscription?.cancel();
    });

    setState(() {});
  }

  void mostrarAlertaActivarGPS() {
    final currentContext = context;

    showDialog(
      context: currentContext,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GPS Desactivado'),
          content: const Text(
            'Por favor, active el GPS para poder utilizar el mapa.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Configuración'),
              onPressed: () async {
                await AppSettings.openAppSettings(
                    type: AppSettingsType.location);

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildMarkers() {
    return MarkerLayer(
      markers: [
        Marker(
          point: currentLocation,
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
      body: Stack(children: [
        OrientationBuilder(
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
                return Row(
                  children: [
                    Center(
                      child: SizedBox(
                        width: mapWidth,
                        height: mapHeight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: currentLocation,
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
                              buildMarkers(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      Voz()
      ]),
    );
  }
}
