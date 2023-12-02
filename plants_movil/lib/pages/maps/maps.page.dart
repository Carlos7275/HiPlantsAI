import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/models/Distancias.model.dart';
import 'package:plants_movil/models/Mapa.model.dart';
import 'package:plants_movil/models/Requests/Recorrido.model.dart';
import 'package:plants_movil/services/mapa.service.dart';
import 'package:plants_movil/customicons/leaf_icon_icons.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:plants_movil/widgets/voz/voz.widget.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  LatLng ubicacionActual = const LatLng(0, 0);
  List<Mapa> puntos = List.empty();
  List<dynamic> plantaCercana = [];
  List<dynamic> ultimaplantaCercana = [];
  bool cargando = true;
  Stopwatch sw = Stopwatch();
  bool estaCorriendoStopwatch = false;
  final MapController mapController = MapController();
  Distancias? distancias;

  @override
  void initState() {
    super.initState();
    inicializarMapa();
  }

  void inicializarMapa() async {
    try {
      distancias = await obtenerDistancias();
      //Si no es web preguntar permisos
      if (!kIsWeb) {
        await preguntarPermisos();
      }
      await obtenerUbicacionUsuario();
      await obtenerPlantasActivas();
    } finally {
      setState(() {
        cargando = false;
      });
    }
  }

  Future<Distancias> obtenerDistancias() async {
    return await UsuarioService().obtenerDistancias();
  }

  Future<void> preguntarPermisos() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await preguntarPermisos();
    } else if (status == PermissionStatus.granted) {
      await obtenerUbicacionUsuario();
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> obtenerPlantasActivas() async {
    puntos = await MapaService().obtenerPlantasActivas();
  }

  Future<void> obtenerUbicacionUsuario() async {
    StreamSubscription<Position>? locationSubscription;

    void handleLocationChanged(Position position) {
      if (kDebugMode) {
        print("Se actualizo la posición: $position");
      }
      setState(() {
        ubicacionActual = LatLng(position.latitude, position.longitude);
        busquedaPlantasCercanas(position);
      });
    }

    void handleLocationError(dynamic error) {
      if (kDebugMode) {
        print("Error al obtener la localización: $error");
      }
      mostrarAlertaActivarGPS();
    }

    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const settings = LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);

      locationSubscription = Geolocator.getPositionStream(
        locationSettings: settings,
      ).listen(
        handleLocationChanged,
        onError: handleLocationError,
      );
    } else {
      mostrarAlertaActivarGPS();
    }

    // Cancel the location subscription when the widget is disposed.
    locationSubscription?.onDone(() {
      locationSubscription?.cancel();
    });
  }

  void busquedaPlantasCercanas(Position position) async {
    //Guardamos las distancias de cada planta con respecto a nuestra posición
    List<dynamic> distanciasPlantas = puntos.map((e) {
      return {
        'id': e.id,
        'distancia': Geolocator.distanceBetween(
            position.latitude, position.longitude, e.latitud!, e.longitud!),
      };
    }).toList();

    //Comparamos las distancias respecto a las distancias minimas y maximas que tenemos definida en la BD

    plantaCercana = distanciasPlantas
        .where((element) =>
            element["distancia"] >= distancias!.distanciamin &&
            element["distancia"] <= distancias!.distanciamax)
        .toList();

    print(plantaCercana);

    if (plantaCercana.isNotEmpty && plantaCercana != ultimaplantaCercana) {
      if (!estaCorriendoStopwatch) {
        sw.start();
        estaCorriendoStopwatch = true;
        ultimaplantaCercana = plantaCercana;
      }
    } else {
      if (estaCorriendoStopwatch) {
        sw.stop();
        estaCorriendoStopwatch = false;
        List<dynamic> puntosRecorridos =
            ultimaplantaCercana.map((e) => e['id']).toList();

        await MapaService().registrarRecorrido(
            RecorridoModel(puntosRecorridos, sw.elapsed.inSeconds));
        sw.reset();
      }
    }
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
        if (!cargando)
          Marker(
            point: ubicacionActual,
            width: 60,
            height: 60,
            child: const Icon(Icons.account_circle, color: Colors.blue),
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

  asignarUbicacion() {
    mapController.move(ubicacionActual, 18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await obtenerUbicacionUsuario();
              asignarUbicacion();
            },
            backgroundColor: Enviroment.primaryColor,
            child: const Icon(Icons.gps_fixed_outlined),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
            onPressed: () async {
              Modular.to.pushNamed('/registrarplanta');
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        ],
      ),
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
                      child: (cargando)
                          ? SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    strokeWidth: 5),
                              ),
                            )
                          : SizedBox(
                              width: mapWidth,
                              height: mapHeight,
                              child: FlutterMap(
                                mapController: mapController,
                                options: MapOptions(
                                  initialCenter: ubicacionActual,
                                  initialZoom: 12,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    subdomains: const ['a', 'b', 'c'],
                                    tileProvider:
                                        CancellableNetworkTileProvider(),
                                  ),
                                  buildMarkers(),
                                ],
                              ),
                            ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        const Voz()
      ]),
    );
  }
}
