import 'dart:async';
import 'dart:convert';
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
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/services/mapa.service.dart';
import 'package:plants_movil/customicons/leaf_icon_icons.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:plants_movil/widgets/space/space.widget.dart';
import 'package:plants_movil/widgets/voz/voz.widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:intl/intl.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List<dynamic>? distanciasPlantas;
  LatLng ubicacionActual = const LatLng(0, 0);
  List<Mapa> puntos = List.empty();
  List<dynamic> plantaCercana = [];
  List<dynamic> ultimaplantaCercana = [];
  bool cargando = true;
  Stopwatch sw = Stopwatch();
  bool estaCorriendoStopwatch = false;
  final MapController mapController = MapController();
  Distancias? distancias;
  bool? isAdmin;
  @override
  void initState() {
    super.initState();
    inicializarMapa();
  }

  void inicializarMapa() async {
    try {
      isAdmin = await esAdministrador();
      distancias = await obtenerDistancias();
      //Si no es web preguntar permisos
      if (!kIsWeb) {
        await preguntarPermisos();
      }
      await obtenerUbicacionUsuario();
      await obtenerPlantas();
    } finally {
      setState(() {
        cargando = false;
      });
    }
  }

  Future<void> obtenerPlantas() async {
    isAdmin! ? await obtenerTodasLasPlantas() : await obtenerPlantasActivas();
  }

  Future<Distancias> obtenerDistancias() async {
    return await UsuarioService().obtenerDistancias();
  }

  Future<bool> esAdministrador() async {
    Usuario infousuario = await UsuarioService().obtenerInfoUsuario();
    return (infousuario.idRol == 1);
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

  Future<void> obtenerTodasLasPlantas() async {
    puntos = await MapaService().obtenerTodasLasPlantas();
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
      const settings =
          LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 0);

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

  Future<void> mostrarInformacionDePlanta(Mapa infoPlanta) async {
    showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Planta ${infoPlanta.infoPlantas!.nombrePlanta!}"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Colors.transparent, // Para que el fondo sea transparente
                  radius: 100,
                  backgroundImage: NetworkImage(
                    Enviroment.server + infoPlanta.urlImagen!,
                  ),
                ),
                if (distanciasPlantas != null)
                  Text(
                      "Se encuentra a : ${distanciasPlantas!.where((element) => element['id'] == infoPlanta.id).first['distancia']} metros de su posición",
                      textAlign: TextAlign.left),
                Space.espaciador(10),
                Text("Zona: ${infoPlanta.zona!}", textAlign: TextAlign.left),
                Space.espaciador(15),
                Text(
                    "Nombre científico: ${infoPlanta.infoPlantas!.nombreCientifico!}",
                    textAlign: TextAlign.left),
                Space.espaciador(10),
                Text(
                    "Año de publicación del nombre: ${infoPlanta.infoPlantas!.aO!}",
                    textAlign: TextAlign.left),
                Space.espaciador(6),
                if (infoPlanta.infoPlantas!.nombresComunes!.spa != null)
                  Text(
                      "Nombres comunes: ${infoPlanta.infoPlantas!.nombresComunes!.spa!.join(", ")}",
                      textAlign: TextAlign.left),
                Space.espaciador(6),
                if (infoPlanta.infoPlantas!.familia != null)
                  Text("Familia: ${infoPlanta.infoPlantas!.familia!}",
                      textAlign: TextAlign.left),
                Space.espaciador(10),
                if (infoPlanta.infoPlantas!.toxicidad != null)
                  Text("Tóxica: ${infoPlanta.infoPlantas!.toxicidad!}",
                      textAlign: TextAlign.left),
                Space.espaciador(5),
                if (infoPlanta.infoPlantas!.comestible != null)
                  Text(
                      "Comestible: ${infoPlanta.infoPlantas!.comestible! ? "Si" : "No"}",
                      textAlign: TextAlign.left),
                Space.espaciador(5),
                Text("Genero: ${infoPlanta.infoPlantas!.genero!}",
                    textAlign: TextAlign.left),
                Space.espaciador(5),
                Text(
                  "Fecha de registro: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(infoPlanta.createdAt!))}",
                  textAlign: TextAlign.left, // Alinea el texto a la izquierda
                ),
                Space.espaciador(10),
                Space.espaciador(10),
                Text(
                  (infoPlanta.estatus == 1)
                      ? "Estatus: Activo"
                      : "Estatus: Inactivo",
                )
              ],
            ),
          ),
          actions: <Widget>[
            if (isAdmin!)
              ElevatedButton(
                onPressed: () {
                  cambiarEstatusPlanta(infoPlanta.id!);
                  inicializarMapa();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Fondo verde
                  foregroundColor: Colors.black, // Texto blanco
                ),
                child: const Text('Cambiar Estatus'),
              ),
          ],
        );
      },
    );
  }

  void cambiarEstatusPlanta(int idPlanta) {
    MapaService().cambiarEstatus(idPlanta).then((value) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: "¡Operación Exitosa!",
          text: value["data"]);
    }).catchError((error) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: jsonDecode(error.body)["message"],
        showConfirmBtn: true,
      );
    });
    Navigator.pop(context);
  }

  void busquedaPlantasCercanas(Position position) async {
    if (!cargando) {
      //Guardamos las distancias de cada planta con respecto a nuestra posición
      distanciasPlantas = puntos.map((e) {
        return {
          'id': e.id,
          'distancia': Geolocator.distanceBetween(
              position.latitude, position.longitude, e.latitud!, e.longitud!),
        };
      }).toList();

      //Comparamos las distancias respecto a las distancias minimas y maximas que tenemos definida en la BD

      plantaCercana = distanciasPlantas!
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
              width: 40,
              height: 40,
              child: IconButton(
                  onPressed: () {
                    mostrarInformacionDePlanta(markerData);
                  },
                  iconSize: 30,
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0.0),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                  icon: Icon(LeafIcon.tree_2,
                      color: markerData.estatus == 0
                          ? Colors.grey
                          : Enviroment.secondaryColor)))
      ],
    );
  }

  asignarUbicacion() async {
    mapController.move(ubicacionActual, 18);
    inicializarMapa();
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
              await asignarUbicacion();
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
