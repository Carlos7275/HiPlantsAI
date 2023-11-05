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
      const LatLng(25.781862, -108.990188); // Ubicación inicial en mochis

  @override
  void initState() {
    super.initState();
    preguntarPermisos();
  }

/*Sobreescritura de metodo setState con validacion para volver a inicializar el }
widget
*/
  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> preguntarPermisos() async {
    final status = await Permission.location.request();
    if (status case PermissionStatus.denied) {
      preguntarPermisos();
    } else if (status case PermissionStatus.granted) {
      obtenerUbicacionUsuario();
    }
  }

  Future<void> obtenerUbicacionUsuario() async {
    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const settings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      //Obtiene la Ubicacion en tiempo real
      Geolocator.getPositionStream(locationSettings: settings)
          .listen((position) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
      });
    } else {
      preguntarPermisos();
    }
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
                mapHeight = constraints.maxHeight * 0.65;
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
                          initialCenter: _currentLocation, initialZoom: 10),
                      children: [
                        TileLayer(
                          userAgentPackageName: "com.example.app",
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
