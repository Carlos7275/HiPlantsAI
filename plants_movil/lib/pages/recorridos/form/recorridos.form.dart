import 'dart:async';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plants_movil/customicons/leaf_icon_icons.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/models/Recorridos.model.dart';
import 'package:plants_movil/pages/recorridos/form/recorridos.controller.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:plants_movil/widgets/space/space.widget.dart';

class RecorridosForm extends StatefulWidget {
  const RecorridosForm({super.key});

  @override
  State<RecorridosForm> createState() => _RecorridosFormState();
}

class _RecorridosFormState
    extends Stateful<RecorridosForm, RecorridosController> {
  final MapController mapController = MapController();
  LatLng ubicacionActual = const LatLng(0, 0);
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    inicializarMapa();
    setState(() {});
  }

  void inicializarMapa() async {
    try {
      //Si no es web preguntar permisos
      if (!kIsWeb) {
        await preguntarPermisos();
      }
      await obtenerUbicacionUsuario();
    } finally {
      setState(() {
        cargando = false;
      });
    }
  }

  Widget buildMarkers() {
    for (var markerData in controller.puntos) {
      print(markerData.idPlanta);
    }
    return MarkerLayer(
      markers: [
        if (!cargando)
          Marker(
            point: ubicacionActual,
            width: 70,
            height: 70,
            child: const Icon(Icons.account_circle, color: Colors.blue),
          ),
        for (var markerData in controller.puntos)
          Marker(
              point: LatLng(markerData.latitud, markerData.longitud),
              width: 40,
              height: 40,
              child: IconButton(
                  onPressed: () {
                    mostrarInformacionDePlanta(markerData);
                  },
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0.0),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                  icon: const Icon(LeafIcon.leaf,
                      color: Enviroment.secondaryColor)))
      ],
    );
  }

  Future<void> preguntarPermisos() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await preguntarPermisos();
    } else if (status == PermissionStatus.granted) {
      await obtenerUbicacionUsuario();
    }
  }

  Future<void> obtenerUbicacionUsuario() async {
    StreamSubscription<Position>? locationSubscription;

    void handleLocationChanged(Position position) {
      if (kDebugMode) {
        print("Se actualizo la posición: $position");
      }

      setState(() {
        ubicacionActual = LatLng(position.latitude, position.longitude);
      });
    }

    void handleLocationError(dynamic error) {
      if (kDebugMode) {
        print("Error al obtener la localización: $error");
      }
    }

    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const settings = LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0);

      locationSubscription = Geolocator.getPositionStream(
        locationSettings: settings,
      ).listen(
        handleLocationChanged,
        onError: handleLocationError,
      );
    } else {}

    // Cancel the location subscription when the widget is disposed.
    locationSubscription?.onDone(() {
      locationSubscription?.cancel();
    });
  }

  Future asignarUbicacion() async {
    mapController.move(ubicacionActual, 18);
  }

  Future<void> mostrarInformacionDePlanta(Recorridos infoPlanta) async {
    showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Planta ${infoPlanta.nombrePlanta}"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Colors.transparent, // Para que el fondo sea transparente
                  radius: 100,
                  backgroundImage: NetworkImage(
                    Enviroment.server + infoPlanta.urlImagen,
                  ),
                ),
                Text(
                    "Tiempo acumulado de observacion: ${infoPlanta.tiempo} segundos",
                    textAlign: TextAlign.left),
                Text("Zona: ${infoPlanta.zona}", textAlign: TextAlign.left),
                Space.espaciador(15),
                Text("Nombre científico: ${infoPlanta.nombreCientifico}",
                    textAlign: TextAlign.left),
                Space.espaciador(10),
                Text("Año de publicación del nombre: ${infoPlanta.anio}",
                    textAlign: TextAlign.left),
                Space.espaciador(6),
                Space.espaciador(6),
                Text("Familia: ${infoPlanta.familia}",
                    textAlign: TextAlign.left),
                Space.espaciador(10),
                Text("Tóxica: ${infoPlanta.toxicidad}",
                    textAlign: TextAlign.left),
                Space.espaciador(10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: controller.isLoading$,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.data!) {
            return Form(
              key: controller.formKey,
              child: Column(
                children: [
                  DateTimePicker(
                    controller: controller.fechainicialcontroller,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Fecha de inicio',
                    validator: Utilities.fechaValidator,
                    icon: const Icon(Icons.date_range),
                  ),

                  DateTimePicker(
                    controller: controller.fechafinalcontroller,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Fecha final',
                    validator: Utilities.fechaValidator,
                    icon: const Icon(Icons.date_range),
                  ),
                  Space.espaciador(10),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.search),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    )),
                    onPressed: () => setState(() {
                      controller.enviar(context);
                    }),
                    label: const Column(
                      children: [
                        Text(
                          "Consultar recorridos",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  Space.espaciador(50), //e|spaciado

                  SizedBox(
                    width: 800,
                    height: 500,
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
                          tileProvider: CancellableNetworkTileProvider(),
                        ),
                        buildMarkers(),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await asignarUbicacion();
                      },
                      backgroundColor: Enviroment.primaryColor,
                      child: const Icon(Icons.gps_fixed_outlined),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    strokeWidth: 5),
              ),
            );
          }
        });
  }
}
